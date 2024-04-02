package com.model2.mvc.service.openAPI.impl;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.URL;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;

import org.springframework.stereotype.Service;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.model2.mvc.service.domain.DailyBoxOffice;
import com.model2.mvc.service.openAPI.OpenAPIService;

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

		List<DailyBoxOffice> dailyBoxOffices = new ArrayList<>();
		
		for (HashMap<String, Object> movie : dailyBoxOfficeList) {
			DailyBoxOffice dailyBoxOffice = mapper.convertValue(movie, DailyBoxOffice.class);
		    dailyBoxOffices.add(dailyBoxOffice);
		}
		
		return dailyBoxOffices;
	}
}