package kr.kjy.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;
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
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import kr.kjy.model.AttachFileDTO;
import lombok.extern.log4j.Log4j;
import net.coobird.thumbnailator.Thumbnailator;

@Controller
@Log4j
public class UploadController {
	
	// <form> 방식의 파일 업로드
	@GetMapping("/uploadForm")
	public void uploadForm() {
		log.info("upload form");
	}
	
	@PostMapping("/uploadFormAction")
	public void uploadFormPost(MultipartFile[] uploadFile, Model model) {
		
		String uploadFolder = "C:\\upload";
		
		for(MultipartFile multipartfile : uploadFile) {
			log.info("-----------------------------");
			System.out.println("Upload File Name : " + multipartfile.getOriginalFilename());
			System.out.println("Upload File Size : " + multipartfile.getSize());
			File saveFile = new File (uploadFolder, multipartfile.getOriginalFilename());
			
			try {
				multipartfile.transferTo(saveFile);
			}catch (Exception e) {
				log.error(e.getMessage());
			}
		}
	}
	// Ajax를 이용한 파일 업로드
	@GetMapping("/uploadAjax")
	public void uploadAjax() {
		log.info("upload ajax");
	}
	
	@PostMapping(value =  "/uploadAjaxAction", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public ResponseEntity<List<AttachFileDTO>> uploadAjaxPost(MultipartFile[] uploadFile) {
		List<AttachFileDTO> list = new ArrayList<>();
 		String uploadFolder = "C:\\upload";
 		String uploadFolderPath = getFolder();
		// make folder
		File uploadPath = new File(uploadFolder, uploadFolderPath);
		if (uploadPath.exists() == false) {
			uploadPath.mkdirs();
		}
		for(MultipartFile multipartfile : uploadFile) {
			System.out.println("Upload File Name : " + multipartfile.getOriginalFilename());
			System.out.println("Upload File Size : " + multipartfile.getSize());
			AttachFileDTO attachDTO = new AttachFileDTO();
			String uploadFileName = multipartfile.getOriginalFilename();
			//IE has file path
			uploadFileName = uploadFileName.substring(uploadFileName.lastIndexOf("\\")+1);
			System.out.println("only file name : " + uploadFileName);
			attachDTO.setFileName(uploadFileName);
			// UUID로 중복 방지			
			UUID uuid = UUID.randomUUID();
			uploadFileName = uuid.toString() + "_" + uploadFileName;
			try {
				File saveFile = new File (uploadPath, uploadFileName);
				multipartfile.transferTo(saveFile);
				attachDTO.setUuid(uuid.toString());
				attachDTO.setUploadPath(uploadFolderPath);
				// check image type file
				if(checkImageType(saveFile)) {
					attachDTO.setImage(true);
					FileOutputStream thumbnail = new FileOutputStream(new File(uploadPath, "s_"+uploadFileName));
					Thumbnailator.createThumbnail(multipartfile.getInputStream(),thumbnail, 100, 100);
					thumbnail.close();
				}
				list.add(attachDTO);
			}catch (Exception e) {
				log.error(e.getMessage());
			}
		}
		return new ResponseEntity<>(list, HttpStatus.OK);
	}
	
	@GetMapping("/display")
	@ResponseBody
	public ResponseEntity<byte[]> getFile(String fileName){
		System.out.println("file name : " + fileName);
		File file = new File("c:\\upload\\" + fileName);
		System.out.println("file : " + file);
		ResponseEntity<byte[]> result = null;
		try {
			HttpHeaders header = new HttpHeaders();
			header.add("Content-Type", Files.probeContentType(file.toPath()));
			result = new ResponseEntity<>(FileCopyUtils.copyToByteArray(file), header, HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
	@GetMapping(value = "/download", produces = MediaType.APPLICATION_OCTET_STREAM_VALUE)
	@ResponseBody
	public ResponseEntity<Resource> downloadFile(@RequestHeader("User-Agent") String userAgent, String fileName){
		System.out.println("download file : " + fileName);
		Resource resource = new FileSystemResource("c:\\upload\\" + fileName);
		System.out.println("resource : " + resource);
		String resourceName = resource.getFilename();
		
		//remove UUID
		String resourceOriginalName = resourceName.substring(resourceName.indexOf("_")+1);
		
		HttpHeaders headers = new HttpHeaders();
		try {
			
			String downloadName = null;
			if(userAgent.contains("Trident")) {
				System.out.println("IE browser");
				downloadName = URLEncoder.encode(resourceOriginalName, "UTF-8");
			}else if(userAgent.contains("Edge")) {
				System.out.println("Edge browser");
				downloadName = URLEncoder.encode(resourceOriginalName, "UTF-8");
			}else {
				System.out.println("Chrome browser");
				downloadName = new String(resourceOriginalName.getBytes("UTF-8"), "ISO-8859-1");
			}
			headers.add("Content-Disposition","attachment; fileName=" + resourceOriginalName);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ResponseEntity<Resource>(resource, headers, HttpStatus.OK);
	}
	
	@PostMapping("/deleteFile")
	@ResponseBody
	public ResponseEntity<String> deleteFile(String fileName, String type){
		File file;
		try {
			file = new File("c:\\upload\\" + URLDecoder.decode(fileName, "UTF-8"));
			file.delete();
			if(type.equals("image")) {
				String largeFileName = file.getAbsolutePath().replace("s_", "");
				file = new File(largeFileName);
				file.delete();
			}
		}catch (UnsupportedEncodingException e) {
			e.printStackTrace();
			return new ResponseEntity<>(HttpStatus.NOT_FOUND);
		}
		return new ResponseEntity<String>("deleted", HttpStatus.OK);
	}
	
	private String getFolder() {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Date date = new Date();
		String str = sdf.format(date);
		return str.replace("-", File.separator);
	}
	
	private boolean checkImageType(File file) {
		try {
			String contentType = Files.probeContentType(file.toPath());
			return contentType.startsWith("image");
		}catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}
	
}
