package kr.kjy.service;

import java.util.List;

import org.springframework.stereotype.Service;

import kr.kjy.mapper.BoardMapper;
import kr.kjy.model.BoardVO;
import lombok.RequiredArgsConstructor;
import lombok.ToString;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
@RequiredArgsConstructor
@ToString
public class BoardServiceImpl implements BoardService {
	
	private final BoardMapper mapper;

	@Override
	public void register(BoardVO vo) {
		mapper.BoardInsertSelectKey(vo);
	}

	@Override
	public BoardVO get(Long bno) {
		return mapper.BoardRead(bno);
	}

	@Override
	public int modify(BoardVO vo) {
		return mapper.BoardUpdate(vo);
	}

	@Override
	public int remove(Long bno) {
		return mapper.BoardDelete(bno);
	}

	@Override
	public List<BoardVO> getList() {
		return mapper.getBoardList();
	}
	
}
