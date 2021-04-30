package kr.kjy.persistence;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import kr.kjy.mapper.BoardMapper;
import kr.kjy.model.BoardVO;
import kr.kjy.model.Criteria;
import kr.kjy.model.PageDTO;
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
	
	@Test
	public void dbTest() {
		
		BoardVO vo = new BoardVO();
		vo.setTitle("test 테스트");
		vo.setContent("content 테스트");
		vo.setWriter("writer 테스트");
		int i = 0;
		
		for( i = 0 ; i < 1000 ; i++ ) {
		boardMapper.BoardInsert(vo);
		}
		log.info("-------------------------");
		log.info(i + "개 삽입 완료");
		log.info("-------------------------");
	}
	
	@Test
	public void testPaging() {
		Criteria cri = new Criteria();
		log.info(cri);
		log.info("--------------------");
		List<BoardVO> list = boardMapper.getListWithPaging(cri);
		list.forEach(b -> log.info(b));
	}
	
	@Test
	public void testPageDTO() {
		Criteria cri = new Criteria();
		cri.setStartNum(243);
		PageDTO pagedto = new PageDTO(cri,250);
		log.info(pagedto);
		
	}
	
	@Test
	public void testSearchPaging() {
		//1 10
		Criteria cri = new Criteria();
		cri.setType("TCW");
		cri.setKeyword("등록");
		List<BoardVO> list = boardMapper.getListWithPaging(cri);
		list.forEach(b -> log.info(b));
	}
	
}
