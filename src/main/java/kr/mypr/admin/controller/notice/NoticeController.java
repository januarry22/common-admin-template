package kr.mypr.admin.controller.notice;

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
@RequestMapping(value = "/admin/notice/*")
public class NoticeController {

	private static final Logger logger = LoggerFactory.getLogger(NoticeController.class);
	 
	@Inject MasterService masterService;
	

	@RequestMapping(value ={ "/notice_list" }, method = RequestMethod.GET)
	public String noticeList(HttpServletRequest request, HttpServletResponse response, Model model, HttpSession session) throws Exception {
		List<HashMap<String,Object>> list =  (List<HashMap<String,Object>>) masterService.dataList("mapper.admin.BoardMapper", "list", null);
		model.addAttribute("list", list);

		return "layout/notice/list";
	}
	
	@RequestMapping(value = {"/{seq}"} , method = RequestMethod.GET)
	public String noticeDetail(Model model , @PathVariable String seq ) throws Exception {
		model.addAttribute("detail", masterService.dataRead("mapper.admin.BoardMapper", "detail", seq));
		model.addAttribute("category",(List<HashMap<String,Object>>) masterService.dataList("mapper.admin.BoardMapper", "common", null));
		return "layout/notice/detail";
	}

	@RequestMapping(value = {"/create"} , method = RequestMethod.GET)
	public String noticeCreate(Model model) throws Exception {
		// board 카테고리 
		model.addAttribute("category",(List<HashMap<String,Object>>) masterService.dataList("mapper.admin.BoardMapper", "common", null));
		return "layout/notice/create";
	}
	
	@RequestMapping(value = {"/update/{seq}"} , method = RequestMethod.GET)
	public String noticeUpdate(Model model, @PathVariable String seq) throws Exception {
		model.addAttribute("detail", masterService.dataRead("mapper.admin.BoardMapper", "detail", seq));

		return "layout/notice/update";
	}
}
