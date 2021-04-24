package kr.kjy.mapper;

import org.apache.ibatis.annotations.Select;

public interface TimeMapper {

	@Select("select sysdate()")
	String getTime();
	
	String getTime2();
}
