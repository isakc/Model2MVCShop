package com.model2.mvc.service.openAPI;

import java.util.List;

import com.model2.mvc.service.domain.KobisAPI;

public interface OpenAPIService {
	
	//selectList
	public List<KobisAPI> getMoiveList() throws Exception;
}