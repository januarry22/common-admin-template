package kr.mypr.admin.controller.admin;

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
@RequestMapping(value = "/admin/admin/**")
public class AdminController {


	private static final Logger logger = LoggerFactory.getLogger(AdminController.class);
	 
	@Inject MasterService masterService;
	

	@RequestMapping(value ={ "/admin_list" }, method = RequestMethod.GET)
	public String admindashboard(HttpServletRequest request, HttpServletResponse response, Model model, HttpSession session) throws Exception {

		List<HashMap<String,Object>> list =  (List<HashMap<String,Object>>) masterService.dataList("mapper.admin.AdminMapper", "list", null);
		model.addAttribute("list", list);
		
		return "layout/admin/list";
	}
	@RequestMapping(value ={ "/log" }, method = RequestMethod.GET)
	public String adminHistory(HttpServletRequest request, HttpServletResponse response, Model model, HttpSession session) throws Exception {

		List<HashMap<String,Object>> list =  (List<HashMap<String,Object>>) masterService.dataList("mapper.admin.AdminMapper", "list", null);
		model.addAttribute("list", list);

		return "layout/admin/log";
	}
	@RequestMapping(value = {"/{seq}"} , method = RequestMethod.GET)
	public String adminDetailGET(Model model , @PathVariable String seq ) throws Exception {
		model.addAttribute("detail", masterService.dataRead("mapper.admin.AdminMapper", "detail", seq));

		return "layout/admin/update";
	}
	@RequestMapping(value ={ "/create" }, method = RequestMethod.GET)
	public String adminCreate(HttpServletRequest request, HttpServletResponse response, Model model, HttpSession session) throws Exception {

		List<HashMap<String,Object>> list =  (List<HashMap<String,Object>>) masterService.dataList("mapper.admin.AdminMapper", "bickdata", null);
		model.addAttribute("list", list);
		
		return "layout/admin/create";
	}
	                            
}
