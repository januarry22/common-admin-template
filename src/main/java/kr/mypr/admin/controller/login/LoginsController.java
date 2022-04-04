package kr.mypr.admin.controller.login;

import kr.mypr.admin.service.DashBoardService;
import kr.mypr.admin.service.MasterService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.UnsupportedEncodingException;
import java.util.HashMap;

@Controller
public class LoginsController {
	

	@Inject MasterService masterService;
	@Inject DashBoardService dashBoardService;

	
	private static final Logger logger = LoggerFactory.getLogger(LoginsController.class);
	
	/**
	 * Simply selects the home view to render by returning its name.
	 * @throws Exception 
	 */
	/*login */
	@RequestMapping(value ={ "/" }, method = RequestMethod.GET)
	public String dashboard(HttpServletRequest request, HttpServletResponse response, Model model, HttpSession session) throws Exception {
		HashMap<String, Object> loginCheck = (HashMap) session.getAttribute("ADMIN");
	//	System.out.print("loginCheck"+loginCheck.get("id"));
//		if(loginCheck != null && !"".equals(loginCheck)) {
//
//			//return "layout/main/index";
//			return "redirect:/main/index";
//		}else {
//			return "notLayout/main/login";
//		}
		return "layout/main/index";
	}  
	@RequestMapping(value ={ "/main/index" }, method = RequestMethod.GET)
	public String maindashboard(HttpServletRequest request, HttpServletResponse response, Model model, HttpSession session) throws Exception {

		dashBoardService.dashContactList(model);
		return "layout/main/index";
	}  
	/**
	 * 로그아웃 
	 */
	@RequestMapping(value = {"/logout"}, method =  { RequestMethod.GET , RequestMethod.POST })
	public String logout(Model model, HttpServletRequest request, HttpSession session) throws UnsupportedEncodingException {
		session.invalidate();
		return "redirect:/";
	}
}
