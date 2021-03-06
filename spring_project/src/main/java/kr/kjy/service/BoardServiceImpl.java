package kr.kjy.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.kjy.mapper.BoardAttachMapper;
import kr.kjy.mapper.BoardMapper;
import kr.kjy.mapper.ReplyMapper;
import kr.kjy.model.BoardAttachVO;
import kr.kjy.model.BoardVO;
import kr.kjy.model.Criteria;
import lombok.RequiredArgsConstructor;
import lombok.Setter;
import lombok.ToString;
import lombok.extern.log4j.Log4j;

@Service
@ToString
public class BoardServiceImpl implements BoardService {
	
	@Setter(onMethod_ = @Autowired)
	private BoardMapper mapper;
	@Setter(onMethod_ = @Autowired)
	private BoardAttachMapper attachMapper;
	@Setter(onMethod_ = @Autowired)
	private ReplyMapper replyMapper;
	
	@Transactional
	@Override
	public void register(BoardVO vo) {
		mapper.BoardInsertSelectKey(vo);
		if(vo.getAttachList() == null || vo.getAttachList().size() <= 0) {
			return;
		}
		vo.getAttachList().forEach(attach ->{
			attach.setBno(vo.getBno());
			attachMapper.insert(attach);
		});
	}

	@Override
	public BoardVO get(Long bno) {
		return mapper.BoardRead(bno);
	}

	@Transactional
	@Override
	public boolean modify(BoardVO vo) {
		attachMapper.deleteAll(vo.getBno());
		boolean modifyResult = mapper.BoardUpdate(vo) == 1;
		if(modifyResult && vo.getAttachList() != null && vo.getAttachList().size() > 0) {
			vo.getAttachList().forEach(attach -> {
				attach.setBno(vo.getBno());
				attachMapper.insert(attach);
			});
		}
		return modifyResult;
	}
	
	@Transactional
	@Override
	public int remove(Long bno) {
		replyMapper.deleteAll(bno);
		attachMapper.deleteAll(bno);
		return mapper.BoardDelete(bno);
	}

	@Override
	public List<BoardVO> getList() {
		return mapper.getBoardList();
	}

	@Override
	public List<BoardVO> getList(Criteria cri) {
		return mapper.getListWithPaging(cri);
	}

	@Override
	public int getTotal(Criteria cri) {
		return mapper.getTotalCount(cri);
	}

	@Override
	public List<BoardAttachVO> getAttachList(Long bno) {
		return attachMapper.findByBno(bno);
	}
	
}
