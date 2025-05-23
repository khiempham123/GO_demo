<!DOCTYPE html>
<html>
<head>
    <title>Weather Test</title>
</head>
<body>
    <h1>Weather App Test</h1>
    <input type="text" id="city" placeholder="Enter city name" value="Ho Chi Minh City">
    <button onclick="getWeather()">Get Weather</button>
    <div id="result"></div>

    <script>
        async function getWeather() {
            const city = document.getElementById('city').value;
            const apiKey = "f939c51106acbb1ed47bec69921ec8f2";

            try {
                const response = await fetch(
                    `http://127.0.0.1:5001/myproject-112f3/us-central1/weatherProxy?q=${city}&appid=${apiKey}&units=metric&cnt=40`
                );
                const data = await response.json();
                document.getElementById('result').innerHTML = JSON.stringify(data, null, 2);
            } catch (error) {
                document.getElementById('result').innerHTML = 'Error: ' + error.message;
            }
        }
    </script>
</body>
</html>