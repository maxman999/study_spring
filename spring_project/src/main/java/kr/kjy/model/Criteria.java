package kr.kjy.model;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class Criteria {
	// 페이징 처리
	private int startNum;
	private int amount;
	private int pageNum;
	
	// 검색 처리
	private String type; // t, tc, tcw, cw,
	private String keyword; 
	
	
	public Criteria() {
		this(0,10,1);
	}
	
	public Criteria(int startNum, int amount, int pageNum) {
		super();
		this.amount = amount;
		this.pageNum = startNum/amount+1;
		this.startNum = startNum;
	}
	
	public String[] getTypeArr() {
		return type == null? new String[] {} : type.split("");
	}
	
}
