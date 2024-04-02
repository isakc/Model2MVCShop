package com.model2.mvc.service.openAPI.impl;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.URL;
import java.util.Arrays;
import java.util.List;

import org.codehaus.jackson.map.ObjectMapper;
import org.springframework.stereotype.Service;

import com.model2.mvc.service.domain.KobisAPI;
import com.model2.mvc.service.openAPI.OpenAPIService;

@Service("openAPIServiceImpl")
public class OpenAPIServiceImpl implements OpenAPIService {
	///Field
	final String key = "183da6c4fa3be1aadb21ae6ca7cdf1c0";
	String targetDt = "20240401";
	
	String apiURL = "http://www.kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key="+key+"&targetDt="+targetDt;
	
	///Constructor
	public OpenAPIServiceImpl() {
	}

	///Method
	@Override
	public List<KobisAPI> getMoiveList() throws Exception {
		
		URL url = new URL(apiURL);
		
		BufferedReader bf = new BufferedReader(new InputStreamReader(url.openStream(), "UTF-8"));

		String result = bf.readLine();
        ObjectMapper objectMapper = new ObjectMapper();
		
		try {
			List<KobisAPI> list = Arrays.asList(objectMapper.readValue(result, KobisAPI[].class));
            System.out.println(list);
			return list;
        } catch (Exception e) {
            // 예외 처리
            e.printStackTrace();
            throw new RuntimeException("API 호출 중 오류 발생: " + e.getMessage());
        }
	}
}