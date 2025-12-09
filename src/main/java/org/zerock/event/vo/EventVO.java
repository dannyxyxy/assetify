package org.zerock.event.vo;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data
public class EventVO {

	private Long eno;
	private String title;
	private String content;
	// sql 과 java의 Date 구조가 달라서 캐스팅이 필요하다.
	// spring에서는 자동으로 캐스팅 해준다.
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date startDate;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date endDate;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date writeDate;
	private String imageName;
	
}
