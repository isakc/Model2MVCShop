package com.model2.mvc.service.openAPI;

import java.util.List;

import com.model2.mvc.service.domain.DailyBoxOffice;

public interface OpenAPIService {
	
	//selectList
	public List<DailyBoxOffice> getMoiveList() throws Exception;
}