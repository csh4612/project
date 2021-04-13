package com.artbeans.web.entity;

import java.util.Date;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.ColumnResult;
import javax.persistence.ConstructorResult;
import javax.persistence.ElementCollection;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.NamedNativeQuery;
import javax.persistence.OneToOne;
import javax.persistence.SqlResultSetMapping;
import javax.persistence.Table;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data
@Entity
@NamedNativeQuery(
		name = "find_reservation_schedule_dto",
		query = "SELECT \r\n"
				+ "fi.fi_path imgPath, ei.ei_name exhibitionName, \r\n"
				+ "CONCAT(DATE_FORMAT(eri.eri_start_date, '%Y-%m-%d'), ' ~ ' , DATE_FORMAT(eri.eri_end_date, '%Y-%m-%d')) period,\r\n"
				+ "eri.eri_audience_rating audienceRating,\r\n"
				+ "eri.eri_running_time runningTime,\r\n"
				+ "DATE_FORMAT(eri.eri_start_date, '%Y-%m-%d') minDate,\r\n"
				+ "DATE_FORMAT(eri.eri_end_date, '%Y-%m-%d') maxDate,\r\n"
				+ "ei.ei_charge charge,\r\n"
				+ "eri.eri_max_ticket maxTicket,\r\n"
				+ "eri.eri_num eriNum,\r\n"
				+ "(SELECT\r\n"
				+ "concat(holiday(eri.eri_start_date, eri.eri_end_date, eri.eri_holiday), ',' ,GROUP_CONCAT(distinct rti_date)) disableList\r\n"
				+ "from exhibition_reservation_info eri LEFT JOIN reservation_ticket_info rti \r\n"
				+ "ON eri.eri_num = rti.eri_num WHERE eri.eri_num = :eiNum AND rti_date IN(SELECT rti.rti_date\r\n"
				+ "from exhibition_reservation_info eri LEFT JOIN reservation_ticket_info rti \r\n"
				+ "ON eri.eri_num = rti.eri_num WHERE eri.eri_num = :eiNum GROUP BY rti.rti_Date HAVING sum(rti_number) >= eri.eri_max_stock * (eri.eri_end_time - eri.eri_start_time))) disable\r\n"
				+ "FROM exhibition_info ei \r\n"
				+ "LEFT JOIN file_info fi ON ei.ei_num = fi.fi_num \r\n"
				+ "LEFT JOIN exhibition_reservation_info eri \r\n"
				+ "ON ei.ei_num = eri.ei_num \r\n"
				+ "WHERE ei.ei_num = :eiNum",
		resultSetMapping = "reservation_schedule_dto" 		
)
@SqlResultSetMapping(
		name = "reservation_schedule_dto",
		classes = @ConstructorResult(
				targetClass = com.artbeans.web.dto.ReservationSchedule.class,
				columns = {
						@ColumnResult(name = "imgPath", type = String.class),
						@ColumnResult(name = "exhibitionName", type = String.class),
						@ColumnResult(name = "period", type = String.class),
						@ColumnResult(name = "audienceRating", type = String.class),
						@ColumnResult(name = "runningTime", type = String.class),
						@ColumnResult(name = "minDate", type = String.class),
						@ColumnResult(name = "maxDate", type = String.class),
						@ColumnResult(name = "charge", type = Integer.class),
						@ColumnResult(name = "maxTicket", type = Integer.class),
						@ColumnResult(name = "eriNum", type = Integer.class),
						@ColumnResult(name = "disable", type = String.class)
				})
)

@Table(name="exhibition_reservation_info")
public class ExhibitionReservationInfo {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name="eri_num")
	private Integer eriNum;
	
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	@Column(name="eri_start_date")
	private Date eriStartDate;
	
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	@Column(name="eri_end_date")
	private Date eriEndDate;
	
	//Time 스트링 수정
	@Column(name="eri_start_time")
	private String eriStartTime;
	
	//Time 스트링 수정
	@Column(name="eri_end_time")
	private String eriEndTime;
	
	@Column(name="eri_max_ticket")
	private Integer eriMaxTicket;
	
	@Column(name="eri_max_stock")
	private Integer eriMaxStock;
	
	@Column(name="eri_audience_rating")
	private String eriAudienceRating;
	
	@Column(name="eri_running_time")
	private String eriRunningTime;
	
	@Column(name="eri_holiday")
	private int eriHoliday;
	
	@OneToOne
	@JoinColumn(name= "ei_num")
	private ExhibitionInfo exhibitionInfo;
	
}
