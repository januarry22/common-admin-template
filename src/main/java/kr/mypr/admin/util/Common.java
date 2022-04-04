package kr.mypr.admin.util;


import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonElement;
import com.google.gson.JsonParser;
import io.jsonwebtoken.*;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.ResponseEntity;

import javax.servlet.http.HttpServletRequest;
import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.URL;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.*;

public class Common {

	  @Value("#{props['push.server_key']}")
	    String server_key;

		
		public static String sendPush(String url, HashMap<String, String> param) {
			try {
				
			    URL Url = null;
			    Url = new URL(url);
			
			    HttpURLConnection con = (HttpURLConnection) Url.openConnection();
			    con.setDoOutput(true);
			    con.setRequestProperty("Content-type", "application/x-www-form-urlencoded");
			    
				//占쎄텢占쎌뒠占쎌쁽 API KEY
			    con.setRequestMethod("POST"); 
			    con.setDoOutput(true); 
			    
			   
			    OutputStream os = con.getOutputStream();
			    os.write(makeParam(param).getBytes("UTF-8"));
			    os.flush();
			    os.close();
			
			    int responseCode = con.getResponseCode(); //野껉퀗�궢 �뵳�뗪쉘 200占쎌뵠筌롳옙 占쎈꽰占쎈뻿占쎄쉐�⑨옙
			
			    BufferedReader br;
			    if (responseCode == 200) {
			        br = new BufferedReader(new InputStreamReader(con.getInputStream(), "UTF-8"));
			    } else {
			        br = new BufferedReader(new InputStreamReader(con.getErrorStream(), "UTF-8"));
			    }
			
			    String inputLine;
			    StringBuffer response2 = new StringBuffer();
			    while ((inputLine = br.readLine()) != null) {
			    	response2.append(inputLine);
			    }

			    String str = response2.toString();
			    JsonParser jp = new JsonParser();
				JsonElement je = jp.parse(str);
				str = gson.toJson(je);
				
				//System.out.println("--------------------      Response Param     ---------------------------");
				//System.out.println(str);
				//System.out.println("------------------------------------------------------------------------");

			    br.close();
			    return response2.toString();
			}catch (Exception e) {
			    e.printStackTrace();
			    return "";
			}
		}
		public static String makeParam(HashMap<String, String> param_map) {
			
			String param = "a=1";
			for(String id : param_map.keySet()) {
				param += "&"+id+"="+param_map.get(id).toString();
			}
			param = param.replaceAll("\"", "");
			//System.out.println("--------------------      Request Param     ---------------------------");
			//System.out.println(param);
			//System.out.println("------------------------------------------------------------------------");
			return param;
		}
		
		
		public static final int JWT_EX_TIME = 4320 ; //24占쎈뻻揶쏉옙 占쎌�占쎌뒞占쎈맙 / 燁삳똻萸낉옙�궎占쎈꽊 access_token = 12-24占쎈뻻揶쏉옙, refresh_token 占쎈립占쎈뼎 
		
		
		//-----------------      JWT 占쎈꽅占쎄쿃      --------------------------------------------------//
		private String SALT = "secret";
		private String AUTHORIZATION = "authToken";
		/**
		 * 嚥≪뮄�젃占쎌뵥占쎈뻻 JWT token 占쎄문占쎄쉐
		 */
		public String makeToken(String email, String pw, String i){
			long currentTime = System.currentTimeMillis()+(1000*60*JWT_EX_TIME); 
			
			String jwt = "";
			jwt = Jwts.builder().
				setSubject(pw).
				setExpiration(new Date(currentTime)).
				claim("email", email).
				claim("member_seq", i).
				signWith(SignatureAlgorithm.HS256, this.generateKey()).
				compact();
			return jwt;
		}
		
		/**
		 * 嚥≪뮄�젃占쎌뵥占쎈뻻 JWT token 占쎄문占쎄쉐
		 */
		public String makeToken(String member_seq, String type){
			int time = 0;
			
			long currentTime = System.currentTimeMillis()+(1000*60*time); 
			String jwt = "";
			jwt = Jwts.builder().
					setSubject(member_seq).
					setExpiration(new Date(currentTime)).
					claim("member_seq", member_seq).
					signWith(SignatureAlgorithm.HS256, this.generateKey()).
					compact();
			return jwt;
		}
		
