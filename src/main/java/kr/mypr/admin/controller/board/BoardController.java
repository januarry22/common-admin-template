package kr.mypr.admin.controller.board;

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
@RequestMapping(value = "/admin/board/*")
public class BoardController {

	private static final Logger logger = LoggerFactory.getLogger(BoardController.class);
	 
	@Inject MasterService masterService;

	/*게시판 리스트 */
	@RequestMapping(value ={ "/b_section_list" }, method = RequestMethod.GET)
	public String boardList(HttpServletRequest request, HttpServletResponse response, Model model, HttpSession session) throws Exception {
		List<HashMap<String,Object>> list =  (List<HashMap<String,Object>>) masterService.dataList("mapper.admin.BoardMapper", "list", null);
		model.addAttribute("list", list);
		model.addAttribute("category",(List<HashMap<String,Object>>) masterService.dataList("mapper.admin.BoardMapper", "common", null));
		return "layout/board/section_list";
	}

	/*게시판 전체 게시글 리스트 */
	@RequestMapping(value = {"/board_list"} , method = RequestMethod.GET)
	public String boardDetail(Model model) throws Exception {
		List<HashMap<String,Object>> list =  (List<HashMap<String,Object>>) masterService.dataList("mapper.admin.BoardMapper", "list", null);
		model.addAttribute("list", list);
		return "layout/board/list";
	}
	@RequestMapping(value = {"/create"} , method = RequestMethod.GET)
	public String booadCreate(Model model) throws Exception {
		// board 카테고리 
		model.addAttribute("category",(List<HashMap<String,Object>>) masterService.dataList("mapper.admin.BoardMapper", "common", null));
		return "layout/board/create";
	}
	
	@RequestMapping(value = {"/update/{seq}"} , method = RequestMethod.GET)
	public String boardUpdate(Model model, @PathVariable String seq) throws Exception {
		model.addAttribute("detail", masterService.dataRead("mapper.admin.BoardMapper", "detail", seq));

		return "layout/board/update";
	}
}
