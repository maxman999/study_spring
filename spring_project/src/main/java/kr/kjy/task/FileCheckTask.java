package kr.kjy.task;

import java.io.File;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import kr.kjy.mapper.BoardAttachMapper;
import kr.kjy.model.BoardAttachVO;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Component
public class FileCheckTask {
	
	@Setter(onMethod_ = {@Autowired})
	private BoardAttachMapper attachMapper;
	
	private String getFolderYesterDay() {
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Calendar cal = Calendar.getInstance();
		cal.add(Calendar.DATE, -1);
		String str = sdf.format(cal.getTime());
		return str.replace("-", File.separator);
	}
	
	@Scheduled(cron = "0 0 2 * * *")
	public void checkFiles() throws Exception{
		log.warn("file check task run...............");
		log.warn(new Date());
		// db에 저장된 파일 리스트 불러오기
		List<BoardAttachVO> fileList = attachMapper.getOldFiles();
		// 디렉토리에 저장된 파일을 db에 저장된 파일과 비교하기 위한 작업
		List<Path> fileListPaths = fileList.stream()
				.map(vo -> Paths.get("C:\\upload", vo.getUploadpath(), vo.getUuid() + "_" + vo.getFilename()))
				.collect(Collectors.toList());
		// 썸네일 파일 추가
		fileList.stream().filter(vo -> vo.isFiletype() == true).map(vo -> Paths.get("C:\\upload", vo.getUploadpath(), "s_" + vo.getUuid() + "_" + vo.getFilename())).forEach(p -> fileListPaths.add(p));
		log.warn("==================================");
		fileListPaths.forEach(p -> log.warn(p));
		
		// 어제 날짜의 경로에 있는 파일
		File targetDir = Paths.get("C:\\upload", getFolderYesterDay()).toFile();	
		File[] removeFiles = targetDir.listFiles(file -> fileListPaths.contains(file.toPath())==false);
		log.warn("----------------------------------");
		for (File file : removeFiles) {
			log.warn(file.getAbsolutePath());
			file.delete();
		}
		}
}
