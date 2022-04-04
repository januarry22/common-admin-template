package kr.mypr.admin.service;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

@Service
public class MasterService {
	
	@Inject
    kr.mypr.admin.persistence.MasterDao MasterDao;
	public List<?> dataList(String mapperNm, String queryNm, Object vo){
		return MasterDao.dataList(mapperNm, queryNm, vo);
	}
	public Object dataRead(String mapperNm, String queryNm, Object vo){
		return MasterDao.dataRead(mapperNm, queryNm, vo);
	}
	public int dataCreate(String mapperNm, String queryNm, Object vo){
		return MasterDao.dataCreate(mapperNm, queryNm, vo);
	}
	public int dataDelete(String mapperNm, String queryNm, Object vo){
		return MasterDao.dataDelete(mapperNm, queryNm, vo);
	}
	public int dataCount(String mapperNm, String queryNm, Object vo){
		return MasterDao.dataCount(mapperNm, queryNm, vo);
	}
	public int dataUpdate(String mapperNm, String queryNm, Object vo){
		return MasterDao.dataUpdate(mapperNm, queryNm, vo);
	}
	
	public List<?> countDataList(String mapperNm, String queryNm,Map map){
		return MasterDao.countDataList(mapperNm,queryNm,map);
	}
	public int countList(String mapperNm, String queryNm,Map map) {
		return MasterDao.countList(mapperNm,queryNm,map);
	}

}