		/**
		 * 嚥≪뮄�젃占쎌뵥占쎈뻻 JWT token 占쎄문占쎄쉐
		 */
		public String makeToken(String member_seq){
			long currentTime = System.currentTimeMillis()+(1000*60*JWT_EX_TIME); 
			String jwt = "";
			jwt = Jwts.builder().
					setSubject(member_seq).
					setExpiration(new Date(currentTime)).
					claim("member_seq", member_seq).
					signWith(SignatureAlgorithm.HS256, this.generateKey()).
					compact();
			return jwt;
		}
		
		/**
		 * 占쎈꽅占쎄쿃 占쎌�占쎌뒞占쎄쉐 筌ｋ똾寃�
		 */
		public int checkToken(HttpServletRequest request){
			final String TOKEN = request.getHeader(AUTHORIZATION);
			if(Util.chkNull(TOKEN)) return 24;
			
			int rst_code = 0;
			try{
				Jwts.parser().setSigningKey(this.generateKey()).parseClaimsJws(TOKEN);
			}catch (ExpiredJwtException e1){
				rst_code = 20;
			}catch (UnsupportedJwtException  e1){
				rst_code = 21;
			}catch (MalformedJwtException  e1){
				rst_code = 22;
			}catch (SignatureException  e1){
				rst_code = 23;
			}catch (Exception e1){
				rst_code = -1;
			}
			return rst_code;
		}
		/**
		 * 占쎈꽅占쎄쿃 占쎌�占쎌뒞占쎄쉐 筌ｋ똾寃�
		 */
		public int checkToken(String TOKEN){
			if(Util.chkNull(TOKEN)) return 24;
			
			int rst_code = 0;
			try{
				Jwts.parser().setSigningKey(this.generateKey()).parseClaimsJws(TOKEN);
			}catch (ExpiredJwtException e1){
				rst_code = 20;
			}catch (UnsupportedJwtException  e1){
				rst_code = 21;
			}catch (MalformedJwtException  e1){
				rst_code = 22;
			}catch (SignatureException  e1){
				rst_code = 23;
			}catch (Exception e1){
				rst_code = -1;
			}
			return rst_code;
		}
		
		/**
		 * 占쎈꽅占쎄쿃 揶쏉옙占쎌죬占쎌궎疫뀐옙
		 */
		public String getToken(HttpServletRequest request){
			return request.getHeader(AUTHORIZATION);
		}
		
		/**
		 * 占쎈꽅占쎄쿃 占쎄땀�겫占쏙옙�벥 object 揶쏉옙占쎌죬占쎌궎疫뀐옙
		 */
		public Jws<Claims> getTokenInfo(HttpServletRequest request){
			String token = getToken(request);
			return Jwts.parser().setSigningKey(this.generateKey()).parseClaimsJws(token);
		}
		public String getTokenInfo(HttpServletRequest request, String key){
			String token = getToken(request);
			return (String) Jwts.parser().setSigningKey(this.generateKey()).parseClaimsJws(token).getBody().get(key);
		}
		public String getTokenInfo(String token, String key){
			return (String) Jwts.parser().setSigningKey(this.generateKey()).parseClaimsJws(token).getBody().get(key);
		}
		
		/**
		 * 占쎈꽅占쎄쿃 占쎄문占쎄쉐 獄쏉옙 占쎌넇占쎌뵥占쎈뻻 占쎌뵥�굜遺얜뎃 sha 256占쎌굨占쎈뻼占쎌몵嚥∽옙 json 占쎈쑓占쎌뵠占쎄숲�몴占� 獄쏅뗄�뵥占쎈뎃占쎈립占쎈뼄
		 */
		private byte[] generateKey() {
			byte[] key = null;
			try {
				key = SALT.getBytes("UTF-8");
			} catch (UnsupportedEncodingException e) {
				e.printStackTrace();
			}

			return key;
		}
		
		//-----------------      JWT 占쎈꽅占쎄쿃      --------------------------------------------------//
		static Gson gson = new GsonBuilder().setPrettyPrinting().serializeNulls().create();
		public static String GmakeDynamicValueObject(ResponseEntity<Map<String, Object>> entity){
			String ss = "";
			ss += gson.toJson(entity);
			return ss;
		}
		
