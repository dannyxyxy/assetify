package org.zerock.goods.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;
import org.zerock.category.vo.CategoryVO;
import org.zerock.goods.vo.GoodsImageVO;
import org.zerock.goods.vo.GoodsPriceVO;
import org.zerock.goods.vo.GoodsSearchVO;
import org.zerock.goods.vo.GoodsVO;
import org.zerock.util.page.PageObject;

@Repository
public interface GoodsMapper {
	
	public List<GoodsVO> list(@Param("pageObject") PageObject pageObject,@Param("goodsSearchVO") GoodsSearchVO goodsSearchVO);
	public Long getTotalRow(@Param("pageObject") PageObject pageObject,@Param("goodsSearchVO") GoodsSearchVO goodsSearchVO);
	public List<CategoryVO> getCategory(@Param("cate_code1") Integer cate_code1);
	public GoodsVO view(@Param("goods_no") Long goods_no);
	public List<GoodsImageVO> imageList(@Param("goods_no") Long goods_no);
	public Integer write(GoodsVO vo);
	public Integer writePrice(GoodsVO vo);
	public Integer writeImage(GoodsImageVO vo);
	public Integer update(GoodsVO vo);
	public Integer updatePrice(GoodsVO vo);
	List<String> getImageList(Long goods_no); // 이미지 목록 가져오기
    int deleteGoods(Long goods_no); // 상품 삭제
    int deleteImages(Long goods_no); // 이미지 데이터 삭제
	public Integer getCateCode1ByGoodsNo(Long goods_no);
	
	Integer getReviewCountByGoodsNo(Long goods_no);
	List<GoodsVO> selectAllGoods(); // 모든 상품 목록을 조회하는 메소드

	
}
