package org.zerock.category.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.zerock.category.service.CategoryService;
import org.zerock.category.vo.CategoryVO;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/category")
public class CategoryController {
	
	@Autowired
	@Qualifier("categoryServiceImpl")
	private CategoryService service;
	
	@GetMapping("/list.do")
	public String list(@RequestParam(defaultValue = "0")Integer cate_code1, Model model) {
		//대분류
		List<CategoryVO> listBig = service.list(0);
		if(cate_code1==0 && (listBig!=null && listBig.size()!=0)) {
			cate_code1=listBig.get(0).getCate_code1();
		}
		//중분류
		List<CategoryVO> listMid = service.list(cate_code1);
		model.addAttribute("listBig",listBig);
		model.addAttribute("listMid",listMid);
		
		model.addAttribute("cate_code1", cate_code1);
		
		return "category/list";
	}
	
	@PostMapping("/write.do")
	public String write(CategoryVO vo, RedirectAttributes rttr) {
		service.write(vo);
		rttr.addFlashAttribute("msg","카테고리가 추가되었습니다.");
		return "redirect:list.do?cate_code1="+vo.getCate_code1();
	}
	
	@PostMapping("/update.do")
	public String update(CategoryVO vo, RedirectAttributes rttr) {
		Integer result = service.update(vo);
		if(result==1) {
			rttr.addFlashAttribute("msg","카테고리가 수정되었습니다.");
		} else {
			rttr.addFlashAttribute("msg","카테고리가 수정되지 않았습니다.");
		}
		return "redirect:list.do?cate_code1="+vo.getCate_code1();
	}
	
	@PostMapping("/delete.do")
	public String delete(CategoryVO vo, RedirectAttributes rttr) {
		Integer result=service.delete(vo);
		if(result>=1) {
			rttr.addFlashAttribute("msg","카테고리가 삭제되었습니다.");
		} else {
			rttr.addFlashAttribute("msg","카테고리가 삭제되지 않았습니다.");
		}
		return "redirect:list.do?cate_code1="+vo.getCate_code1();
	}
	
}
