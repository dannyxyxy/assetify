package org.zerock.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.nio.file.Files;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.zerock.vo.AttachFileVO;

import lombok.extern.log4j.Log4j;
import net.coobird.thumbnailator.Thumbnailator;

// @Controller, @RestController
// @Service, @Repository
// @Component, @~~Advice
@Controller
@Log4j
public class UploadController {

	@GetMapping("/uploadForm")
	public void uploadForm() {
		log.info("==== upload Form ====");
		// void type으로 선언하면
		// Mapping에 적힌 url로 -> jsp 만들어서 이동
		// /WEB-INF/views/ + uploadForm + .jsp
	}
	
	@PostMapping("/uploadFormAction")
	public void uploadFormPost(MultipartFile[] uploadFile, Model model) {
		
		log.info("**** 등록한 파일 정보 ****");
		for (MultipartFile multipartFile : uploadFile) {
			log.info("upload file name : " + multipartFile.getOriginalFilename());
			log.info("upload file size : " + multipartFile.getSize());
			log.info("*********************************");
		}
		
		String uploadFolder = "C:/upload";
		
		for (MultipartFile multipartFile : uploadFile) {
			File saveFile = new File(uploadFolder, multipartFile.getOriginalFilename());
			
			try {
				multipartFile.transferTo(saveFile);
			} catch (Exception e) {
				// TODO: handle exception
				e.printStackTrace();
			}
		} // end of for()
	} // end of uploadFormPost()
	
	// Ajax 이용한 파일 업로드
	@GetMapping("/uploadAjax")
	public void uploadAjax() {
		log.info("uploadAjax ..........................");
		// 매서드 처리가 끝나고
		// "/WEB-INF/views/uploadAjax.jsp" 로 이동한다.
	}
	
	@PostMapping(value ="/uploadAjaxAction",
			produces = MediaType.APPLICATION_JSON_UTF8_VALUE
			)
	@ResponseBody // RestController
	public ResponseEntity<List<AttachFileVO>> uploadAjaxAction(MultipartFile[] uploadFile) throws Exception {
		log.info("uploadAjaxAction ....................");
		
		List<AttachFileVO> list = new ArrayList<AttachFileVO>();
		
		String uploadFolder = "C:/upload";
		
		// 폴더 만들기
		File uploadPath = new File(uploadFolder, getFolder());
		log.info("upload path : " + uploadPath);
		
		if (uploadPath.exists() == false) {
			uploadPath.mkdirs(); // c:/upload/yyyy/MM/dd" 폴더 생성
		}
		
		// foreach 형태로 사용 (향상된 for문)
		for (MultipartFile multipartFile : uploadFile) {
			log.info("============================================");
			log.info("upload file name : " + multipartFile.getOriginalFilename());
			log.info("upload file size : " + multipartFile.getSize());
			
			AttachFileVO vo = new AttachFileVO();
			
			String uploadFileName = multipartFile.getOriginalFilename();
			
			vo.setFileName(uploadFileName); // 원래 파일이름 저장
			
			// 중복 방지를 위해 이름앞에 uuid를 붙여서 사용하도록 작성
			UUID uuid = UUID.randomUUID();
			
			uploadFileName = uuid.toString() + "_" + uploadFileName;
			vo.setUuid(uuid.toString());
			vo.setUploadPath(uploadPath.toString());
			
			log.info("upload file name : " + uploadFileName);
			
			//File saveFile = new File(uploadFolder, uploadFileName);
			File saveFile = new File(uploadPath, uploadFileName);
			multipartFile.transferTo(saveFile);
			
			if (checkImageType(saveFile)) {
				
				vo.setImage(true);
				// 이미지 파일이면 이곳에서 썸네일을 만듭니다.
				FileOutputStream thumbnail = 
					new FileOutputStream(new File(uploadPath, "s_" + uploadFileName));
				
				Thumbnailator.createThumbnail
					(multipartFile.getInputStream(), thumbnail, 100, 100);
				
				thumbnail.close();
			}
			
			list.add(vo);
		} // end of for()
		
		
		return new ResponseEntity<List<AttachFileVO>>(list, HttpStatus.OK);
	}
	
	
	@GetMapping("/display")
	@ResponseBody
	// 이미지 파일 정보를 받아서 이미지 데이터를 전송하는 메서드
	public ResponseEntity<byte[]> getFile(String fileName) throws Exception {
		log.info("fileName : " + fileName);
		
		File file = new File("c:/upload/" + fileName);
		
		log.info("file : " + file);
		
		// 전달할 값을 저장할 변수
		ResponseEntity<byte[]> result = null;
		
		HttpHeaders header = new HttpHeaders();
		
		header.add("Content-Type", Files.probeContentType(file.toPath()));
		
		result = new ResponseEntity<byte[]>
			(FileCopyUtils.copyToByteArray(file), header, HttpStatus.OK);
		
		return result;
	}
	
	@GetMapping(value = "/download",
			produces = MediaType.APPLICATION_OCTET_STREAM_VALUE)
	@ResponseBody
	public ResponseEntity<Resource> downloadFile(String fileName) throws Exception {
		
		log.info("fileName : " + fileName);
		
		FileSystemResource resource =
				new FileSystemResource("c:/upload/" + fileName);
		
		log.info("resource : " + resource);
		
		if (resource.exists() == false) {
			return new ResponseEntity<Resource>(HttpStatus.NOT_FOUND);
		}
		
		String resourceName = resource.getFilename();
		
		// UUID를 없애는 부분
		String resourceOriginalName
			= resourceName.substring(resourceName.indexOf("_") + 1);
		
		String downloadName
			= new String(resourceOriginalName.getBytes("UTF-8"), "ISO-8859-1");
		
		HttpHeaders headers = new HttpHeaders();
		// Content-Dispositon : attachment 다운로드 처리를 하라는 header 문
		headers.add("Content-Disposition", 
				"attachment; fileName="	+ downloadName);
		
		return new ResponseEntity<Resource>(resource, headers, HttpStatus.OK);
	}
	
	
	// 저장폴더를 YYYY/MM/DD 가 되도록 만드는 메서드
	private String getFolder() {
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		
		Date date = new Date(); // 현재 시간 저장
		
		String str = sdf.format(date);
		
		return str.replace("-", File.separator);
	}
	
	// 이미지 파일인지 체크하는 메서드
	private boolean checkImageType(File file) throws Exception {
		
		boolean result = false;
		
		String contentType = Files.probeContentType(file.toPath());
		
		result = contentType.startsWith("image");
		
		return result;
	}
	
} // end of class














