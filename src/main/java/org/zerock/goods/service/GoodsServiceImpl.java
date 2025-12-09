package org.zerock.goods.service;

import java.io.File;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;
import org.zerock.category.vo.CategoryVO;
import org.zerock.goods.mapper.GoodsMapper;
import org.zerock.goods.vo.GoodsImageVO;
import org.zerock.goods.vo.GoodsPriceVO;
import org.zerock.goods.vo.GoodsSearchVO;
import org.zerock.goods.vo.GoodsVO;
import org.zerock.util.page.PageObject;

import lombok.Setter;
import lombok.extern.log4j.Log4j;
@Service
@Log4j
@Qualifier("goodsServiceImpl")
public class GoodsServiceImpl implements GoodsService {
	@Setter(onMethod_ = @Autowired)
	private GoodsMapper mapper;
	
	@Override
	   public List<GoodsVO> list(PageObject pageObject, GoodsSearchVO goodsSearchVO) {
	       List<GoodsVO> goodsList = mapper.list(pageObject, goodsSearchVO);
	       for (GoodsVO goods : goodsList) {
	           goods.setReviewCount(mapper.getReviewCountByGoodsNo(goods.getGoods_no()));
	       }
	       return goodsList;
	   }
	
	@Override
    public List<GoodsVO> getAllGoods() {
        return mapper.selectAllGoods(); // Mapper를 통해 상품 목록 가져오기
    }

	@Override
	public GoodsVO view(Long goods_no) {
		// TODO Auto-generated method stub
		return mapper.view(goods_no);
	}
	
	@Override
	public List<GoodsImageVO> imageList(Long goods_no) {
		// TODO Auto-generated method stub
		return mapper.imageList(goods_no);
	}


	@Override
	@Transactional
	public Integer write(GoodsVO vo, List<String> imageFileNames) {
	    log.info("goodsVO.goods_no : " + vo.getGoods_no());

	    // 1. Goods 등록
	    mapper.write(vo);
	    Long goods_no = vo.getGoods_no();
	    
	    // 2. Price 등록
	    mapper.writePrice(vo);
	    
	    // 3. 이미지 등록
	    if (imageFileNames != null && !imageFileNames.isEmpty()) {
	        for (String imageName : imageFileNames) {
	            GoodsImageVO imageVO = new GoodsImageVO();
	            imageVO.setGoods_no(goods_no);
	            imageVO.setGoods_img_name(imageName);
	            log.info("Inserting image for goods_no: " + goods_no + " with image name: " + imageName);
	            mapper.writeImage(imageVO);
	        }
	    } else {
	        log.warn("No images to insert for goods_no: " + goods_no);
	    }
	    
	    return 1;
	}


	@Override
	@Transactional
	public Integer update(GoodsVO vo) {
		// TODO Auto-generated method stub
		mapper.update(vo);
		mapper.updatePrice(vo);
		return 1;
	}
	
	@Override
	@Transactional
    public boolean delete(Long goods_no, HttpServletRequest request) throws Exception {
		// 상품 번호로 이미지 목록을 가져옵니다.
	    List<String> imageList = mapper.getImageList(goods_no);
	    // 상품 삭제 및 이미지 삭제 처리
	    int result = mapper.deleteGoods(goods_no);
	    if (result > 0) {
	        // 이미지가 존재하면 서버에서 삭제
	        if (imageList != null && !imageList.isEmpty()) {
	            String uploadDir = request.getServletContext().getRealPath("/upload/goods/");
	            for (String imageName : imageList) {
	                File file = new File(uploadDir + imageName);
	                if (file.exists()) {
	                    file.delete(); // 파일 삭제
	                }
	            }
	        }
	        return true; // 삭제 성공 시 true 반환
	    }
	    return false; // 삭제 실패 시 false 반환
    }

	@Override
	public List<CategoryVO> listCategory(Integer cate_code1) {
		// TODO Auto-generated method stub
		return mapper.getCategory(cate_code1);
	}
	@Override
	public Integer getCateCode1ByGoodsNo(Long goods_no) {
	    return mapper.getCateCode1ByGoodsNo(goods_no);
	}
	
	@Override
    public Integer getReviewCountByGoodsNo(Long goods_no) {
        return mapper.getReviewCountByGoodsNo(goods_no);
    }

	
}
