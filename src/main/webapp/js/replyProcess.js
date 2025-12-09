/**
 * replyProcess.js 
 * replyService 객체를 이용한 댓글 처리 코드
 */
 
 // 만든이후 잘되는지 확인
 //replyService.list();
 
 function showList(page) {
 	// 데이터를 받아 옵니다.
 	replyService.list(page,
 		// 데이터 가져오기가 성공되었을 때 실행되는 함수
 		// -> html tag를 만들어 화면에 표시
 		function (data) {
 			// data 의 구조 - {"list":list, "pageObject":pageObject}
 			let list = data.list; // data(map)의 key값으로 value를 가져온다.
 			
 			// ul 태그안에 들어갈 문자열을 저장할 객체
 			let str = "";
 			// 데이터가 없을 때 처리
 			if (list == null || list.length == 0) {
 				//$(".chat").html(""); //데이터가 존재하지 않습니다.
 				$(".chat").html("<li>댓글이 없습니다.</li>");
 				return;
 			}
 			// 데이터가 있는 경우의 처리
 			// **** 댓글 리스트 출력 ****
 			for(let i = 0 ; i < list.length ; i++) {
 				str += '<li class="left clearfix" data-rno="' + list[i].rno + '">';
				str += '<div>';
				str += '<div class="header">';
				str += '<strong class="primary-font">' + list[i].name;
				str += '(' + list[i].id + ')</strong>';
				str += '<small class="pull-right text-muted">';
				str += toDateTime(list[i].writeDate) + '</small>';
				str += '</div>';
				str += '<p><pre class="replyContent">' + list[i].content +'</pre></p>';
				// 접속자 id와 작성자 id가 같은때만 수정/삭제가 가능하도록 구현
				if (id == list[i].id) {
					str += '<div>';
					str += '<button class="replyUpdateBtn btn btn-success btn-sm">수정</button>';
					//str += "<button class=\"replyUpdateBtn btn btn-success btn-sm\">수정</button>";
					str += '<button class="replyDeleteBtn btn btn-danger btn-sm">삭제</button>';
					str += '</div>';
				}
				str += '</div>';
				str += '</li>';
 			}
 			$(".chat").html(str);
 			
 			// **** 댓글 페이지네이션 출력 **** ; util.js 선언하고 구현되어있다.
 			$(".pagination").html(replyPagination(data.pageObject));
 		}
 	);
 };
 
 // 댓글 리스트 함수 실행
 showList(1);
 
 // HTML 이 로딩된 후에 처리되도록 합니다.
 $(function() {
 	// -------이벤트 처리----------------
 	// 태그들이 모두 올라온 후에 처리할 수 있어야 합니다. $(function() {  이벤트처리  })
 	// {} 안에 이벤트처리부분이 구현되어야 정상동작 합니다.
 	
 	// 새로운 댓글을 작성하기 위해 new reply 버튼 클릭시 이벤트
 	$("#newReplyBtn").click(function() {
 		// 버튼 처리 - 등록버튼은 보이고, 수정버튼은 안보이도록 처리
 		$("#replyWriteBtn").show();
 		$("#replyUpdateBtn").hide();
 
 		
 		// 모달창에 title을 "댓글 등록"로 보여줍니다.
 		$("#replyModal .modal-title").text("댓글 등록");
 		// 이전에 작성했던 댓글 내용을 지워줍니다.
 		$("#replyContent").val("");
 	});
 
 	// 댓글 등록 모달 창에서 "등록" 버튼 click이벤트 처리
 	$("#replyWriteBtn").click(function() {
 		//alert("댓글 등록 버튼 클릭"); - 이벤트로 들어오는지 확인용 코드
 		
 		// 댓글 등록에 필요한 데이터 수집(no, content)
 		// no는 전역변수로 선언을 했다.
 		// $("#replyContent").val() : id :replyContent
 		// <textarea>에 적은 데이터를 가져옵니다.
 		let reply = {no : no, content: $("#replyContent").val()};
 		// JSON.stringify()는 JSON데이터를 string으로 리턴해준다.
 		//alert(JSON.stringify(reply));
 		replyService.write(reply,
 			function(result) {
 				// 모달창을 닫는다.
 				$("#replyModal").modal("hide");
 				//alert(result);
 				// sitemesh에서 구현해 놓은 모달창에 결과를 보여주도록 만듭니다.
 				$("#msgModal .modal-body").text(result);
 				$("#msgModal").modal("show");
 				// 새로운 댓글이 들어와서 리스트를 다시 불러옵니다.
 				showList(1);
 			}
 		);
 	}); // end of $("#replyWriteBtn").click() 
 	
 	
 	//$(".replyUpdateBtn").click(function() {
 	//	alert("수정 버튼 클릭");
 	//}); // end of $(".replyUpdateBtn").click()
 	// 위 코드가 반응을 안하는 이유는 jsp에서 구현한것이 아니고 javascript에서 
 	// 작성해서 표시한 코드라 바로 찾지를 못합니다.
 	// 맨앞의 선택자는 원래존재(jsp코드에 있는) 한 객체(tag, class, id)를 사용합니다.
 	// 그 객체 안에있는 HTML 코드안에 find를 사용하여 찾으면 됩니다.
 	// 이벤트 위임 (첫번째에 적힌 이벤트를 두번째 객체가 처리한다. 3번째 함수을 이용해서)
 	$(".chat").on("click", ".replyUpdateBtn", function() {
 		//alert("수정 버튼 클릭");
 		// 버튼처리 - 수정버튼은 보이게, 등록버튼은 안보이게
 		$("#replyWriteBtn").hide();
 		$("#replyUpdateBtn").show();
 		
 		// 모달창에 title을 "댓글 수정"로 보여줍니다.
 		$("#replyModal .modal-title").text("댓글 수정");
 		// click이벤트 발생한 곳에서 위로 올라가면서 첫번째로 만나는
 		// <li> 태그를 찾아서 위치를 변수로 넘깁니다.
 		let li = $(this).closest("li");
 		// 기존 작성한 댓글을 불러와서 modal창에 보여줍니다.
 		// 클릭한 댓글번호를 모달창의 hidden 에 보관합니다.
 		$("#replyRno").val(li.data("rno"));
 		$("#replyContent").val(li.find(".replyContent").text());
 		// 세팅이 끝나고 모달을 보여줍니다.
 		$("#replyModal").modal("show");
 	}); // end of $(".chat").on()
 	
 	// 화면구성이 끝나고
 	// 수정처리 이벤트(모달의 수정버튼)
 	$("#replyUpdateBtn").click(function(){
 		// 데이터 수집 -> JSON데이터를 만든다. - rno, content
 		let reply = {rno : $("#replyRno").val(),
 			content : $("#replyContent").val()};
 			
 		console.log(reply);
 		
 		// 댓글 수정 처리
 		replyService.update(reply, // 서버에 전달되는 데이터
 			function(result) { // 성공함수
 				$("#replyModal").modal("hide");
 				// sitemesh에서 구현해 놓은 모달창에 결과를 보여주도록 만듭니다.
 				$("#msgModal .modal-body").text(result);
 				$("#msgModal").modal("show");
 				// 댓글을 수정한 후 리스트를 다시 불러옵니다.
 				// 수정한 댓글이 있는 페이지로 세팅
 				showList(replyPage);
 			}
 		);
 		
 	}); // end of $("#replyUpdateBtn").click()
 	
 	// 4. 댓글 삭제 버튼
 	$(".chat").on("click", ".replyDeleteBtn", function() {
 		//alert("삭제 버튼 클릭");
 		if (!confirm("정말 삭제 하시겠습니까?")) {
 			// 삭제를 안하겠다.
 			return;
 		}
 		// 삭제처리 (yes)
 		// rno 수집
 		let rno = $(this).closest("li").data("rno");
 		
 		// 삭제 서비스 실행
 		replyService.delete(rno,
 			function(result) {
 				$("#msgModal .modal-body").text(result);
 				$("#msgModal").modal("show");
 				// 댓글 삭제 후 리스트를 다시 불러옵니다.
 				// 리스트가 변경되었으므로 1page로 갑니다.
 				showList(1);	
 			}
 		);
 	});

	// 댓글 페이지네이션 이벤트 처리
	$(".pagination").on("click", "a", function() {
		// 1. 이벤트가 적용되는지 확인
		//alert("페이지버튼 클릭");
		let page = $(this).parent().data("page"); // <li> 태그안에 page값을 가져온다.
		//alert("이동페이지 : " + page);
		if (replyPage != page) {
			// 현재 페이지 이외의 버튼을 클릭했을때만 처리
			//alert("이동페이지 : " + page);
			replyPage = page; // 이동할 페이지를 현재 페이지로 세팅
			showList(replyPage);
		}
	
		return false;
	}); 



 
 
 
}); // end of  $(function(){}) // 이벤트 처리 끝
 
 
 
 
 
 
 
 
 
 
 
 
 