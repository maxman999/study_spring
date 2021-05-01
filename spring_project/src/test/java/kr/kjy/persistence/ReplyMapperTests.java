package kr.kjy.persistence;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import kr.kjy.mapper.ReplyMapper;
import kr.kjy.model.Criteria;
import kr.kjy.model.ReplyVO;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class ReplyMapperTests {
	
	@Setter(onMethod_ = @Autowired)
	private ReplyMapper mapper;
	
	@Test
	public void testMapper() {
		log.info(mapper);
	}
	
	@Test
	public void testInsert() {
		ReplyVO vo = new ReplyVO();
		vo.setBno(2500L);
		vo.setReplyer("테스터");
		for (int i = 0 ; i < 80 ; i++ ) {
		vo.setReply("테스트 리플 " + i);
		log.info(mapper.insert(vo));
		}
	}
	
	@Test
	public void testRead() {
		log.info(mapper.read(39L));
	}
	
	@Test
	public void testDelete() {
		log.info(mapper.delete(38L));
	}
	
	
	@Test
	public void testUpdate() {
		Long targetRno = 38L;
		ReplyVO vo = mapper.read(targetRno);
		vo.setReply("수정 테스트");
		log.info(mapper.update(vo));
	}
	
	@Test
	public void testList() {
		Criteria cri = new Criteria();
		List<ReplyVO> replies = mapper.getListWithPaging(cri, 5002L);
		replies.forEach(reply -> log.info(reply));
	}
	
	@Test
	public void testList2() {
		Criteria cri = new Criteria(11,10,2);
		List<ReplyVO> replies = mapper.getListWithPaging(cri, 2500L);
		replies.forEach(reply -> log.info(reply));
	}
	
}
