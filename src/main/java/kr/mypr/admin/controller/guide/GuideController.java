package kr.mypr.admin.controller.guide;

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

import kr.mypr.admin.service.CommonService;
import kr.mypr.admin.service.MasterService;


@Controller
@RequestMapping(value = "/admin/guide/*")
public class GuideController {

	private static final Logger logger = LoggerFactory.getLogger(GuideController.class);
	 
	@Inject MasterService masterService;
	@Inject CommonService commonService;
	
	// 수면 유형 가이드 
	@RequestMapping(value ={ "/sleep" }, method = RequestMethod.GET)
	public String boardList(HttpServletRequest request, HttpServletResponse response, Model model, HttpSession session) throws Exception {
		List<HashMap<String,Object>> list =  (List<HashMap<String,Object>>) masterService.dataList("mapper.admin.SleepMapper", "list", null);
		model.addAttribute("list", list);
		return "layout/guide/sleep";
	}
	// 미션 가이드 
	@RequestMapping(value ={ "/mission" }, method = RequestMethod.GET)
	public String keywordList(HttpServletRequest request, HttpServletResponse response, Model model, HttpSession session) throws Exception {
		List<HashMap<String,Object>> list =  (List<HashMap<String,Object>>) masterService.dataList("mapper.admin.MissionMapper", "list", null);
		model.addAttribute("list", list);
		return "layout/guide/mission";
	}
	// 유형 가이드 상세 
	@RequestMapping(value = {"/sleep/{seq}"} , method = RequestMethod.GET)
	public String sleepguideDetail(Model model , @PathVariable String seq ) throws Exception {
		
		model.addAttribute("detail", masterService.dataRead("mapper.admin.SleepMapper", "detail", seq));
		return "layout/guide/sleep_read";
	}
	// 미션 가이드 상세 
	@RequestMapping(value = {"/mission/{seq}"} , method = RequestMethod.GET)
	public String missionguideDetail(Model model , @PathVariable String seq ) throws Exception {
		model.addAttribute("detail", masterService.dataRead("mapper.admin.MissionMapper", "detail", seq));
		return "layout/guide/mission_read";
	}
}
