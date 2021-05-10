package kr.kjy.persistence;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import kr.kjy.mapper.ScrapMapper;
import kr.kjy.model.ScrapVO;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class ScrapMapperTests {
	
	@Autowired
	private ScrapMapper mapper;
	
	@Test
	public void insertTest() {
		ScrapVO vo = new ScrapVO();
		vo.setDescription("[리포트] 오는 9월부터 경형 SUV 양산체제에 들어가는 광주형 일자리사업, 또 예비타당성 면제사업으로 추진중인 '인공지능 집적단지 조성사업'은 문재인정부 공약 가운데 순조롭게 이행되는 사업들입니다. 전남에서도...");
		vo.setOriginallink("https://news.kbs.co.kr/news/view.do?ncd=5182358&ref=A");
		vo.setPubdate("Mon, 10 May 2021 21:45:00 +0900");
		vo.setTitle("임기 1년 남은 文정부…시도 현안은?");
		log.info(mapper.insert(vo));
		
	}
	
}
