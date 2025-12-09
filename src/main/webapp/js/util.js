/**
 * util.js
 *
 * JavaScript Utility 프로그램
 *
 * 댓글의 페이지네이션
 */
 
/* PageObject
"pageObject":{"page":1,"perPageNum":10,"startRow":1,"endRow":10,
"perGroupPageNum":10,"startPage":1,"endPage":1,
"totalPage":1,"totalRow":5,"key":null,"word":null,"period":"pre",
"pageQuery":"page=1&perPageNum=10&key=&word=",
"notPageQuery":"perPageNum=10&key=&word="}
*/
 
// 댓글 리스트 표시했던 것과 동일하게 
// 댓글 페이지네이션 태그들의 문자열을 만들어 넘겨준다.
function replyPagination(pageObject) {
	let str = "";
	
	// *** 앞 페이지 그룹으로 이동(Previous) - 시작
	str += '<li class="page-item';
	
	// 이전 페이지가 없으면 disabled 추가
	if (pageObject.startPage == 1) str += ' disabled ';
	// 이전 페이지를 버튼을 누르면 startPage-1 로 이동하도록 구현 (data-page에 세팅)
	str += '" data-page="' + (pageObject.startPage - 1) + '"><a class="page-link" href="#">Previous</a></li>';
	// *** 앞 페이지 그룹으로 이동(Previous) - 끝
	
	// startPage 부터 endPage 까지 반복처리하면서 페이지버튼을 만든다.
	for (let i = pageObject.startPage ; i <= pageObject.endPage ; i++) {
		str += '<li class="page-item';
		if (replyPage == i) str += ' active ';
		str += '" data-page="' + i + '"><a class="page-link" href="#">' + i + '</a></li>';
	} 
	
	// 다음 페이지그룹으로 이동
	// 1-10, 11-20, 21-30 totalPage-> 마지막페이지 
	str += '<li class="page-item';
	if (pageObject.endPage >= pageObject.totalPage) {
		str += ' disabled ';
	}
	// 다음 페이지 버튼을 누르면 endPage + 1 로 이동 (date-page에 세팅)
	str += '" data-page="' + (pageObject.endPage + 1) + '"><a class="page-link" href="#">Next</a></li>';

	return str; 
 
}
 
 
 
 
 
 
 
 
 
 