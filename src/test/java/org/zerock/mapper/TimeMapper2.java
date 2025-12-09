package org.zerock.mapper;

import org.apache.ibatis.annotations.Select;
import org.springframework.stereotype.Repository;

@Repository
public interface TimeMapper2 {
	@Select("select sysdate from dual")
	public String getTime();
	
	//mapper.xml과 연결
	public String getTime2();
	
}
