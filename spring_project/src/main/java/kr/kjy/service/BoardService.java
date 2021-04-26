package kr.kjy.service;

import java.util.List;

import kr.kjy.model.BoardVO;

public interface BoardService {
	
	void register(BoardVO vo);
	BoardVO get(Long bno);
	int modify(BoardVO vo);
	int remove(Long bno);
	List<BoardVO> getList();
}
