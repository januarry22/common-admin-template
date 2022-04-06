package kr.mypr.admin.controller.note;

import kr.mypr.admin.service.MasterService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;


@Controller
@RequestMapping(value = "/admin/note/*")
public class NoteController {

	private static final Logger logger = LoggerFactory.getLogger(NoteController.class);
	 
	@Inject MasterService masterService;
	
	/* 관리자 노트 목록 */
	@RequestMapping(value ={ "/note_list" }, method = RequestMethod.GET)
	public String noteList(HttpServletRequest request, HttpServletResponse response, Model model, HttpSession session) throws Exception {
		List<HashMap<String,Object>> list =  (List<HashMap<String,Object>>) masterService.dataList("mapper.admin.BoardMapper", "list", null);
		model.addAttribute("list", list);

		return "layout/note/list";
	}

	/* 관리자 노트 상세 */
	@RequestMapping(value = {"/{seq}"} , method = RequestMethod.GET)
	public String noteDetail(Model model , @PathVariable String seq ) throws Exception {
		model.addAttribute("detail", masterService.dataRead("mapper.admin.BoardMapper", "detail", seq));
		model.addAttribute("category",(List<HashMap<String,Object>>) masterService.dataList("mapper.admin.BoardMapper", "common", null));
		return "layout/note/detail";
	}
	/* 관리자 노트 상세 */
	@RequestMapping(value = {"/{seq}"} , method = RequestMethod.GET)
	public String noteDetails(Model model , @PathVariable String seq ) throws Exception {
		model.addAttribute("detail", masterService.dataRead("mapper.admin.BoardMapper", "detail", seq));
		model.addAttribute("category",(List<HashMap<String,Object>>) masterService.dataList("mapper.admin.BoardMapper", "common", null));
		return "layout/note/detail";
	}
	/* 관리자 노트 생성 */
	@RequestMapping(value = {"/create"} , method = RequestMethod.GET)
	public String noteCreate(Model model) throws Exception {
		// board 카테고리 
		model.addAttribute("category",(List<HashMap<String,Object>>) masterService.dataList("mapper.admin.BoardMapper", "common", null));
		return "layout/note/create";
	}

	/* 관리자 노트 수정 */
	@RequestMapping(value = {"/update/{seq}"} , method = RequestMethod.GET)
	public String noteUpdate(Model model, @PathVariable String seq) throws Exception {
		model.addAttribute("detail", masterService.dataRead("mapper.admin.BoardMapper", "detail", seq));

		return "layout/note/update";
	}
}
