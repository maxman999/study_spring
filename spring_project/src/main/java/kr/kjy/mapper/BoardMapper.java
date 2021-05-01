package kr.kjy.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import kr.kjy.model.BoardVO;
import kr.kjy.model.Criteria;

public interface BoardMapper {
	List<BoardVO> getBoardList();
	void BoardInsert(BoardVO vo);
	void BoardInsertSelectKey(BoardVO vo);
	BoardVO BoardRead(Long bno);
	int BoardDelete(Long bno);
	int BoardUpdate(BoardVO vo);
	List<BoardVO> getListWithPaging(Criteria cri);
	int getTotalCount(Criteria cri);
	void updateReplyCnt(@Param("bno") Long bno, @Param("amount") int amount);
}
