package org.zerock.category.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.zerock.category.mapper.CategoryMapper;
import org.zerock.category.vo.CategoryVO;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
@Qualifier("categoryServiceImpl")
public class CategoryServiceImpl implements CategoryService {
	
	@Setter(onMethod_ = @Autowired)
	private CategoryMapper mapper;
	
	@Override
	public List<CategoryVO> list(Integer cate_code1) {
		// TODO Auto-generated method stub
		return mapper.list(cate_code1);
	}

	@Override
	public Integer write(CategoryVO vo) {
		// TODO Auto-generated method stub
		if(vo.getCate_code1()==0) {
			return mapper.writeBig(vo);
		} else {
		return mapper.writeMid(vo);
		}
	}

	@Override
	public Integer update(CategoryVO vo) {
		// TODO Auto-generated method stub
		return mapper.update(vo);
	}

	@Override
	public Integer delete(CategoryVO vo) {
		// TODO Auto-generated method stub
		return mapper.delete(vo);
	}

}
