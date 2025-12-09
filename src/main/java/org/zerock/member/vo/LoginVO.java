package org.zerock.member.vo;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data
public class LoginVO {
	
	//member Table
	private String id;
	private String pw;
	private String name;
	private String gender;
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date birth;
	private String tel;
	private String email;
	private String address;
	private String status;
	private String photo;
	
	//grade Table
	private int gradeNo ;
	private String gradeName;

}
