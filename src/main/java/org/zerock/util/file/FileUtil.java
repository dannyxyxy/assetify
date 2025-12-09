package org.zerock.util.file;

import java.io.File;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.multipart.MultipartFile;

import lombok.extern.log4j.Log4j;

@Log4j
public class FileUtil {
	//존재확인메서드
	public static boolean isExist(File file) throws Exception {
		return file.exists();
	}
	public static boolean isExist(String fileName) throws Exception{
		return toFile(fileName).exists();
	}
	//문자열을 파일객체로 만들어주는 메서드
	public static File toFile(String fileName) throws Exception {
		return new File(fileName);
	}
	//파일지우기
	public static boolean delete(File file) throws Exception {
		return file.delete();
	}
	//파일정보를 문자열로 넘겨주면 지워주는메서드 realpath를 넘겨줘야한다
	public static boolean remove(String fileName) throws Exception {
		//1.문자열을 파일객체로 만듬
		File file = toFile(fileName);
		//2.존재하는지확인
		if(!isExist(file))
			log.warn("삭제하려는 파일이 존재하지않습니다.");
		else if (!delete(file))
			log.warn("삭제하려는 파일이 삭제되지않았습니다.");
		else
			log.info("삭제하려는 파일이 삭제되었습니다.");
		return true;
		//3.삭제
		//4.결과확인
	}
	//서버의 상대주소를 절대주소로 바꾸는 메서드
	public static String getRealPath(String path, String fileName, HttpServletRequest request) throws Exception {
		String filePath = path+"/"+fileName;
		return request.getServletContext().getRealPath(filePath);
	}
	//중복파일처리
	public static File noDuplicate(String fileRealName) throws Exception {
		File file = null;
		int dotPos = fileRealName.lastIndexOf(".");
		String fileName = fileRealName.substring(0,dotPos);
		String ext = fileRealName.substring(dotPos);	//확장자만추출
		int cnt = 0;
		log.info("noDuplicate() fileName : "+fileName+" ,ext : "+ext);
		while(true) {
			if(cnt==0) {
				file=toFile(fileRealName);
			} else {
				file=toFile(fileName+cnt+ext);
			}
			if(!isExist(file)) break;
			cnt++;
		}
		return file;
	}
	//파일서버에 올리는 메서드
	public static String upload(final String PATH, MultipartFile multiFile, HttpServletRequest request) throws Exception {
		String fileFullName = "";
		if(multiFile!=null && !multiFile.getOriginalFilename().equals("")) {
			String fileName = multiFile.getOriginalFilename();
			//서버에서 중복파일을 체크한 파일객체 생성
			File saveFile = noDuplicate(getRealPath(PATH, fileName, request));
			fileFullName = PATH+"/"+saveFile.getName();
			log.info(fileFullName);
			multiFile.transferTo(saveFile);
		}else {
			fileFullName = PATH+"/"+"noImage.jpg";
		}
		return fileFullName;
	}
}
