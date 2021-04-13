package com.artbeans.web.util;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Comparator;
import java.util.Date;
import java.util.List;

import com.artbeans.web.dto.ReservationScheduleDTO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class DateUtil {

	private static final String YYYY_MM_DD = "yyyy-MM-dd";
	
	
	public static ReservationScheduleDTO getMinDate(ReservationScheduleDTO rsDTO) {
		SimpleDateFormat sdf = new SimpleDateFormat(YYYY_MM_DD);

		String[] dateStrList = rsDTO.getdisable().get(0).split(",");
		
		List<Date> dateList = new ArrayList<>();
		
		for(String dateStr : dateStrList) {
			try {
				Date parseDate = sdf.parse(dateStr);
				dateList.add(parseDate);
			} catch (ParseException e) {
				e.printStackTrace();
			}
		}
		log.info("dateList => {} ", dateList);
		
		//투데이 생성
		Date date = new Date();
		String format = sdf.format(date);
		try {
			date = sdf.parse(format);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		
		Date minDate = StringToDate(rsDTO.getminDate());
		
		//투데이가 스타트date(mindate)보다 크다면 mindate에 투데이 입력 
		if(date.compareTo(minDate) > 0) {
			minDate = date;
		}
		
		//기간 휴무일 + MAX티켓 제외리스트 합친걸 날짜순으로 정렬
		dateList.sort(new Comparator<Date>() {
				@Override
				public int compare(Date o1, Date o2) {
					return o1.compareTo(o2);
				}
			});
		
		//date 하루 추가위해 캘린더생성
		Calendar cal = Calendar.getInstance();
		//캘린더에 mindate 세팅
		cal.setTime(minDate);
		
		//mindate랑 제외리스트를 비교하면서 mindate 선정   
		for(Date d : dateList) {
			minDate = cal.getTime();
			log.info("d =>{}", d);
			if(d.compareTo(minDate) > 0) {
				//제외날짜가 mindate보다 크면 for문 나감
				log.info("minDate =>{}", minDate);
				break;
			}else if(d.compareTo(minDate) == 0){
				//mindate가 제외날짜와 같다면 하루 추가
				cal.add(Calendar.DATE, 1);
				log.info("minDate =>{}", minDate);
			}
		}
		
	    return rsDTO;
	}
	
	public static String dateToString(Date date) {
		SimpleDateFormat sdf = new SimpleDateFormat(YYYY_MM_DD);
		return sdf.format(date);
	}
	
	public static Date StringToDate(String dateStr) {
		SimpleDateFormat sdf = new SimpleDateFormat(YYYY_MM_DD);
		Date date;
		try {
			date = sdf.parse(dateStr);
			return date;
		} catch (ParseException e) {
			e.printStackTrace();
		}
		
		return null;
	}
	
}
