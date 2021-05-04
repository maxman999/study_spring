package kr.kjy.service;

import java.util.List;

import kr.kjy.model.BoardAttachVO;
import kr.kjy.model.BoardVO;
import kr.kjy.model.Criteria;

public interface BoardService {
	
	void register(BoardVO vo);
	BoardVO get(Long bno);
	boolean modify(BoardVO vo);
	int remove(Long bno);
	List<BoardVO> getList();
	List<BoardVO> getList(Criteria cri);
	int getTotal(Criteria cri);
	List<BoardAttachVO> getAttachList(Long bno);
}
