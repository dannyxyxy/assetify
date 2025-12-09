package org.zerock.review.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.zerock.review.service.ReviewService;
import org.zerock.review.vo.ReviewVO;
import org.zerock.event.vo.EventVO;
import org.zerock.member.vo.LoginVO;
import org.zerock.util.file.FileUtil;
import org.zerock.util.page.PageObject;

import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/review")
@Log4j
public class ReviewController {

    @Autowired
    @Qualifier("reviewServiceImpl")
    private ReviewService service;

 // 전체 리뷰 리스트 페이지로 이동 (모든 리뷰를 보여줌)
    @GetMapping("/list.do")
    public String viewReviewList(Model model) {
        List<ReviewVO> list = service.getReviewAll();
        int reviewCount = list.size();  // 전체 리뷰 개수 계산
        log.info("All Reviews: " + list);
        log.info("Total Review Count: " + reviewCount);
        
        model.addAttribute("list", list);
        model.addAttribute("reviewCount", reviewCount);  // 모델에 리뷰 개수 추가
        
        return "review/list";
    }
    

    // 2-1. 리뷰 쓰기 폼
    @GetMapping("/writeForm.do")
    public String writeForm() {
        log.info("writeForm() =======");
        return "review/writeForm";
    }
    

    // 2-2. 리뷰 쓰기 처리
    @PostMapping("/write.do")
    public String write(
            @ModelAttribute("vo") ReviewVO vo,
            @RequestParam("goods_no") Long goodsNo,
            @RequestParam(value = "page", required = false, defaultValue = "1") int page,
            @RequestParam(value = "perPageNum", required = false, defaultValue = "8") int perPageNum,
            @RequestParam(value = "key", required = false, defaultValue = "") String key,
            @RequestParam(value = "word", required = false, defaultValue = "") String word,
            @RequestParam(value = "cate_code1", required = false, defaultValue = "1") int cateCode1,
            @RequestParam(value = "goods_name", required = false, defaultValue = "") String goodsName,
            @RequestParam(value = "min_price", required = false, defaultValue = "") String minPrice,
            @RequestParam(value = "max_price", required = false, defaultValue = "") String maxPrice,
            HttpSession session,
            RedirectAttributes rttr) throws Exception {
        
        // 로그인 여부 확인
        LoginVO loginVO = (LoginVO) session.getAttribute("login");
        if (loginVO == null) {
            // 로그인 페이지로 리다이렉트
            rttr.addFlashAttribute("msg", "로그인이 필요합니다. 로그인 후 다시 시도해주세요.");
            return "redirect:/member/loginForm.do"; // 로그인 페이지 URL
        }

        // 로그인된 사용자 ID 설정
        vo.setId(loginVO.getId());
        log.info("write() ======= 리뷰 작성 - ID: " + vo.getId());

        vo.setGoods_no(goodsNo);  // goods_no 필드가 null로 넘어가지 않도록 vo에 직접 설정
        log.info("write() ======= 리뷰 작성 - goods_no: " + goodsNo);

        log.info(vo);

        service.write(vo);
        rttr.addFlashAttribute("msg", "리뷰가 등록되었습니다.");
        return "redirect:/goods/view.do?goods_no=" + goodsNo 
                + "&page=" + page 
                + "&perPageNum=" + perPageNum 
                + "&key=" + key 
                + "&word=" + word 
                + "&cate_code1=" + cateCode1 
                + "&goods_name=" + goodsName 
                + "&min_price=" + minPrice 
                + "&max_price=" + maxPrice
                + "#review-tab";
    }

    

    // 3-1. 리뷰 수정 폼
    @GetMapping("/updateForm.do")
    public String updateForm(@RequestParam("rno") Long rno, Model model) {
        // rno를 기반으로 리뷰 데이터를 가져옴
        ReviewVO vo = service.getReviewByRno(rno);
        if (vo == null) {
            throw new IllegalArgumentException("존재하지 않는 리뷰입니다.");
        }
        model.addAttribute("vo", vo); // JSP로 전달
        return "review/updateForm";
    }


