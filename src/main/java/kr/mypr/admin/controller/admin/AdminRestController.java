package kr.mypr.admin.controller.admin;

import kr.mypr.admin.service.MasterService;
import kr.mypr.admin.util.Common;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.Map;
@RestController
@RequestMapping(value = "/api/v1/admin/**")
public class AdminRestController {


	@Inject MasterService masterService;
	
	@PostMapping("/create")
	public ResponseEntity<Map<String, Object>> dashboard(HttpServletRequest request, @RequestBody  HashMap param) throws Exception {
		ResponseEntity<Map<String, Object>> entity = null;
		Map<String, Object> map = new HashMap<String, Object>();
		
		int record = masterService.dataCreate("mapper.admin.AdminMapper", "create", param);
		map.put("success", false);
		if(record > 0) map.put("success", true);
		
		try {entity = new ResponseEntity<Map<String, Object>>(map,HttpStatus.OK);} 
		catch (Exception e) {entity = new ResponseEntity<Map<String, Object>>(map,HttpStatus.BAD_REQUEST);}
		Common.returnPrint(Common.GmakeDynamicValueObject(entity));
		
		return entity;
	}
	
	@PostMapping("/update")
	public ResponseEntity<Map<String, Object>> update(HttpServletRequest request, @RequestBody HashMap param) throws Exception {
		ResponseEntity<Map<String, Object>> entity = null;
		Map<String, Object> map = new HashMap<String, Object>();
		
		int record = masterService.dataUpdate("mapper.admin.AdminMapper", "update", param);
		map.put("success", false);
		if(record > 0) map.put("success", true);
		
		try {entity = new ResponseEntity<Map<String, Object>>(map,HttpStatus.OK);} 
		catch (Exception e) {entity = new ResponseEntity<Map<String, Object>>(map,HttpStatus.BAD_REQUEST);}
		Common.returnPrint(Common.GmakeDynamicValueObject(entity));
		
		return entity;
	}
	
}
