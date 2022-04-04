package kr.mypr.admin.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

@Service
public class CommonService {
	
	@Inject MasterService masterService;
	

	public void commonList(Model model, String up_code) {

		Map<String,Object> res = new HashMap();
		res.put("up_code", up_code);
		model.addAttribute("common",(List<HashMap<String,Object>>) masterService.dataList("mapper.admin.CommonMapper", "common", res));
		
	}


	public void drugList(Model model) {
		model.addAttribute("drug",(List<HashMap<String,Object>>) masterService.dataList("mapper.admin.DrugMapper", "list", null));
	}
	
	public void	goodsList(Model model,String seq) {
		model.addAttribute("goods",(List<HashMap<String,Object>>) masterService.dataList("mapper.admin.MemberMapper", "goods", seq));
	}
	public void	historyList(Model model,String seq) {
		model.addAttribute("history",(List<HashMap<String,Object>>) masterService.dataList("mapper.admin.MemberMapper", "history", seq));
		model.addAttribute("comment",(List<HashMap<String,Object>>) masterService.dataList("mapper.admin.MemberMapper", "comment", seq));
	}
}
