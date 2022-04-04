package kr.mypr.admin.controller.payment;

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
import java.util.HashMap;
import java.util.List;


@Controller
@RequestMapping(value = "/admin/payment/*")
public class PaymentController {

	private static final Logger logger = LoggerFactory.getLogger(PaymentController.class);
	 
	@Inject MasterService masterService;

	/* 결제 내역 리스트 */
	@RequestMapping(value ={ "/payment_list" }, method = RequestMethod.GET)
	public String paymentList(HttpServletRequest request, HttpServletResponse response, Model model, HttpSession session) throws Exception {
		List<HashMap<String,Object>> list =  (List<HashMap<String,Object>>) masterService.dataList("mapper.admin.BoardMapper", "list", null);
		model.addAttribute("list", list);
		return "layout/payment/list";
	}

//	/* 결제 내역 통계 */
//	@RequestMapping(value ={ "/payment_dashboard" }, method = RequestMethod.GET)
//	public String paymentChart(HttpServletRequest request, HttpServletResponse response, Model model, HttpSession session) throws Exception {
//		List<HashMap<String,Object>> list =  (List<HashMap<String,Object>>) masterService.dataList("mapper.admin.BoardMapper", "list", null);
//		model.addAttribute("list", list);
//		return "layout/payment/dashboard";
//	}

	/* 결제 방법 관리 */
	@RequestMapping(value = {"/create"} , method = RequestMethod.GET)
	public String noticeCreate(Model model) throws Exception {

		model.addAttribute("category",(List<HashMap<String,Object>>) masterService.dataList("mapper.admin.BoardMapper", "common", null));
		return "layout/payment/create";
	}
}
