package org.zerock.category.service;

import java.util.List;

import org.zerock.category.vo.CategoryVO;

public interface CategoryService {
	
	public List<CategoryVO> list(Integer cate_code1);
	public Integer write(CategoryVO vo);
	public Integer update(CategoryVO vo);
	public Integer delete(CategoryVO vo);
}