		public static void returnPrint(String str){
			
			JsonParser jp = new JsonParser();
			JsonElement je = jp.parse(str);
			str = gson.toJson(je);
			
			System.out.println("--------------------      Response Param     ---------------------------");
			System.out.println(str);
			System.out.println("------------------------------------------------------------------------");
		}
		
		/**
		 * 占쎄깻占쎌뵬占쎌뵠占쎈섧占쎈뱜 ip 揶쏉옙占쎌죬占쎌궎疫뀐옙
		 * @param request
		 * @return
		 */
		public static String getIp(HttpServletRequest request) {
	        String ip = request.getHeader("X-Forwarded-For");
	 
	        if (ip == null) {
	            ip = request.getHeader("Proxy-Client-IP");
	        }
	        if (ip == null) {
	            ip = request.getHeader("WL-Proxy-Client-IP"); // 占쎌럲嚥≪뮇彛�
	        }
	        if (ip == null) {
	            ip = request.getHeader("HTTP_CLIENT_IP");
	        }
	        if (ip == null) {
	            ip = request.getHeader("HTTP_X_FORWARDED_FOR");
	        }
	        if (ip == null) {
	            ip = request.getRemoteAddr();
	        }
	 
	        return ip;
	 
	    }

		
		/* 而⑦뀗痢� 肄붾뱶 �깮�꽦*/
		static Date date = new Date();
		static DateFormat dateFormat = new SimpleDateFormat("yyyy");
		public static String digitalCodeGet (Map<String, Object> res, int size) throws Exception{
			String cum[] ={"C","E"};
			String type = res.get("classify_type").toString();
			String year = dateFormat.format(date);
			String gubun = null;
			String digital_code=null;
			int seq = size + 1;
//			System.out.print("<<<<<<<<"+seq);
			if(type.equals(cum[0])) {
				gubun = "MV";
				digital_code = gubun + year+"-"+seq;
			}	
			else{
				gubun = "EB";
				digital_code = gubun + year+"-"+seq;
			}
			return digital_code;	
		}
		

		static DateFormat dayFormat = new SimpleDateFormat("yyy-MM-dd");
		public static String getToday() throws Exception{
			String today = dayFormat.format(date);
			
			return today;
		}
		
		
		String user_code = null;
	    static int certCharLength = 8;
		static Date date1 = new Date();
		static DateFormat dateFormat1 = new SimpleDateFormat("yyyy");
	    final static char[] characterTable = { 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 
	                                            'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 
	                                            'Y', 'Z', '1', '2', '3', '4', '5', '6', '7', '8', '9', '0' };
	    public static String createUsercode() {
	        Random random = new Random(System.currentTimeMillis());
			String year = dateFormat.format(date);
	        int tablelength = characterTable.length;
	        StringBuffer buf = new StringBuffer();
	        
	        for(int i = 0; i < certCharLength; i++) {
	            buf.append(characterTable[random.nextInt(tablelength)]);
	        }
	        
	        return year+buf.toString();
	    }

		static DateFormat format = new SimpleDateFormat("yyMMdd");
		public static String createProductNum() {
			Random random = new Random(System.currentTimeMillis());
			String dateformat = format.format(date);
	        int tablelength = characterTable.length;
	        StringBuffer buf = new StringBuffer();
	        
	        for(int i = 0; i < 4; i++) {
	            buf.append(characterTable[random.nextInt(tablelength)]);
	        }
			
			return dateformat+buf.toString();
		}
		
		public static String ArrayToString(List<HashMap<String,Object>> param) {
	
			if (param== null) 
				return "null";		
			
			int listMax = param.size()-1;
			if(listMax == -1) 
				return "null";
			
			
			StringBuilder item = new StringBuilder();
			item.append("");
			for(int i= 0; i<param.size();i++) {
				item.append(String.valueOf(param.get(i).get("result")));
				item.append(",");
				//System.out.print("lsength:::"+item.length());
				if(i==listMax) {
					item.deleteCharAt(item.length()-1);
				}
			}
			 item.append("");

			 String result = item.toString();
			// System.out.print("item::" + result+"::\n");
			 
			return result;
		}
	
}
