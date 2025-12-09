/**
 * dateTime.js
 * 날짜와 시간에 대한 표시 및 처리
 */
 
// 날짜로 표시하는 처리
// timeStamp : Long type의 시간정보 데이터
function toDate(timeStamp, separChar) {
	if (!separChar) separChar = "-";
	let dateObj = new Date(timeStamp); // 시간객체생성 ()안에 값이 없으면 현재시간기준
	let yy = dateObj.getFullYear(); // 4자리 연도저장
	let mm = dateObj.getMonth() + 1; // 월: 0~11까지 나온다. +1해줘야 한다.
	let dd = dateObj.getDate(); // 일
	
	console.log("Date: " + yy + "-" + mm + "-" + dd);
	return "" + // 이 Line에 return 만 있으면 null 값이 return됩니다.
		yy + separChar +
		(mm > 9 ? "" : "0") + mm + separChar +
		(dd > 9 ? "" : "0") + dd;
}

// 시간으로 표시하는 처리
// timeStamp : Long type의 시간정보 데이터
function toTime(timeStamp) {
	let dateObj = new Date(timeStamp);
	let hh = dateObj.getHours();
	let mi = dateObj.getMinutes();
	let ss = dateObj.getSeconds();
	
	return "" +
		(hh > 9 ? "" : "0") + hh + ":" +
		(mi > 9 ? "" : "0") + mi + ":" +
		(ss > 9 ? "" : "0") + ss;
}

// 날짜 or 시간을 표시하는 처리
// 글작성일로부터 24시간이 지나면 날짜로 표시
// 지나지 않았으면 시간으로 표시
function toDateTime(timeStamp) {
	// 현재시간 객체 생성
	let today = new Date(); // today는 Date 객체
	
	// Mac에서는 아래와 같이 처리해줘야 한다.
	// timeStamp 가 long이 아니면
	// let dateObj = new Date(timeStamp);
	// let gap = today.getTime() - dateObj.getTime();
	
	// 얼마나 지났는지 계산
	let gap = today.getTime() - timeStamp; // milliseconds
	// 지나간 시간이 24시간 보다 작은 경우 - 시간표시
	if (gap < (1000 * 60 * 60 * 24)) {
		return toTime(timeStamp);
	}
	else {
		return toDate(timeStamp);
	}
}














