package com.model2.mvc.common.aspect;

import org.aspectj.lang.ProceedingJoinPoint;

/*
 * FileName : PojoAspectJ.java
 *	:: XML 에 선언적으로 aspect 의 적용   
  */
public class RecordMethodTime {

	///Constructor
	public RecordMethodTime() {
		System.out.println("\nCommon :: "+this.getClass()+"\n");
	}
	
	//Around  Advice
	public Object invoke(ProceedingJoinPoint joinPoint) throws Throwable {
			
		long startTime = System.currentTimeMillis();
		
		Object obj = joinPoint.proceed();
		
		long endTime = System.currentTimeMillis();
		System.out.println("메소드 실행시간: "+ ((endTime-startTime)/1000)+"초");
		
		return obj;
	}
	
}//end of class