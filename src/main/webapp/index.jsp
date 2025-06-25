<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Weather App</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(to right, #00c6ff, #0072ff);
            color: white;
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .mainContainer {
            background-color: rgba(255, 255, 255, 0.1);
            padding: 30px;
            border-radius: 15px;
            width: 100%;
            max-width: 500px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.3);
            text-align: center;
        }

        .searchInput {
            display: flex;
            justify-content: center;
            margin-bottom: 20px;
        }

        #searchInput {
            padding: 10px;
            border: none;
            border-radius: 10px 0 0 10px;
            width: 70%;
            font-size: 16px;
        }

        #searchButton {
            padding: 10px 15px;
            border: none;
            border-radius: 0 10px 10px 0;
            background-color: #fff;
            color: #0072ff;
            cursor: pointer;
        }

        .weatherIcon img {
            width: 100px;
            height: 100px;
        }

        .weatherDetails h2 {
            margin: 10px 0;
        }

        .cityDetails {
            margin: 10px 0;
            font-size: 18px;
        }

        .windDetails {
            display: flex;
            justify-content: space-around;
            margin-top: 20px;
        }

        .humidityBox, .windSpeed {
            display: flex;
            flex-direction: column;
            align-items: center;
        }

        .humidityBox img, .windSpeed img {
            width: 40px;
            height: 40px;
            margin-bottom: 5px;
        }

        .humidityBox span, .windSpeed span {
            font-size: 14px;
            opacity: 0.8;
        }
    </style>
</head>
<body>

<div class="mainContainer">
    <form action="WeatherServlet" method="post" class="searchInput">
        <input type="text" placeholder="Enter City Name" id="searchInput"  name="city"/>
        <button id="searchButton" type="submit">
            <i class="fa-solid fa-magnifying-glass"></i>
        </button>
    </form>

    <div class="weatherDetails">
        <div class="weatherIcon">
            <img src="" alt="Weather Icon" id="weather-icon"/>
            <h2>${temperature} °C</h2>
            <input type="hidden" id="wc" value="${weatherCondition}"/>
        </div>

        <div class="cityDetails">
            <div class="desc"><strong>${city}</strong></div>
            <div class="date">${date}</div>
        </div>

        <div class="windDetails">
            <div class="humidityBox">
                <img src="https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhgr7XehXJkOPXbZr8xL42sZEFYlS-1fQcvUMsS2HrrV8pcj3GDFaYmYmeb3vXfMrjGXpViEDVfvLcqI7pJ03pKb_9ldQm-Cj9SlGW2Op8rxArgIhlD6oSLGQQKH9IqH1urPpQ4EAMCs3KOwbzLu57FDKv01PioBJBdR6pqlaxZTJr3HwxOUlFhC9EFyw/s320/thermometer.png" alt="Humidity Icon"/>
                <span>Humidity</span>
                <h2>${humidity}%</h2>
            </div>
            <div class="windSpeed">
                <img src="https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEiyaIguDPkbBMnUDQkGp3wLRj_kvd_GIQ4RHQar7a32mUGtwg3wHLIe0ejKqryX8dnJu-gqU6CBnDo47O7BlzCMCwRbB7u0Pj0CbtGwtyhd8Y8cgEMaSuZKrw5-62etXwo7UoY509umLmndsRmEqqO0FKocqTqjzHvJFC2AEEYjUax9tc1JMWxIWAQR4g/s320/wind.png" alt="Wind Speed Icon"/>
                <span>Wind Speed</span>
                <h2>${WindSpeed} km/h</h2>
            </div>
        </div>
    </div>
</div>

<script>
    const weatherIcon = document.getElementById("weather-icon");
    const condition = document.getElementById("wc").value;

    const iconMap = {
        "Clouds": "https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEiwFTkt5z_dxU6w1UnS1PxiZV3HDiPGsAW5Lrsp09MnlCmkQre9GzO8MnGytaaY1eZoqBN6SMJ4U578_uDtiuXswovr1T3o-Kt5KK0mlN_zC0RDodJFaKHQ3Uk-HIZ3vuMvAKNJi8DDFwWA7F6BOxz78Oh-UePwJTuc3PG0ZIZypPE1xlMPl5z46joaEw/s320/Clouds.png",
        "Clear": "https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEj7pmzNCftryAfpa1YBSzVeYtjgxDQnw09Ug0HVV47J8GEtHPYTH9hJgZ2M1k0YgE0pcZ1qekr4C14zyPCiVuQAfXLClK8Ww3hYB6v77yElP7Lo5BnUKo4n-w6yB17FAbw51WST6YKS0GMwyA4fYNxOZxEyNL6HhUfFRgVhOW0GyRdBRriMHFQ-qfh4cA/s320/sun.png",
        "Rain": "https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgDW_NdwvxV796rkFf43qmUDiTQePn5dg7PDfn1SijfpjtB0AWJMBcifU6LWyW7iOtjZhfqIJnKEGQ1PwbbXS7NoKMSAmvy7i2ljWXMYLue3EBIBBR2qTFbs6QCe5eoFr2CU9WzCVJ8u0J3z3eAo3Ajv1LXamZASFtbj9sA_gD-Kp3hfgAk17Xh17RoLQ/s320/rainy.png",
        "Mist": "https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgVpL23l0t1U_ibWi01TFcHMF6J_t-9Ada5PavGlwG4M_mKIcx0pV1md9SN9ip1d84NaVowml5Do16XO3nsuttnM2-Ov05d-wCjEYjdzaOYfKvijw8k6Hfj9pOiPyEZTp2W20EPbTeONTgJE2Rdxs4KZUfg6f2PmbMF1094NcqJ7DwSFUQwYiRmVCNvuA/s320/mist.png",
        "Snow": "https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEj-P3iT_uQK95qFY4h7QGdEtbRc1aVQo9BZy0ZWyPBvCNrP-4wnRStw0xYj9e4xa4ZlYISeNZqVJ33UP4YukR4jBennDD_obIN4QxYNZHdzG_z6_MNL2U08wMXwdFhtfvitW5LGiHgrwMJFC8QJFqbSO3woGSBqOdagGxaEQ20_S31Gc-GYL4vYzPzaPw/s320/snow.png",
        "Haze": "https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjld66Ia5g_hpBn3Impi3zzOBHqWkjQInGLxTb2uXksuCsrkQU8HjlVyLobEJEGg8fRSIxeFzldGEHUmWcaiZBwAcRy4dGDpFX1BjTSB56qmBjW5tEW3RSC9_mCuLU_a8RuXchxGY7Oc8HLLl-IfaDW19Z0ZJJfNae9tECXRIyEu7rmJ3da08z8cI-phw/s320/haze.png"
    };

    weatherIcon.src = iconMap[condition] || '';
</script>

</body>
</html>