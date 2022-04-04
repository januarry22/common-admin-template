package kr.mypr.admin.controller.common;

import java.util.HashMap;
import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import kr.mypr.admin.service.MasterService;


@Controller
@RequestMapping(value = "/admin/common/*")
public class CommonController {

	private static final Logger logger = LoggerFactory.getLogger(CommonController.class);
	 
	@Inject MasterService masterService;
	
	
	@RequestMapping(value ={ "/category" }, method = RequestMethod.GET)
	public String category(HttpServletRequest request, HttpServletResponse response, Model model, HttpSession session) throws Exception {
		List<HashMap<String,Object>> list =  (List<HashMap<String,Object>>) masterService.dataList("mapper.admin.BoardMapper", "common", null);
		model.addAttribute("list", list);
	
		return "layout/board/category";
	}
	@RequestMapping(value = {"/{seq}"} , method = RequestMethod.GET)
	public String boardDetail(Model model , @PathVariable String seq ) throws Exception {
		model.addAttribute("detail", masterService.dataRead("mapper.admin.BoardMapper", "detail", seq));
		model.addAttribute("category",(List<HashMap<String,Object>>) masterService.dataList("mapper.admin.BoardMapper", "common", null));
		return "layout/board/detail";
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
