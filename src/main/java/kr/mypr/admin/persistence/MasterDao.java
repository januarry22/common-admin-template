package kr.mypr.admin.persistence;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

@Repository
public class MasterDao {
	
	@Inject private SqlSession sqlSession;
	//Common common = new Common(); 
	
	public SqlSession getSqlSession() {return sqlSession;}
	public void setSqlSession(SqlSession sqlSession) {this.sqlSession = sqlSession;}
	
	public List<Object> dataList(String mapperNm, String queryNm, Object vo){
		return sqlSession.selectList(mapperNm+"."+queryNm,vo);
	}
	public Object dataRead(String mapperNm, String queryNm, Object vo){
		return sqlSession.selectOne(mapperNm+"."+queryNm,vo);
	}
	public int dataCreate(String mapperNm, String queryNm, Object vo){
		return sqlSession.insert(mapperNm+"."+queryNm,vo);
	}
	public int dataDelete(String mapperNm, String queryNm, Object vo){
		return sqlSession.update(mapperNm+"."+queryNm,vo);
	}
	public int dataUpdate(String mapperNm, String queryNm, Object vo){
		return sqlSession.update(mapperNm+"."+queryNm,vo);
	}
	public int dataCount(String mapperNm, String queryNm, Object map) {
		return sqlSession.selectOne(mapperNm+"."+queryNm,map);
	}

	public List<?> countDataList(String mapperNm, String queryNm,Map map){
		return sqlSession.selectList(mapperNm+"."+queryNm,map);
	}
	public int countList(String mapperNm, String queryNm,Map map) {
		return sqlSession.selectOne(mapperNm+"."+queryNm,map);
	}

}
