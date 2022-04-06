package kr.mypr.admin.controller.member;

import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.mypr.admin.service.CommonService;
import kr.mypr.admin.service.MasterService;
import kr.mypr.admin.util.Common;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping(value = "/admin/member/**")
public class MemberController {


	private static final Logger logger = LoggerFactory.getLogger(MemberController.class);
	 
	@Inject
    MasterService masterService;
	@Inject
    CommonService commonService;
	@Inject
    kr.mypr.admin.persistence.MasterDao MasterDao;
	
	

	@RequestMapping(value ={ "/list" }, method = RequestMethod.GET)
	public String dashboard(HttpServletRequest request, HttpServletResponse response, Model model, HttpSession session) throws Exception {

		List<HashMap<String,Object>> list =  (List<HashMap<String,Object>>) masterService.dataList("mapper.admin.MemberMapper", "list", null);
		model.addAttribute("list", list);
		commonService.commonList(model,"JOB");
		return "layout/member/list";
	}
	@RequestMapping(value = {"/{seq}"} , method = RequestMethod.GET)
	public String MemberDetailGET(Model model , @PathVariable String seq ) throws Exception {
		model.addAttribute("detail", masterService.dataRead("mapper.admin.MemberMapper", "detail", seq));
		model.addAttribute("member_drug", (List<HashMap<String,Object>>) masterService.dataList("mapper.admin.MemberMapper", "drug", seq));
		commonService.drugList(model);
		commonService.commonList(model,"JOB");
		
		commonService.goodsList(model, seq);
		commonService.historyList(model, seq);
		return "layout/member/read";
	}                      
}
