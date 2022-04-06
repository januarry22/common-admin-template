package kr.mypr.admin.controller.common;

import java.util.HashMap;
import java.util.Map;

import javax.inject.Inject;

import kr.mypr.admin.service.MasterService;
import kr.mypr.admin.util.Common;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping(value = "/supervise/admin/v1/common/**")
public class CommonRestController {


	@Inject
    MasterService masterService;
	
	
	/**
	 * 공통 중복체크 ( 메일, 폰 )
	 */
	@PostMapping("/check")  
	public ResponseEntity<Map<String, Object>> common_chk( @RequestBody HashMap param) throws Exception {
		ResponseEntity<Map<String, Object>> entity = null;
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("success", false);

		HashMap paramMap = new HashMap(param);
		HashMap<String, Object> retMap = null;
		retMap = (HashMap) masterService.dataRead("mapper.admin.CommonMapper", "common_chk", paramMap);
		
		if(retMap != null) {
			map.put("success", true);//중복되는게 잇을경우 true
		}
		
		entity = new ResponseEntity<Map<String, Object>>(map, HttpStatus.OK);
		Common.returnPrint(Common.GmakeDynamicValueObject(entity));
		return entity;  
	}
	/**
	 * 공통 삭제
	 */
	@PostMapping("/delete")  
	public ResponseEntity<Map<String, Object>> commonRemove( @RequestBody HashMap param) throws Exception {
		ResponseEntity<Map<String, Object>> entity = null;
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("success", false);

		HashMap paramMap = new HashMap(param);
		HashMap<String, Object> retMap = null;
		int record = masterService.dataUpdate("mapper.admin.CommonMapper", "delete", paramMap);
		
		if(record > 0) {
			map.put("success", true);
		}
		
		entity = new ResponseEntity<Map<String, Object>>(map, HttpStatus.OK);
		Common.returnPrint(Common.GmakeDynamicValueObject(entity));
		return entity;  
	}
	/**
	 * 공통 노출 여부 
	 */
	@PostMapping("/show_yn")  
	public ResponseEntity<Map<String, Object>> commonShow( @RequestBody HashMap param) throws Exception {
		ResponseEntity<Map<String, Object>> entity = null;
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("success", false);

		HashMap paramMap = new HashMap(param);
		int record = masterService.dataUpdate("mapper.admin.CommonMapper", "show_yn", paramMap);
		
		if(record > 0) {
			map.put("success", true);
			map.put("msg", "노출 여부 변경이 완료되었습니다.");
		}
		
		entity = new ResponseEntity<Map<String, Object>>(map, HttpStatus.OK);
		Common.returnPrint(Common.GmakeDynamicValueObject(entity));
		return entity;  
	}
	
}
