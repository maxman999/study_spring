package kr.kjy.persistence;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import kr.kjy.mapper.BoardMapper;
import kr.kjy.model.BoardVO;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class BoardMapperTests {
	
	@Autowired
	private BoardMapper boardMapper;
	
	@Test
	public void testGetBoardList() {
		
		log.info("-------------------------");
		log.info(boardMapper.getBoardList());
	}
	
	@Test
	public void testInsert() {
		
		BoardVO vo = new BoardVO();
		vo.setTitle("test 테스트");
		vo.setContent("content 테스트");
		vo.setWriter("writer 테스트");
		
		boardMapper.BoardInsert(vo);
		log.info("-------------------------");
		log.info(boardMapper.getBoardList());
		log.info("after insert => " + vo.getBno());
		log.info("-------------------------");
	}
	
	@Test
	public void testInsertSelectKey() {
		BoardVO vo = new BoardVO();
		vo.setTitle("test 테스트2");
		vo.setContent("content 테스트2");
		vo.setWriter("writer 테스트2");
		
		boardMapper.BoardInsertSelectKey(vo);
		log.info("-------------------------");
		log.info(boardMapper.getBoardList());
		log.info("after insert selectKey => " + vo.getBno());
		log.info("-------------------------");
	}
	
	@Test
	public void testBoardRead() {
		log.info("-------------------------");
		log.info(boardMapper.BoardRead(9L));
	}
	
	@Test
	public void testBoardDelete() {
		log.info("-------------------------");
		int count = boardMapper.BoardDelete(1L);
		log.info(count);
	}
	
	@Test
	public void testBoardUpdate() {
		BoardVO vo = new BoardVO();
		vo.setBno(2L);
		vo.setTitle("Updated title");
		vo.setContent(" Updated content");
		vo.setWriter("Updated writer");
		
		log.info("-------------------------");
		int count = boardMapper.BoardUpdate(vo);
		log.info(count);
	}
	
}
