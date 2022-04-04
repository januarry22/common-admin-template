package kr.mypr.admin.controller.member;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

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
@RequestMapping(value = "/supervise/admin/v1/member/**")
public class MemberRestController {


	@Inject
    MasterService masterService;
	
	@PostMapping("/create")
	public ResponseEntity<Map<String, Object>> dashboard(HttpServletRequest request, @RequestBody  HashMap param) throws Exception {
		ResponseEntity<Map<String, Object>> entity = null;
		Map<String, Object> map = new HashMap<String, Object>();
		
		int record = masterService.dataCreate("mapper.admin.MemberMapper", "create", param);
		map.put("success", false);
		if(record > 0) map.put("success", true);
		
		try {entity = new ResponseEntity<Map<String, Object>>(map,HttpStatus.OK);} 
		catch (Exception e) {entity = new ResponseEntity<Map<String, Object>>(map,HttpStatus.BAD_REQUEST);}
		Common.returnPrint(Common.GmakeDynamicValueObject(entity));
		
		return entity;
	}
	
	@PostMapping("/exper_yn")
	public ResponseEntity<Map<String, Object>> exper_yn(HttpServletRequest request, @RequestBody  HashMap param) throws Exception {
		ResponseEntity<Map<String, Object>> entity = null;
		Map<String, Object> map = new HashMap<String, Object>();
		
		int record = masterService.dataUpdate("mapper.admin.MemberMapper", "exper_yn", param);
		map.put("success", false);
		if(record > 0) map.put("success", true);
		map.put("msg", "체험단 정보가 변경되었습니다.");
		
		try {entity = new ResponseEntity<Map<String, Object>>(map,HttpStatus.OK);} 
		catch (Exception e) {entity = new ResponseEntity<Map<String, Object>>(map,HttpStatus.BAD_REQUEST);}
		Common.returnPrint(Common.GmakeDynamicValueObject(entity));
		
		return entity;
	}
	/**
	 * 공통 중복체크 ( 메일, 폰 )
	 */
	@PostMapping("/common/chk")  
	public ResponseEntity<Map<String, Object>> common_chk( @RequestBody HashMap param) throws Exception {
		ResponseEntity<Map<String, Object>> entity = null;
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("success", false);

		HashMap paramMap = new HashMap(param);
		HashMap<String, Object> retMap = null;
		retMap = (HashMap) masterService.dataRead("mapper.admin.MemberMapper", "common_chk", paramMap);
		
		if(retMap != null) {
			map.put("success", true);//중복되는게 잇을경우 true
		}
		
		entity = new ResponseEntity<Map<String, Object>>(map, HttpStatus.OK);
		Common.returnPrint(Common.GmakeDynamicValueObject(entity));
		return entity;  
	}
	
	@PostMapping("/update")
	public ResponseEntity<Map<String, Object>> update(HttpServletRequest request, @RequestBody HashMap param) throws Exception {
		ResponseEntity<Map<String, Object>> entity = null;
		Map<String, Object> map = new HashMap<String, Object>();
		
		int record = masterService.dataUpdate("mapper.admin.MemberMapper", "update", param);
		map.put("success", false);
		if(record > 0) map.put("success", true);
		
		try {entity = new ResponseEntity<Map<String, Object>>(map,HttpStatus.OK);} 
		catch (Exception e) {entity = new ResponseEntity<Map<String, Object>>(map,HttpStatus.BAD_REQUEST);}
		Common.returnPrint(Common.GmakeDynamicValueObject(entity));
		
		return entity;
	}
	@PostMapping("/update_pre")
	public ResponseEntity<Map<String, Object>> update_pre(HttpServletRequest request, @RequestBody HashMap param) throws Exception {
		ResponseEntity<Map<String, Object>> entity = null;
		Map<String, Object> map = new HashMap<String, Object>();
		System.out.print(">>>>>>datA"+param);
		
		
		int record = masterService.dataUpdate("mapper.admin.MemberMapper", "update_pre", param);
		map.put("success", false);
		if(record > 0) map.put("success", true);
		
		try {entity = new ResponseEntity<Map<String, Object>>(map,HttpStatus.OK);} 
		catch (Exception e) {entity = new ResponseEntity<Map<String, Object>>(map,HttpStatus.BAD_REQUEST);}
		Common.returnPrint(Common.GmakeDynamicValueObject(entity));
		
		return entity;
	}
	
