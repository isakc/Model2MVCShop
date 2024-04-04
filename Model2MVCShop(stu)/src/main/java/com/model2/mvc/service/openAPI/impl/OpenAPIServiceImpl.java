package com.model2.mvc.service.openAPI.impl;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;

import org.springframework.stereotype.Service;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.model2.mvc.service.domain.DailyBoxOffice;
import com.model2.mvc.service.openAPI.OpenAPIService;
import com.squareup.okhttp.OkHttpClient;
import com.squareup.okhttp.Request;
import com.squareup.okhttp.Response;

@Service("openAPIServiceImpl")
public class OpenAPIServiceImpl implements OpenAPIService {
	///Field
	final String key = "183da6c4fa3be1aadb21ae6ca7cdf1c0";
	
	
	///Constructor
	public OpenAPIServiceImpl() {
	}

	///Method
	@Override
	public List<DailyBoxOffice> getMoiveList() throws Exception {
		Calendar cal = Calendar.getInstance();
        cal.add(Calendar.DAY_OF_MONTH, -1);
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMdd");
	    String targetDt = dateFormat.format(cal.getTime());
		
		String apiURL = "http://www.kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key="+key+"&targetDt="+targetDt;
		
		URL url = new URL(apiURL);
		
		BufferedReader bf = new BufferedReader(new InputStreamReader(url.openStream(), "UTF-8"));

		String result = bf.readLine();
		ObjectMapper mapper = new ObjectMapper();
		HashMap<String,Object> dailyResult = mapper.readValue(result, HashMap.class);
		HashMap<String, Object> boxOfficeResult = (HashMap<String, Object>) dailyResult.get("boxOfficeResult");
		ArrayList<HashMap<String, Object>> dailyBoxOfficeList = (ArrayList<HashMap<String, Object>>) boxOfficeResult.get("dailyBoxOfficeList");
		
//		for(HashMap<String, Object> map: dailyBoxOfficeList) {
//			String movieNm = (String) map.get("movieNm");
//			apiURL = "https://api.themoviedb.org/3/search/movie?query="+URLEncoder.encode(movieNm)+"&include_adult=false&language=en-US&page=1";
//			url = new URL(apiURL);
//			
//			HttpURLConnection connection = (HttpURLConnection) url.openConnection();
//			connection.setRequestMethod("GET");
//			String token = "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJkYjEzOTEzM2YyZjMwYjllN2U0MjdkZDliOGEzMmU3NiIsInN1YiI6IjY2MGI0ZTJjZDZkYmJhMDE0YTZmMTA1YSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.Qjec18AnxU4brNq_usPvc7jUYRLWy2naBcSpVNg2e_c";
//            connection.setRequestProperty("Authorization", token);
//            connection.setRequestProperty("accept", "application/json");
//			
//            BufferedReader in = new BufferedReader(new InputStreamReader(connection.getInputStream()));
//            String inputLine;
//            StringBuilder response = new StringBuilder();
//            while ((inputLine = in.readLine()) != null) {
//                response.append(inputLine);
//            }
//			
//			//System.out.println(map.get("movieNm"));
//		}
		
		List<DailyBoxOffice> dailyBoxOffices = new ArrayList<>();
		
		for (HashMap<String, Object> movie : dailyBoxOfficeList) {
			DailyBoxOffice dailyBoxOffice = mapper.convertValue(movie, DailyBoxOffice.class);
		    dailyBoxOffices.add(dailyBoxOffice);
		}
		
		return dailyBoxOffices;
	}
}