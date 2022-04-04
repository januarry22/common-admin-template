package kr.mypr.admin.controller.agree;

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
@RequestMapping(value = "/admin/agree/*")
public class AgreeController {

	private static final Logger logger = LoggerFactory.getLogger(AgreeController.class);
	 
	@Inject MasterService masterService;
	
	
	@RequestMapping(value ={ "/{agree_type}" }, method = RequestMethod.GET)
	public String boardList(HttpServletRequest request, HttpServletResponse response, Model model, HttpSession session, @PathVariable String agree_type) throws Exception {
		List<HashMap<String,Object>> list =  (List<HashMap<String,Object>>) masterService.dataList("mapper.admin.AgreeMapper", "list", agree_type);
		model.addAttribute("list", list);
		model.addAttribute("subject", list.get(0).get("type_info"));
		return "layout/agree/list";
	}
	@RequestMapping(value = {"/type/{seq}"} , method = RequestMethod.GET)
	public String boardDetail(Model model , @PathVariable String seq ) throws Exception {
		model.addAttribute("detail", masterService.dataRead("mapper.admin.AgreeMapper", "detail", seq));
		return "layout/agree/detail";
	}
	
	@RequestMapping(value = {"/create"} , method = RequestMethod.GET)
	public String boardUpdate(Model model) throws Exception {

		return "layout/agree/create";
	}
}
