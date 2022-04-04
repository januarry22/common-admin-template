package kr.mypr.admin.controller.agree;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import kr.mypr.admin.service.MasterService;
import kr.mypr.admin.util.Common;
@RestController
@RequestMapping(value = "/supervise/admin/v1/agree/**")
public class AgreeRestController {


	@Inject MasterService masterService;
	
	@PostMapping("/create")
	public ResponseEntity<Map<String, Object>> dashboard(HttpServletRequest request, @RequestBody  HashMap param) throws Exception {
		ResponseEntity<Map<String, Object>> entity = null;
		Map<String, Object> map = new HashMap<String, Object>();
		
		int record = masterService.dataCreate("mapper.admin.AgreeMapper", "create", param);
		map.put("success", false);
		if(record > 0) map.put("success", true); map.put("msg", "약관 등록 완료되었습니다.");
		
		try {entity = new ResponseEntity<Map<String, Object>>(map,HttpStatus.OK);} 
		catch (Exception e) {entity = new ResponseEntity<Map<String, Object>>(map,HttpStatus.BAD_REQUEST);}
		Common.returnPrint(Common.GmakeDynamicValueObject(entity));
		
		return entity;
	}

	
	@PostMapping("/search")
	public ResponseEntity<Map<String, Object>> listdashboard(HttpServletRequest request,@RequestBody HashMap param) throws Exception {
		ResponseEntity<Map<String, Object>> entity = null;
		Map<String, Object> map = new HashMap<String, Object>();
		int record = masterService.dataList("mapper.admin.AgreeMapper", "search", param).size();

		map.put("success", false);
		if(record > 0) map.put("success", true);
		
		List<HashMap<String,Object>> list = (List<HashMap<String,Object>>)masterService.dataList("mapper.admin.MemberMapper", "search", param);

		map.put("data", list); 

		try {entity = new ResponseEntity<Map<String, Object>>(map,HttpStatus.OK);} 
		catch (Exception e) {entity = new ResponseEntity<Map<String, Object>>(map,HttpStatus.BAD_REQUEST);}
		Common.returnPrint(Common.GmakeDynamicValueObject(entity));
		
		return entity;
	}
	
	
	@PostMapping("/update")
	public ResponseEntity<Map<String, Object>> update(HttpServletRequest request, @RequestBody HashMap param) throws Exception {
		ResponseEntity<Map<String, Object>> entity = null;
		Map<String, Object> map = new HashMap<String, Object>();
		
		int record = masterService.dataUpdate("mapper.admin.AgreeMapper", "update", param);
		map.put("success", false);
		if(record > 0) map.put("success", true);  map.put("msg", "약관 수정 완료되었습니다.");
		
		try {entity = new ResponseEntity<Map<String, Object>>(map,HttpStatus.OK);} 
		catch (Exception e) {entity = new ResponseEntity<Map<String, Object>>(map,HttpStatus.BAD_REQUEST);}
		Common.returnPrint(Common.GmakeDynamicValueObject(entity));
		
		return entity;
	}
	
	@GetMapping("/remove")
	public ResponseEntity<Map<String, Object>> removeDELETE(@RequestParam(value = "seq" , required = false) String seq) throws Exception {
		ResponseEntity<Map<String, Object>> entity = null;		Map<String, Object> map = new HashMap<String, Object>();
		
		int record = masterService.dataUpdate("mapper.admin.AgreeMapper", "remove", seq);
		map.put("success", false);
		if(record > 0) map.put("success", true);
		
		try {entity = new ResponseEntity<Map<String, Object>>(map,HttpStatus.OK);} 
		catch (Exception e) {entity = new ResponseEntity<Map<String, Object>>(map,HttpStatus.BAD_REQUEST);}
		Common.returnPrint(Common.GmakeDynamicValueObject(entity));
		
		return entity;
	}

}
