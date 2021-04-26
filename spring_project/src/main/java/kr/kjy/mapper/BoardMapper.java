package kr.kjy.mapper;

import java.util.List;
import kr.kjy.model.BoardVO;

public interface BoardMapper {
	List<BoardVO> getBoardList();
	void BoardInsert(BoardVO vo);
	void BoardInsertSelectKey(BoardVO vo);
	BoardVO BoardRead(Long bno);
	int BoardDelete(Long bno);
	int BoardUpdate(BoardVO vo);
	
}
