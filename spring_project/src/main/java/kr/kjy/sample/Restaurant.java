package kr.kjy.sample;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import lombok.AllArgsConstructor;
import lombok.RequiredArgsConstructor;
import lombok.Setter;
import lombok.ToString;

// Setter 주입 : @Setter(onMetod_ = {@Autowired})
// 생성자 주입 :  @AllArgsConstructor
// 필드 주입 : 그냥 @Autowired
// 파이널 필드 자동 주입 기능 : @RequiredArgsConstructor -> 요즘 가장 유행하는 방법 (파이널로 선언된 변수 등록)

@Component
@ToString
@RequiredArgsConstructor
public class Restaurant {
	
	private final Chef chef;
}
