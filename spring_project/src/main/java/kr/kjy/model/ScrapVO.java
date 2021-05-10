package kr.kjy.model;

import java.util.Date;

import lombok.Data;

@Data
public class ScrapVO {
	
	private Long sno;
	private String title, description, originallink, pubdate;
	
}
