package kr.kjy.myapp;

import java.util.ArrayList;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.multipart.MultipartFile;

import lombok.extern.log4j.Log4j;

@Log4j
@Controller
public class SampleController {
	
	@GetMapping("/exUpload")
	public void exUpload() {
		log.info("exUpload...........");
	}
	
	
	@PostMapping("/exUploadPost")
	public void exUploadPost(ArrayList<MultipartFile> files) {
		System.out.println("여기");
		files.forEach(file -> {
			log.info(file.getOriginalFilename());
			log.info(file.getSize());
			log.info(file.getContentType());
		});
	}
	
	
}
