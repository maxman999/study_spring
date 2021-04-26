package kr.kjy.model;

import java.util.Date;

import lombok.Data;

@Data
public class BoardVO {
	
	private Long bno;
	private String title, content, writer;
	private Date regdate, updatedate;
	
}