	@GetMapping("/remove")
	public ResponseEntity<Map<String, Object>> removeDELETE(@RequestParam(value = "seq" , required = false) String seq) throws Exception {
		ResponseEntity<Map<String, Object>> entity = null;		Map<String, Object> map = new HashMap<String, Object>();
		
		int record = masterService.dataCreate("mapper.admin.MemberMapper", "remove", seq);
		map.put("success", false);
		if(record > 0) map.put("success", true);
		
		try {entity = new ResponseEntity<Map<String, Object>>(map,HttpStatus.OK);} 
		catch (Exception e) {entity = new ResponseEntity<Map<String, Object>>(map,HttpStatus.BAD_REQUEST);}
		Common.returnPrint(Common.GmakeDynamicValueObject(entity));
		
		return entity;
	}
	@GetMapping("/detail")
	public ResponseEntity<Map<String, Object>> detailMember(@RequestParam(value = "seq" , required = false) String seq) throws Exception {
		ResponseEntity<Map<String, Object>> entity = null;		Map<String, Object> map = new HashMap<String, Object>();
		HashMap<String, Object> retmap = null;
		retmap = (HashMap)masterService.dataRead("mapper.admin.MemberMapper", "detail", seq);
		map.put("success", false);
		if(retmap !=null) {
			map.put("data", retmap);
			map.put("success", true);
		}
		
		try {entity = new ResponseEntity<Map<String, Object>>(map,HttpStatus.OK);} 
		catch (Exception e) {entity = new ResponseEntity<Map<String, Object>>(map,HttpStatus.BAD_REQUEST);}
		Common.returnPrint(Common.GmakeDynamicValueObject(entity));
		return entity;
	}
	@PostMapping("/count")
	public ResponseEntity<Map<String, Object>> memberCount(HttpServletRequest request, @RequestBody HashMap param) throws Exception {
		ResponseEntity<Map<String, Object>> entity = null;
		Map<String, Object> map = new HashMap<String, Object>();
		
		int record = masterService.dataCount("mapper.admin.MemberMapper", "count", param);
			map.put("success", true); 
			map.put("data", record); 
		
		try {entity = new ResponseEntity<Map<String, Object>>(map,HttpStatus.OK);} 
		catch (Exception e) {entity = new ResponseEntity<Map<String, Object>>(map,HttpStatus.BAD_REQUEST);}
		Common.returnPrint(Common.GmakeDynamicValueObject(entity));
		
		return entity;
	}
	@PostMapping("/comment_create")
	public ResponseEntity<Map<String, Object>> comment_create(HttpServletRequest request, @RequestBody  HashMap param) throws Exception {
		ResponseEntity<Map<String, Object>> entity = null;
		Map<String, Object> map = new HashMap<String, Object>();
		
		int record = masterService.dataCreate("mapper.admin.MemberMapper", "comment_create", param);
		map.put("success", false);
		if(record > 0) map.put("success", true);
		
		try {entity = new ResponseEntity<Map<String, Object>>(map,HttpStatus.OK);} 
		catch (Exception e) {entity = new ResponseEntity<Map<String, Object>>(map,HttpStatus.BAD_REQUEST);}
		Common.returnPrint(Common.GmakeDynamicValueObject(entity));
		
		return entity;
	}
	@GetMapping("/comment_detail")
	public ResponseEntity<Map<String, Object>> comment_detail(@RequestParam(value = "seq" , required = false) String seq) throws Exception {
		ResponseEntity<Map<String, Object>> entity = null;		Map<String, Object> map = new HashMap<String, Object>();
		HashMap<String, Object> retmap = null;
		retmap = (HashMap)masterService.dataRead("mapper.admin.MemberMapper", "comment_detail", seq);
		map.put("success", false);
		if(retmap !=null) {
			map.put("data", retmap);
			map.put("success", true);
		}
		
		try {entity = new ResponseEntity<Map<String, Object>>(map,HttpStatus.OK);} 
		catch (Exception e) {entity = new ResponseEntity<Map<String, Object>>(map,HttpStatus.BAD_REQUEST);}
		Common.returnPrint(Common.GmakeDynamicValueObject(entity));
		return entity;
	}
	
	@GetMapping("/search")
	public ResponseEntity<Map<String, Object>> search(@RequestParam(value = "search_value" , required = false) String search_value,String search_type) throws Exception {
		ResponseEntity<Map<String, Object>> entity = null;		Map<String, Object> map = new HashMap<String, Object>();

		HashMap<String, Object> param = new HashMap<String, Object>();
		param.put("search_value", search_value);
		param.put("search_type", search_type);
		
		map.put("success", true);
		map.put("data", (List<HashMap<String,Object>>)masterService.dataList("mapper.admin.MemberMapper", "search", param));
	
		
		try {entity = new ResponseEntity<Map<String, Object>>(map,HttpStatus.OK);} 
		catch (Exception e) {entity = new ResponseEntity<Map<String, Object>>(map,HttpStatus.BAD_REQUEST);}
		//Common.returnPrint(Common.GmakeDynamicValueObject(entity));
		return entity;
	}
}
