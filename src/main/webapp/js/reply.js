/**
 * reply.js
 * 일반 게시판 댓글 처리 객체
 */
 
console.log("Board Reply Module ..........................");

// 일반 게시판 댓글을 처리하는 객체 선언
// jquery 의 ajax 를 사용 - ajax(), getJSON(), get(), post()
let replyService = {

	// 1. 일반 게시판 댓글 리스트 처리
	"list": function(page, callback, error) {
		console.log("댓글 리스트.......");
		// page가 없으면 page = 1로 만든다.
		if (!page) page = 1;
		console.log("page : " + page + ", no : " + no);
		
		// ajax 형태를 만들어 처리합니다. - getJSON()
		$.getJSON( // (url, 성공함수, 실패함수)
			"/boardreply/list.do?page=" + page + "&no=" + no,
			// 데이터 가져오기를 성공하면 실행되는 함수.
			// data - 서버에서 넘겨주는 JSON 데이터
			function(data) {
				// 데이터 확인
				console.log(data);
				console.log(JSON.stringify(data)); // JSON데이터를 문자열로 리턴
				// callback  구현 - callback 있으면 실행
				// 태그형태가 달려졌을때 사용하기 위해서
				if (callback) callback(data);
			}
		// 실패했을때 실행되는 함수
		).fail(function(xhr, status, err) {
			console.log("댓글 리스트 데이터 가져오기 오류 ****************");
			console.log("xhr" + xhr);
			console.log("status" + status);
			console.log("err" + err);
			
			// error 있으면 실행
			if (error) error();
			else alert("댓글 데이터 가져 오는 중 오류 발생");
		});
	},
	// 2. 일반 게시판 댓글 등록 처리
	// write(댓글객체, 성공함수, 실패함수)
	"write": function(reply, callback, error) {
		console.log("댓글 등록 --------------");
		
		$.ajax({
			type: "post", // 데이터 전송 방식
			url: "/boardreply/write.do", // mapping되는 url을 적는다.
			data: JSON.stringify(reply), // 서버에 전송되는 데이터 - body
			contentType: "application/json; charset:utf-8", // 서버에 전송되는 데이터 타입과 엔코딩방식을 적는다.
			// 성공했을때 함수
			success: function(result, status, xhr) {
				if (callback) callback(result);
				else alert(result);
			},
			error: function(xhr, status, err) {
				console.log("xhr : " + xhr);
				console.log("status : " + status);
				console.log("err : " + err);
				if (error) error(err);
				else alert("댓글이 등록되지 않았습니다.");
			}
		});
	},
	// 3. 일반 게시판 댓글 수정 처리
	// update(댓글객체, 성공함수, 실패함수)
	"update": function(reply, callback, error) {
		console.log("댓글 수정 ----------------------");
		
		$.ajax({
			type : "post", // 데이터 전송 방식
			url : "/boardreply/update.do", // mapping url -> RestController에 mapping된
			data : JSON.stringify(reply), // 서버에 전송되는 데이터
			contentType : "application/json; charset:utf-8", // 서버에 전송되는 데이터타입과 엔코딩형식
			// 성공했을 때 함수
			success : function(result, status, xhr) {
				if (callback) callback(result);
				else alert(result);
			},
			// 실패했을 때 함수
			error : function(xhr, status, err) {
				console.log("xhr : " + xhr);
				console.log("status : " + status);
				console.log("err : " + err);
				if (error) error(err);
				else alert("댓글이 수정되지 않았습니다.");
			}
		});
	},
	// 4. 일반 게시판 댓글 삭제 처리
	// delete(댓글객체, 성공함수, 실패함수)
	"delete": function(rno, callback, error) {
		console.log("댓글 삭제 --------------------------");
		
		$.ajax({
			type : "get", // 데이터 전송 방식
			url : "/boardreply/delete.do?rno=" + rno,
			// 성공하는 함수
			success : function(result, status, xhr) {
				if (callback) callback(result);
				else alert(result);
			},
			error : function(xhr, status, err) {
				console.log("xhr : " + xhr);
				console.log("status : " + status);
				console.log("err : " + err);
				if (error) error(err);
				else alert("댓글이 삭제 되지 않았습니다.");
			}
		});
		
		
	} // end of "delete": function(){}

};






