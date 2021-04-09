package com.artbeans.web.util;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class DateUtil {

	
	private static final String YYYY_MM_DD = "yyyy-MM-dd";
	
	
	public static Date compareDate (Date startDate) {
		 SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		 Date date = new Date();
		 try {
			Date today = sdf.parse(sdf.format(date));
			if(today.compareTo(startDate) > 0) {
				log.info("투데이가 더크면 이날짜로 동일하거나 시작날짜가 크면 반환 X");
				return today;
			} else if(today.compareTo(startDate) < 0){
				log.info("시작 잘짜 더큼");
			} else {
				log.info("동일");
			}
			
		} catch (ParseException e) {
			e.printStackTrace();
		}
		 
		return null;
	}
	

	

}
