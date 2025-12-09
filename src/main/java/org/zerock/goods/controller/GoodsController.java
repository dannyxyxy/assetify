package org.zerock.goods.controller;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.zerock.category.vo.CategoryVO;
import org.zerock.event.vo.EventVO;
import org.zerock.goods.service.GoodsService;
import org.zerock.goods.vo.GoodsImageVO;
import org.zerock.goods.vo.GoodsPriceVO;
import org.zerock.goods.vo.GoodsSearchVO;
import org.zerock.goods.vo.GoodsVO;
import org.zerock.member.vo.MemberVO;
import org.zerock.review.service.ReviewService;
import org.zerock.util.file.FileUtil;
import org.zerock.util.page.PageObject;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/goods")
public class GoodsController {
	
	//파일이저장될 경로
	String path="/upload/goods";
	
	@Autowired
	@Qualifier("goodsServiceImpl")
	private GoodsService service;
	
	@Autowired
   @Qualifier("reviewServiceImpl")
   private ReviewService reviewService;
   
   
   
   @GetMapping("/list.do")
   public String list(Model model, @ModelAttribute(name = "goodsSearchVO") GoodsSearchVO goodsSearchVO,
                      HttpServletRequest request) {
       PageObject pageObject = PageObject.getInstance(request);
       String perPageNum = request.getParameter("perPageNum");
       String cateCode1 = request.getParameter("cate_code1");

       log.info("페이지 당 항목 수: " + perPageNum); // 추가된 로깅
       
       // 페이지 당 항목 수 설정
       if (perPageNum == null) {
           pageObject.setPerPageNum(8);
       } else {
           pageObject.setPerPageNum(Integer.parseInt(perPageNum));
       }

       // cate_code1 값을 Integer로 변환하여 설정
       if (cateCode1 != null) {
           try {
               Integer parsedCateCode1 = Integer.parseInt(cateCode1);
               goodsSearchVO.setCate_code1(parsedCateCode1);
               log.info("카테고리 코드 설정: " + parsedCateCode1); // 추가된 로깅
           } catch (NumberFormatException e) {
               log.warn("잘못된 cate_code1 값: " + cateCode1); // 경고 로그
               goodsSearchVO.setCate_code1(null); // 기본값 설정
           }
       }

       // 카테고리 및 상품 목록 조회
       List<CategoryVO> listBig = service.listCategory(0);
       model.addAttribute("listBig", listBig);
       
       List<GoodsVO> list = service.list(pageObject, goodsSearchVO);
       model.addAttribute("list", list);
       model.addAttribute("pageObject", pageObject);
       model.addAttribute("goodsSearchVO", goodsSearchVO); // 모델에 추가

       return "goods/list"; // 뷰 반환
   }
   
   @GetMapping("/main")
	public String mainPage(Model model) {
	    // 메인 페이지에 전시할 이벤트 리스트 가져오기
	    List<GoodsVO> list = service.getAllGoods(); // 실제 서비스 호출로 변경
	    log.info("list"+list);
	    model.addAttribute("list", list);
	    return "goods/list";
	}

   @GetMapping("/view.do")
   public String view(Long goods_no, PageObject pageObject,
         @ModelAttribute(name="goodsSearchVO") GoodsSearchVO goodsSearchVO, Model model) {
      
      model.addAttribute("vo",service.view(goods_no));
      model.addAttribute("imageList",service.imageList(goods_no));
      model.addAttribute("reviewList", reviewService.goodsReview(goods_no)); // 해당 상품의 리뷰 추가
      return "goods/view";
   }
   
	// view_review
	   @GetMapping("/view_review.do")
	   public String view_review(Long goods_no, PageObject pageObject, Model model) {
	      
	      model.addAttribute("vo",service.view(goods_no));
	//      model.addAttribute("imageList",service.imageList(goods_no));
	  return "goods/view";
	   }
	   
	// view_review
   @PostMapping("/view_review.do")
   public String view_review(GoodsVO vo, HttpServletRequest request ,RedirectAttributes rttr) throws Exception {
      log.info("================== view_review.do ==================");
      log.info(vo);
      
//	      List<String> imageFileNames = new ArrayList<String>();
      //vo.setSale_price(vo.sale_price());
      Integer result = service.write(vo, null);
      rttr.addFlashAttribute("msg","리뷰가 정상등록되었습니다.");
      
      return "redirect:view.do";
   }
	
	@GetMapping("/writeForm.do")
	public String writeForm(Model model) {
		
		java.util.List<CategoryVO> listBig = new ArrayList<CategoryVO>();
		java.util.List<CategoryVO> listMid = new ArrayList<CategoryVO>();
		listBig = service.listCategory(0);
		listMid = service.listCategory(listBig.get(0).getCate_code1());
		model.addAttribute("listBig",listBig);
		model.addAttribute("listMid",listMid);
		
		return "goods/writeForm";
	}
	
	
	@PostMapping("/write.do")
	public String write(GoodsVO vo, MultipartFile imageMain, @RequestParam("imageFiles")
	ArrayList<MultipartFile> imageFiles, HttpServletRequest request ,RedirectAttributes rttr) throws Exception {
		log.info("================== write.do ==================");
		log.info(vo);
		log.info(imageMain.getOriginalFilename());
		for(MultipartFile file : imageFiles) {
			log.info(file.getOriginalFilename());
		}
		vo.setImage_name(FileUtil.upload(path, imageMain, request));
		
		List<String> imageFileNames = new ArrayList<String>();
		for(MultipartFile file : imageFiles) {
			imageFileNames.add(FileUtil.upload(path, file, request));
		}
		//vo.setSale_price(vo.sale_price());
		Integer result = service.write(vo, imageFileNames);
		rttr.addFlashAttribute("msg","상품이 정상등록되었습니다.");
		
		return "redirect:list.do?cate_code1="+ vo.getCate_code1();
	}
	
