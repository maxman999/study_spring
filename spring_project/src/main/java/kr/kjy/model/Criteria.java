package kr.kjy.model;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class Criteria {
	private int startNum;
	private int amount;
	private int pageNum;
	
	
	public Criteria() {
		this(0,10,1);
	}
	
	/*
	 * public Criteria(int startNum, int amount) { super(); this.amount = amount;
	 * this.pageNum = startNum/amount+1; }
	 */
	
	public Criteria(int startNum, int amount, int pageNum) {
		super();
		this.amount = amount;
		this.pageNum = startNum/amount+1;
		this.startNum = startNum;
	}
}