    // 3-2. 리뷰 수정
    @PostMapping("/update.do")
    public String update(
    		@ModelAttribute("vo") ReviewVO vo,
//    		@RequestParam("goods_no") Long goodsNo,
    		HttpSession session,
    		RedirectAttributes rttr) throws Exception {
        vo.setId(getId(session)); // 로그인한 사용자의 ID 설정
        log.info("update() ======= 리뷰 수정 - ID: " + vo.getId());
        
//        vo.setGoods_no(goodsNo);	// goods_no 필드가 null로 넘어가지 않도록 vo에 직접 설정
//        log.info("write() ======= 리뷰 작성 - goods_no: " + goodsNo);
        
        log.info(vo);
//        log.info("update() - rno: " + vo.getRno() + ", goods_no: " + vo.getGoods_no());
        
        service.update(vo);
        rttr.addFlashAttribute("msg", "리뷰가 수정되었습니다.");
        return "redirect:/review/list.do";
    }
    

    // 4. 리뷰 삭제 처리
    @PostMapping("/delete.do")
    public String delete(ReviewVO vo, HttpSession session, RedirectAttributes rttr) throws Exception {
        vo.setId(getId(session)); // 로그인한 사용자의 ID 설정
        log.info("delete() ======= 리뷰 삭제 - ID: " + vo.getId());

        if (service.delete(vo) == 1) {
            rttr.addFlashAttribute("msg", "리뷰 " + vo.getRno() + "가 삭제되었습니다.");
//            return "redirect:list.do";
        } else {
            rttr.addFlashAttribute("msg", "리뷰가 삭제되지 않았습니다.");
//            return "redirect:list.do?rno=" + vo.getRno();
        }
        return "redirect:/review/list.do";
    }
    

    // 세션에서 로그인한 ID 가져오기
    private String getId(HttpSession session) throws Exception {
        LoginVO loginVO = (LoginVO) session.getAttribute("login");
        if (loginVO != null) {
            return loginVO.getId();
        }
        throw new Exception("로그인이 필요합니다.");
    }
    
    
    @PostMapping("/like.do")
    @ResponseBody
    public ResponseEntity<String> increaseLikeCount(@RequestParam("rno") Long rno, HttpSession session) {
        // 로그인 여부 확인
        LoginVO loginVO = (LoginVO) session.getAttribute("login"); // 세션에서 로그인 정보 가져오기
        if (loginVO == null) {
            // 로그인이 되어 있지 않은 경우 경고 메시지 반환
            return new ResponseEntity<>("로그인이 필요합니다.", HttpStatus.UNAUTHORIZED);
        }
        
        String userId = loginVO.getId();  // 로그인된 사용자의 ID 가져오기

        // 좋아요 중복 체크: 사용자가 이미 좋아요를 눌렀다면 중복 메시지 반환
        if (service.checkDuplicateLike(userId, rno) > 0) {
            return new ResponseEntity<>("이미 좋아요를 누르셨습니다.", HttpStatus.BAD_REQUEST);
        }

        // 중복이 아닌 경우에만 좋아요 증가 및 기록 추가
        service.increaseLikeCount(rno);  // 좋아요 수 증가
        service.insertLike(userId, rno);  // 좋아요 기록 추가

        return new ResponseEntity<>("좋아요가 반영되었습니다.", HttpStatus.OK);
    }
    
    @GetMapping("/listByCategory.do")
    public String viewReviewListByCategory(@RequestParam("categoryId") Long categoryId, Model model) {
        List<ReviewVO> list;

        if (categoryId == 0) {
            // "전체" 카테고리: 모든 리뷰를 조회
            list = service.getReviewAll();  // 모든 리뷰 조회
        } else {
            // 선택된 카테고리: 해당 카테고리의 리뷰 조회
            list = service.getReviewsByCategory(categoryId);  
        }

        // 카테고리별 리뷰 수 계산
        int reviewCount = list.size();
        log.info("Reviews for Category " + categoryId + ": " + list);
        log.info("Total Review Count: " + reviewCount);

        model.addAttribute("list", list);
        model.addAttribute("reviewCount", reviewCount);  // 카테고리별 리뷰 개수
        model.addAttribute("categoryId", categoryId);  // 선택된 카테고리 ID 전달

        return "review/list";  // 리뷰 목록 페이지로 이동
    }


}