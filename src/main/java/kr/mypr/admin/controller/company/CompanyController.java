package kr.mypr.admin.controller.company;

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
@RequestMapping(value = "/admin/company/*")
public class CompanyController {

	private static final Logger logger = LoggerFactory.getLogger(CompanyController.class);
	 
	@Inject MasterService masterService;
	
	/* 회사 목록 */
	@RequestMapping(value ={ "/company_list" }, method = RequestMethod.GET)
	public String companyList(HttpServletRequest request, HttpServletResponse response, Model model, HttpSession session) throws Exception {
		List<HashMap<String,Object>> list =  (List<HashMap<String,Object>>) masterService.dataList("mapper.admin.BoardMapper", "list", null);
		model.addAttribute("list", list);

		return "layout/company/list";
	}

	/* 회사 지점 목록 */
	@RequestMapping(value ={ "/company_branch" }, method = RequestMethod.GET)
	public String companyBranchList(HttpServletRequest request, HttpServletResponse response, Model model, HttpSession session) throws Exception {
		List<HashMap<String,Object>> list =  (List<HashMap<String,Object>>) masterService.dataList("mapper.admin.BoardMapper", "list", null);
		model.addAttribute("list", list);

		return "layout/company/branch";
	}
	/* 회사 부서 목록 */
	@RequestMapping(value ={ "/company_branch/{seq}" }, method = RequestMethod.GET)
	public String companyPartList( Model model, @PathVariable String seq) throws Exception {
		List<HashMap<String,Object>> list =  (List<HashMap<String,Object>>) masterService.dataList("mapper.admin.BoardMapper", "list", null);
		model.addAttribute("list", list);

		return "layout/company/part";
	}
	/* 회사 멤버 목록 */
	@RequestMapping(value ={ "/company_total" }, method = RequestMethod.GET)
	public String companyTotalList( Model model, @PathVariable String seq) throws Exception {
		List<HashMap<String,Object>> list =  (List<HashMap<String,Object>>) masterService.dataList("mapper.admin.BoardMapper", "list", null);
		model.addAttribute("list", list);

		return "layout/company/part";
	}

}
