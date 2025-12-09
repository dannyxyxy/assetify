package org.zerock.vo;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data
public class TodoVO {

	private String title;
	
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date dueDate;
	
}
