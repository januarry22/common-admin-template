package kr.mypr.admin.controller.login;

import java.util.HashMap;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import kr.mypr.admin.service.MasterService;
import kr.mypr.admin.util.Common;


@RestController
public class LoginsRestController {


	@Inject MasterService masterService;
	
	/* 로그인 */
	@PostMapping("/api/v1/login/admin")
	public ResponseEntity<Map<String, Object>> login_proc(HttpServletRequest request, HttpServletResponse response, HttpSession session, @RequestBody HashMap param) throws Exception {
		ResponseEntity<Map<String, Object>> entity = null;
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("success", false);
	
		HashMap paramMap = new HashMap(param);
		
		HashMap<String, Object> retMap = null;
		int login_check = masterService.dataCount("mapper.admin.LoginMapper", "login", paramMap);
		if (login_check>0) {
			retMap = (HashMap) masterService.dataRead("mapper.admin.LoginMapper", "detail", paramMap);
			session.setAttribute("ADMIN", retMap);
            session.setMaxInactiveInterval(10800);
			map.put("success", true);
		}
	        
		
		try {entity = new ResponseEntity<Map<String, Object>>(map,HttpStatus.OK);} 
		catch (Exception e) {entity = new ResponseEntity<Map<String, Object>>(map,HttpStatus.BAD_REQUEST);}
		Common.returnPrint(Common.GmakeDynamicValueObject(entity));
		
		return entity;
	}
}
