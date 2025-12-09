package org.zerock.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
// 모든 변수를 사용한 생성자를 만드는 어노테이션(lombok)
@AllArgsConstructor
// 기본생성자를 만드는 어노테이션
@NoArgsConstructor
public class SampleVO {
	
	private String name;
	private int age;
}
