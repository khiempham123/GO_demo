import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'animated_indexed_stack.dart';
import 'base_model.dart';
import 'exception.dart';

abstract class BaseState<M extends BaseModel, W extends StatefulWidget>
    extends State<W> {
  late M model;
  BuildContext? _loadingDialogContext;

  @override
  void initState() {
    super.initState();
    model = createModel();
    model.notifier = ValueNotifier(null);
    onModelReady();
  }

  bool get isSliverOverlapAbsorber => false;

  Color get backgroundColor => Colors.white;

  bool get disposeModel => true;

  bool get autoCreateLeading => true;

  bool get onlyErrorContent => true;

  Widget get loadingWidget => Material(
    color: backgroundColor,
    child: const Center(child: CircularProgressIndicator()),
  );

  @override
  void dispose() {
    super.dispose();
    if (disposeModel) model.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return buildContent();
  }

  Widget buildContent() {
    return ChangeNotifierProvider<M>.value(
      value: model,
      child: Consumer<M>(
        builder: (context, model, child) => buildViewByState(context, model),
      ),
    );
  }

  Widget buildViewByState(BuildContext context, M model) {
    int idx = _getIndex(model.viewState);
    return ColoredBox(
      color: backgroundColor,
      child: AnimatedIndexedStack(
        index: idx,
        children: [
          const SizedBox(),
          enabledUnitTest ? const SizedBox() : loadingWidget,
          buildProgressByState(context, model),
          buildError(context),
        ],
      ),
    );
  }

  Widget buildError(BuildContext context) {
    late Widget content;

    content = ExceptionWidget(
      exception: model.responseError1,
      onRetry: onRetry,
    );

    if (onlyErrorContent) {
      return SafeArea(child: Center(child: content));
    }
    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: autoCreateLeading),
      body: SafeArea(child: Center(child: content)),
    );
  }

  int _getIndex(ViewState? state) {
    switch (state) {
      case ViewState.loading:
        return 1;
      case ViewState.error:
        return 3;
      case ViewState.loaded:
        return 2;
      default:
        return 0;
    }
  }

  Widget buildProgressByState(BuildContext context, M model) {
    return buildContentView(context, model);
  }

  void showLoading({BuildContext? dialogContext}) async {
    if (_loadingDialogContext != null) {
      return;
    }
    _loadingDialogContext = dialogContext ?? context;

    await showDialog(
      barrierDismissible: false,
      context: _loadingDialogContext!,
      useRootNavigator: false,
      builder: (_) => const LoadingDialog(),
    );

    _loadingDialogContext = null;
  }

  void hideLoading() {
    if (_loadingDialogContext == null) {
      return;
    }

    Navigator.of(_loadingDialogContext!).pop();
    _loadingDialogContext = null;
  }

  M createModel();

  Widget buildContentView(BuildContext context, M model);

  void onModelReady() {}

  void onRetry() {}
}

mixin BaseAutomaticKeepAliveClientMixin<
  M extends BaseModel,
  T extends StatefulWidget
>
    on BaseState<M, T> {}

class LoadingDialog extends StatelessWidget {
  const LoadingDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator());
  }
}

bool enabledUnitTest = false;

class ExceptionWidget extends StatelessWidget {
  final VoidCallback? onRetry;
  final RException? exception;
  const ExceptionWidget({super.key, this.onRetry, required this.exception});

  @override
  Widget build(BuildContext context) {
    final content = exception?.message;
    if (content == null) {
      return const SizedBox();
    }

    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.add_alert, size: 48),
          SizedBox(height: 12),
          Text(content, textAlign: TextAlign.center),
          SizedBox(height: 12),
          Text("Xin vui lòng thử lại", textAlign: TextAlign.center),
          SizedBox(height: 12),
          onRetry == null
              ? const SizedBox()
              : ElevatedButton(onPressed: onRetry, child: Icon(Icons.refresh)),
        ],
      ),
    );
  }
}
