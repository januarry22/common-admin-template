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
	@RequestMapping(value = {"/excel"}, method = RequestMethod.GET)
	public ModelAndView excelView(Model model) throws Exception {
		//List<LinkedHashMap> list = (List<LinkedHashMap>) masterService.dataList("mapper.admin.MemberMapper", "excel", null);
		List<LinkedHashMap> list = (List) MasterDao.dataList("mapper.admin.MemberMapper", "excel", null);
		for(int i = 0 ; i < list.size() ; i++) {
			HashMap paramMap = new HashMap<String, Object>();
			paramMap.put("member_seq", list.get(i).get("member_seq"));
			List<HashMap<String,Object>> drug = (List) masterService.dataList("mapper.admin.MemberMapper", "excel_drug", paramMap);
		//	System.out.print("drug ::"+drug+"\n");
			String result = Common.ArrayToString(drug);
			list.get(i).put("drug", result);		
		}
		HashMap<String, Object> map = new HashMap<String, Object>();
		String[] header = {"회원SEQ","닉네임","회원가입 날짜","성별","출생년도","직업","수면유형","질병 및 약물"};
		map.put("headers", header);
		map.put("filename", "gonne-userinfo");
		map.put("datas", list);
		
		return new ModelAndView("excelView", map); 
		//return null;
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
//	@RequestMapping(value = {"/create"} , method = RequestMethod.GET)
//	public String MemberAddGET(Model model) throws Exception {
//		return "adminLayout/admin/member/create";
//	}
//	@RequestMapping(value = {"/update/{seq}"} , method = RequestMethod.GET)
//	public String MemberUpdateGET(Model model, @PathVariable String seq) throws Exception {
//		model.addAttribute("detail", masterService.dataRead("mapper.admin.MemberMapper", "detail", seq));
//
//		return "layout/member/update";
//	}
	                            
}