	// 상품 수정 폼
		@GetMapping("/updateForm.do")
		public String updateForm(
				Long goods_no,
				@ModelAttribute(name="pageObject") PageObject pageObject,
				// @ModelAttribute()를 선언하면 선언된 객체를 model에 담는다. -> JSP전달
				@ModelAttribute(name="goodsSearchVO") GoodsSearchVO goodsSearchVO,
				Model model
				) {
			List<CategoryVO> listBig = new ArrayList<CategoryVO>();
			List<CategoryVO> listMid = new ArrayList<CategoryVO>();
			
			listBig = service.listCategory(0);
			// 대분류 첫번째에 있는 중분류를 가져온다.
			listMid = service.listCategory(listBig.get(0).getCate_code1());
			
			// 상품의 상세정보 가져오기 (상품정보 + 가격정보)
			model.addAttribute("goodsVO", service.view(goods_no));
			// 추가 이미지 정보 리스트
			model.addAttribute("imageList", service.imageList(goods_no));
			model.addAttribute("listBig", listBig);
			model.addAttribute("listMid", listMid);
			
			return "goods/updateForm";
		}
	
		@PostMapping("/update.do")
		public String update(
		        @ModelAttribute(name = "goodsVO") GoodsVO goodsVO, HttpSession session,
		        PageObject pageObject, @RequestParam(value = "profileImage", required = false) MultipartFile file,
		        RedirectAttributes rttr) throws Exception {

		    log.info("===========update.do===========");
		    log.info(goodsVO);

		    // 이미지 파일 업데이트
		    if (file != null && !file.isEmpty()) {
		        log.info("파일이 존재합니다.");
		        try {
		            String uploadDir = session.getServletContext().getRealPath("/upload/goods/");
		            File directory = new File(uploadDir);
		            if (!directory.exists()) {
		                directory.mkdirs(); // 디렉토리 생성
		            }

		            String fileName = goodsVO.getGoods_no() + "_" + UUID.randomUUID() + "_" + file.getOriginalFilename();
		            File newFile = new File(uploadDir + fileName);

		            // 파일 저장
		            file.transferTo(newFile);

		            // 파일 경로 설정
		            String imagePath = "/upload/goods/" + fileName;
		            goodsVO.setImage_name(imagePath); // goodsVO에 사진 경로 설정
		        } catch (Exception e) {
		            log.error("프로필 사진 업로드 중 오류 발생", e);
		            rttr.addFlashAttribute("errorMessage", "프로필 사진 업데이트 중 오류가 발생했습니다. 다시 시도해주세요.");
		            return "redirect:/goods/updateForm.do";
		        }
		    } else {
		        log.info("파일이 존재하지 않습니다. 기존 이미지 사용.");
		        GoodsVO existingGoods = service.view(goodsVO.getGoods_no());
		        if (existingGoods != null) {
		            goodsVO.setImage_name(existingGoods.getImage_name());
		        }
		    }

		    // 상품 정보 업데이트
		    service.update(goodsVO);

		    return "redirect:/goods/view.do?goods_no=" + goodsVO.getGoods_no() +
		            "&" + pageObject.getPageQuery();
		}
		
		
		@PostMapping("/delete.do")
		public String delete(@RequestParam("goods_no") Long goods_no, RedirectAttributes rttr, HttpServletRequest request) throws Exception {
		    log.info("상품 삭제 요청, goods_no: " + goods_no);
		 // 삭제 전 cate_code1 조회
		    Integer cateCode1 = service.getCateCode1ByGoodsNo(goods_no);
		    // 서비스 호출하여 상품 및 이미지 삭제
		    boolean isDeleted = service.delete(goods_no, request);
		    
		    if (isDeleted) {
		        rttr.addFlashAttribute("msg", "상품이 성공적으로 삭제되었습니다.");
		    } else {
		        rttr.addFlashAttribute("errorMsg", "상품 삭제에 실패하였습니다.");
		    }
		    
		    
			return "redirect:/goods/list.do?cate_code1="+cateCode1;
		}
		
		
		@GetMapping("/goods_code_popUp")
		public String goodsCodePopup(Model model, @ModelAttribute GoodsSearchVO goodsSearchVO, HttpServletRequest request) {
		    // 페이지 객체 생성
		    PageObject pageObject = PageObject.getInstance(request);
	        if (request.getParameter("perPageNum") == null) {
	            pageObject.setPerPageNum(3);
	        } else {
	            pageObject.setPerPageNum(Integer.parseInt(request.getParameter("perPageNum")));
	        }

	        if (request.getParameter("page") != null) {
	            pageObject.setPage(Integer.parseInt(request.getParameter("page")));
	        }

		    
		    // 로그로 검색 조건 확인
		    log.info("검색 조건: " + goodsSearchVO);
		    log.info("페이지 정보: " + pageObject);

		    // 검색 로직 호출
		    List<GoodsVO> list = service.list(pageObject, goodsSearchVO);
		    List<CategoryVO> categories = service.listCategory(0); // 대분류 카테고리 가져오기

		    // 모델에 데이터 추가
		    model.addAttribute("list", list);                  // 상품 목록
		    model.addAttribute("categories", categories);      // 카테고리 목록
		    model.addAttribute("goodsSearchVO", goodsSearchVO);// 검색 조건
		    model.addAttribute("pageObject", pageObject);      // 페이지 정보

		    return "goods/goods_code_popUp"; // JSP 경로
		}
	




	
	
}
