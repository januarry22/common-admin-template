package kr.mypr.admin.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

@Service
public class DashBoardService {
	
	@Inject MasterService masterService;
	

	// 전체 서비스, 신규 가입 
	public Map<String, Object> dashBoardSign(Map<String, Object> param) {
		Map<String, Object> res = new HashMap();
		param.put("table_name", "member");
		res.put("sign", masterService.dataCount("mapper.admin.DashBoardMapper", "count", param));
		res.put("total", masterService.dataCount("mapper.admin.DashBoardMapper", "total", param));
	//	res.put("history", masterService.dataCount("mapper.admin.DashBoardMapper", "history", param));
		res.put("not", masterService.dataCount("mapper.admin.DashBoardMapper", "not", param));
		res.put("total_growth", masterService.dataRead("mapper.admin.DashBoardMapper", "total_growth", param));
		res.put("nothistory_total_growth", masterService.dataRead("mapper.admin.DashBoardMapper", "nothistory_total_growth", param));
		res.put("history_total_growth", masterService.dataRead("mapper.admin.DashBoardMapper", "history_total_growth", param));
		res.put("member_total_growth", masterService.dataRead("mapper.admin.DashBoardMapper", "member_total_growth", param));
		
		return res;
	}


	/* 컨텐츠 재생 순위 */
	public List<HashMap<String,Object>> dashContentPlay(Map<String, Object> param) {
	
		List<HashMap<String,Object>> contentPlay =(List<HashMap<String,Object>>) masterService.dataList("mapper.admin.DashBoardMapper", "play", param);
	
		return contentPlay;
	}

	/* 컨텐츠 좋아요 순위 */
	public List<HashMap<String,Object>> dashContentGoods(Map<String, Object> param) {
		
		List<HashMap<String,Object>> contentGoods =(List<HashMap<String,Object>>) masterService.dataList("mapper.admin.DashBoardMapper", "goods", param);
		
		return contentGoods;
	}

	/* 메인 문의 리스트 */
	public void dashContactList(Model model) {
		
		model.addAttribute("contact",(List<HashMap<String,Object>>) masterService.dataList("mapper.admin.DashBoardMapper", "contact", null));
	
	}

	/* 유형별 어제 수면측정한 사용자 수 차트 */
	public void dashBoardHistory(Model model,String date) {
		Map<String, Object> res = new HashMap();
		res.put("date",date);
		res.put("table_name","sleep_history");
		//model.addAttribute("history_growth",masterService.dataRead("mapper.admin.DashBoardMapper", "total_growth", res));
	
		model.addAttribute("history",masterService.dataCount("mapper.admin.DashBoardMapper", "history", null));
		model.addAttribute("notHistory", masterService.dataCount("mapper.admin.DashBoardMapper", "not", null));
		model.addAttribute("notHistoryList",(List<HashMap<String,Object>>) masterService.dataList("mapper.admin.DashBoardMapper", "notList", null));
		
	}
	

	/* 어제 수면측정안한 사람 */
	public List<HashMap<String,Object>> dashboardNotHistory(Map<String, Object> param) {
		List<HashMap<String,Object>> notHistoryList =(List<HashMap<String,Object>>) masterService.dataList("mapper.admin.DashBoardMapper", "notList", param);
	
		return notHistoryList;
	}

	/* 유형별 어제 수면측정한 사용자 수 차트 */
	public HashMap<String,Object> typeHistoryChart(Map<String, Object> param) {	
		HashMap<String, Object> res = new HashMap<String, Object>();
		List<HashMap<String,Object>> typeHistoryChart = (List<HashMap<String,Object>>) masterService.dataList("mapper.admin.DashBoardMapper", "type_history",param);
			for(int i=0; i<typeHistoryChart.size();i++) {
				res.put(typeHistoryChart.get(i).get("name").toString(),typeHistoryChart.get(i).get("count"));
			}
		return res;
	}
	
	
	/* 유형별 사용자 수 차트 */
	public HashMap<String,Object> typeUserChart(Map<String, Object> param) {
		HashMap<String, Object> res = new HashMap<String, Object>();
		List<HashMap<String,Object>> typeUserChart = (List<HashMap<String,Object>>) masterService.dataList("mapper.admin.DashBoardMapper", "type", param);
			for(int i=0; i<typeUserChart.size();i++) {
				res.put(typeUserChart.get(i).get("name").toString(),typeUserChart.get(i).get("count"));
			}	
		return res;
	}
	

	/* 유형별 미션 차트 */
	public HashMap<String,Object> missionTypeChart(Map<String, Object> param) {
		LinkedHashMap<String, Object> res = new LinkedHashMap<String, Object>();
		List<HashMap<String,Object>> typeList = (List<HashMap<String,Object>>) masterService.dataList("mapper.admin.SleepMapper", "list", null);

		
		for(int i=0; i<typeList.size();i++) {	
			param.put("type_seq",typeList.get(i).get("type_seq"));
			
			res.put("합계",listToArray((List<HashMap<String,Object>>)masterService.dataList("mapper.admin.DashBoardMapper", "mission_cnt", param),"count"));
			res.put(typeList.get(i).get("name").toString(), listToArray((List<HashMap<String,Object>>) masterService.dataList("mapper.admin.DashBoardMapper", "mission_complate", param),"count"));
			
		}
		return res;
	}
	

	/* 사용자 수면점수 평균 차트 */
	public List<HashMap<String,Object>> avgChart(Map<String, Object> param) {
		HashMap<String, Object> res = new HashMap<String, Object>();
		List<HashMap<String,Object>> avgChart = (List<HashMap<String,Object>>) masterService.dataList("mapper.admin.DashBoardMapper", "avgChart", param);
	
		return avgChart;
	}
	
	
	public ArrayList listToArray(List<HashMap<String,Object>> param,String value) {
		ArrayList array = new ArrayList();
		
		for(int j=0; j<param.size();j++) {	
			
			array.add(param.get(j).get(value));
		}
		return array;
	}
	
}
