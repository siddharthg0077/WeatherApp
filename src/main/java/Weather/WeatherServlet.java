package Weather;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.Date;
import java.util.Scanner;

import com.google.gson.Gson;
import com.google.gson.JsonObject;

/**
 * Servlet implementation class WeatherServlet
 */
@WebServlet("/WeatherServlet")
public class WeatherServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public WeatherServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.sendRedirect("Index.html");
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	    String apiKey = "d8e8b2a720aa421bb18364c6e079e040";

	    String city = request.getParameter("city");
	   
	    

	    String apiUrl = "https://api.openweathermap.org/data/2.5/weather?q="+city+"&appid="+apiKey;

	    try {
	        URL url = new URL(apiUrl);
	        HttpURLConnection connection = (HttpURLConnection) url.openConnection();
	        connection.setRequestMethod("GET");

	        InputStream inputStream = connection.getInputStream();
	        Scanner scanner = new Scanner(new InputStreamReader(inputStream));
	        StringBuilder responseContent = new StringBuilder();

	        while (scanner.hasNext()) {
	            responseContent.append(scanner.nextLine());
	        }

	        scanner.close();
	        connection.disconnect();

	        Gson gson = new Gson();
	        JsonObject jsonobject = gson.fromJson(responseContent.toString(), JsonObject.class);

	        long dateTimestamp = jsonobject.get("dt").getAsLong() * 1000;
	        Date date = new Date(dateTimestamp);

	        double temperatureKelvin = jsonobject.getAsJsonObject("main").get("temp").getAsDouble();
	        int temperatureCelsius = (int) (temperatureKelvin - 273.15);

	        int humidity = jsonobject.getAsJsonObject("main").get("humidity").getAsInt();
	        double windSpeed = jsonobject.getAsJsonObject("wind").get("speed").getAsDouble();
	        String weatherCondition = jsonobject.getAsJsonArray("weather").get(0).getAsJsonObject().get("main").getAsString();

	        // Set attributes
	        request.setAttribute("date", date);
	        request.setAttribute("city", city);
	        request.setAttribute("temperature", temperatureCelsius);
	        request.setAttribute("weatherCondition", weatherCondition);
	        request.setAttribute("humidity", humidity);
	        request.setAttribute("windSpeed", windSpeed);
	        request.setAttribute("weatherData", responseContent.toString());

	        // Forward to JSP only after data is ready
	        

	    } catch (Exception e) {
	        e.printStackTrace(); // Logs full stack trace to console
	        response.sendRedirect("error.jsp"); // Optional: create an error.jsp to show friendly error
	    }
	    request.getRequestDispatcher("index.jsp").forward(request, response);
	}

}
