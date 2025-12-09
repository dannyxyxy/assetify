package org.zerock.category.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;
import org.zerock.category.vo.CategoryVO;

@Repository
public interface CategoryMapper {
	
	//1.카테고리리스트 2.카테고리등록 3.수정 4.삭제
	public List<CategoryVO> list(@Param("cate_code1") Integer cate_code1);
	public Integer writeBig(CategoryVO vo);
	public Integer writeMid(CategoryVO vo);
	public Integer update(CategoryVO vo);
	public Integer delete(CategoryVO vo);
	
}
