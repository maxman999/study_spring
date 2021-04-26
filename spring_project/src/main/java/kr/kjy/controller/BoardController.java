package kr.kjy.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.kjy.model.BoardVO;
import kr.kjy.service.BoardService;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@RequiredArgsConstructor
@RequestMapping("/board/*")
@Log4j
public class BoardController {
	
	private final BoardService service;
	
	@GetMapping("/list")
	public void list(Model model) {
		model.addAttribute("boardList", service.getList());
	}
	
	@GetMapping("/register")
	public void registerGET() {
		
	}
	
	@PostMapping("/register")
	public String resister(BoardVO vo, RedirectAttributes rttr) {
		log.info("board : " + vo);
		service.register(vo);
		Long bno = vo.getBno();
		log.info("BNO : " + bno);
		rttr.addFlashAttribute("result", bno);
		return "redirect:/board/list"; 
	}
	
	
	@GetMapping({"/get", "modify"})
	public void get(@RequestParam("bno") Long bno, Model model) {
		model.addAttribute("board", service.get(bno));
	}
	
	
	
	@PostMapping("/modify")
	public String modify(BoardVO vo, RedirectAttributes rttr) {
		int cnt = service.modify(vo);
		if(cnt == 1) {
			rttr.addFlashAttribute("result", "success");
		}
		return "redirect:/board/list"; 
	}
	@PostMapping("/remove")
	public String remove(@RequestParam("bno") Long bno, RedirectAttributes rttr) {
		int cnt = service.remove(bno);
		if(cnt == 1) {
			rttr.addFlashAttribute("result", "success");
		}
		return "redirect:/board/list"; 
	}
	
	
}
