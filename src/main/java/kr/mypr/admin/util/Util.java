package kr.mypr.admin.util;

import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.File;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;

import com.google.gson.Gson;

public class Util {
	 /**
     * ***************************************************
     * JsonString을 Object Class로 전환
     * @param jsonString Object로 변활할 Json String
     * @param objectClass json데이터 담을 Object
     * @return
     ****************************************************
     */

     public static <T> T convertJsonToObject(final String jsonString, final Class<T> objectClass) {
            Gson gson = new Gson();
            return gson.fromJson(jsonString, objectClass);
     }
	/**
	 * 유효성 체크
	 * @param param_map
	 * @return
	 */
	public static String vaild(HashMap<String, Object> param_map){
		
		List<String> param = new ArrayList<String>();
		for(String id : param_map.keySet()) {
			System.out.println("아이디 : "+id);
			Object value = param_map.get(id);
			if (value instanceof Integer) { 
			    System.out.println("숫자형입니다."+value);
			    if(Util.chkNullData(String.valueOf(value), "0")) {
			    	param.add(id);
			    }
			} else if (value instanceof String) {
			    System.out.println("문자열입니다."+value);
			    if(Util.chkNull(String.valueOf(value))) {
			    	param.add(id);
			    }
			} else {
				System.out.println("디폴트."+value);
				if(Util.chkNull(String.valueOf(value))) {
					System.out.println("들어옴?");
			    	param.add(id);
			    }
			}
		}
		
		
		String msg = "";
		if(param != null && param.size() > 0) {
			msg = "필수값이 누락되었습니다.(";
			for (int i = 0 ; i < param.size() ; i++) {
				msg += param.get(i).toString();
				if((i+1) != param.size()) {
					msg += ",";
				}
			}
			msg += ")";
			System.out.println("1) "+msg);
			return msg;
		}else {
			System.out.println("2) "+msg);
			return msg;
		}
	}
	
	/**
	 * @param :
	 *            요청request 객체
	 * @return : ip 번호
	 */
	public static String getClientIP(HttpServletRequest request) {
		String ip = request.getHeader("X-FORWARDED-FOR");
		if (ip == null || ip.length() == 0) {
			ip = request.getHeader("Proxy-Client-IP");
		}
		if (ip == null || ip.length() == 0) {
			ip = request.getHeader("WL-Proxy-Client-IP"); // 웹로직
		}
		if (ip == null || ip.length() == 0) {
			ip = request.getRemoteAddr();
		}
		return ip;
	}
	
	/**
	 * 마지막 특정문자열 replace
	 * @param str
	 * @param regex
	 * @param replacement
	 * @return
	 */
   public static String replaceLast(String str, String regex, String replacement) {
        int regexIndexOf = str.lastIndexOf(regex);
        if(regexIndexOf == -1){
            return str;
        }else{
            return str.substring(0, regexIndexOf) + replacement + str.substring(regexIndexOf + regex.length());
        }
    }
	
	public static String randomString() {
		Random rd = new Random();
		String rst = "";
		for(int i = 0 ; i < 6; i++) {
			rst += rd.nextInt(9);
		}
		return rst;
	}
	
    /**
     * @param str null, 공백 체크할 문자열
     * @return null이나 공백이면 : true, 값이 있으면 false
     */
    public static boolean chkNull(String str) {
        return str == null || "".equals(str) ? true : false;
    }
    
    /**
     * @param str null, 공백 체크할 문자열
     * @return null이나 공백이면 : true, 값이 있으면 false
     */
    public static boolean chkNullData(String str, String target) {
        return str != null && str.equals(target) ? true : false;
    }
    
    /**
     * @parametereter :
     * @return :년월일 현재날짜를 문자열로 리턴
     */
    public static String getYYYY() {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy");
        Calendar c1 = Calendar.getInstance();
        String strToday = sdf.format(c1.getTime());
        return strToday;
    }
    
    /**
     * @parametereter :
     * @return :년월일 현재날짜를 문자열로 리턴
     */
    public static String getMM() {
        SimpleDateFormat sdf = new SimpleDateFormat("MM");
        Calendar c1 = Calendar.getInstance();
        String strToday = sdf.format(c1.getTime());
        return strToday;
    }
    
    /**
     * @parametereter :
     * @return :년월일 현재날짜를 문자열로 리턴
     */
    public static String getDD() {
        SimpleDateFormat sdf = new SimpleDateFormat("dd");
        Calendar c1 = Calendar.getInstance();
        String strToday = sdf.format(c1.getTime());
        return strToday;
    }
    
    public static int getWeek(String today) throws java.text.ParseException{
    	SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMdd");
    	Date date = formatter.parse(today);  // 날짜 입력하는곳 .
    	 
    	 
		 Calendar cal = Calendar.getInstance() ;
		 cal.setTime(date);              // 하루더한 날자 값을 Calendar  넣는다.
    	 
    	 
    	 int dayNum = cal.get(Calendar.DAY_OF_WEEK) ;
         
         
         String day = null;
    	    switch(dayNum){
    	        case 1:
    	            day = "일";
    	            break ;
    	        case 2:
    	            day = "월";
    	            break ;
    	        case 3:
    	            day = "화";
    	            break ;
    	        case 4:
    	            day = "수";
    	            break ;
    	        case 5:
    	            day = "목";
    	            break ;
    	        case 6:
    	            day = "금";
    	            break ;
    	        case 7:
    	            day = "토";
    	            break ;
    	             
    	    }
    	    System.out.println(today+"의 요일은 : "+day);
    	     
    	 return dayNum;
    }
    
    
    /**
     * @parametereter :
     * @return :년월일 현재날짜를 문자열로 리턴
     */
    public static String getToday() {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
        Calendar c1 = Calendar.getInstance();
        String strToday = sdf.format(c1.getTime());
        return strToday;
    }
    
    /**
     * @parametereter :
     * @return :년월일 현재날짜를 문자열로 리턴
     */
    public static String getTodayHHmmss() {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
        Calendar c1 = Calendar.getInstance();
        String strToday = sdf.format(c1.getTime());
        return strToday;
    }
    
    /**
	 * 
	 * @message : 포맷패턴을 넘겨주면 그에 맞게 날짜형식을 리턴한다.
	 * @param fommat
	 *            : 포맷패턴
	 * @return : 포맷에 따른 날짜를 String형식으로 리턴
	 */
	public static String simpleDate(String fommat) {
		SimpleDateFormat sdf = new SimpleDateFormat(fommat);
		Calendar c1 = Calendar.getInstance();
		String strToday = sdf.format(c1.getTime());
		return strToday;
	}
    
    /**
     * 타겟이 되는 문자열을 html 특수문자 제거 및 해당 length까지 자르기
     *
     * @return :String : 커스텀한 문자열
     * @parameter : max_len(최대 문자열길이), message(타겟이 되는 문자열)
     */
    public static String stringCut(int max_len, String message) {
        message = message.replaceAll("\\<.*?\\>", "").replaceAll("\\&lt;.*?\\&gt;", "");
        message = message.length() > max_len ? message.substring(0, max_len) + "..." : message;
        return message;
    }
    
    /**
	 * @return : String |을 연결한 문자열 리턴 String 배열을 | 파이프로 연결해서 하나의 문자열로 리턴
	 */
	public static String PipeArr(String[] strArr) {
		String strQuery = "";
		if (strArr.length != 1) {
			for (int i = 0; i < strArr.length - 1; i++) {
				strQuery += strArr[i].trim() + "|";
			}
			strQuery += strArr[strArr.length - 1].trim();

		} else {
			strQuery += strArr[strArr.length - 1].trim();
		}
		return strQuery;
	}
	

	/**
	 * @param realPath
	 *            : 해당 경로에 디렉토리가 있다면 넘어가고 없다면 디렉토리를 생성한다.
	 */
	public static void mkDir(String realPath) {
		File updir = new File(realPath);
		if (!updir.exists())
			updir.mkdirs();
	}

	/**
	 * @msg : 해당 문자열에 한글이 포함됬는지 확인 함수
	 * @param str
	 *            : 검사할 문자열
	 * @return : true 한글존재, false 한글 없음
	 */
	public static boolean checkLang(String str) {
		if (str.matches(".*[ㄱ-ㅎㅏ-ㅣ가-힣]+.*")) {
			return true;
		} else {
			return false;
		}
	}


	
	public String sendRequest(String fb_url, String method, String authorization, HashMap<String, String> sb) throws IOException {
		URL url = new URL(fb_url);
		HttpURLConnection con = (HttpURLConnection) url.openConnection();
		con.setRequestMethod(method);
		con.setDoOutput(true);
		con.setRequestProperty("Content-Type", "application/x-www-form-urlencoded");

		
		if (authorization != null && !"".equals(authorization)) {
			String[] key_value = authorization.split("\\|");
			con.setRequestProperty(key_value[0], key_value[1]);
			System.out.println("인증 헤더 : "+key_value[0]+":"+key_value[1]);
		}
		if (sb != null) {
				String queryString = getDataString(sb);
				byte[] postData = queryString.getBytes( StandardCharsets.UTF_8 );
				 DataOutputStream wr = new DataOutputStream(con.getOutputStream());
		            wr.write(postData);
		            wr.flush();
		            wr.close();
				
		}
		int responseCode = con.getResponseCode();
		BufferedReader br;
		if (responseCode == 200) {
			br = new BufferedReader(new InputStreamReader(con.getInputStream(), "utf-8"));
		} else {
			br = new BufferedReader(new InputStreamReader(con.getErrorStream(), "utf-8"));
		}
		String inputLine;
		StringBuffer response = new StringBuffer();
		while ((inputLine = br.readLine()) != null) {
			response.append(inputLine);
		}
		br.close();
		return response.toString();

	}
	
	private String getDataString(HashMap<String, String> params) throws UnsupportedEncodingException{
	    StringBuilder result = new StringBuilder();
	    boolean first = true;
	    for(Map.Entry<String, String> entry : params.entrySet()){
	        if (first)
	            first = false;
	        else
	            result.append("&");    
	        result.append(URLEncoder.encode(entry.getKey(), "UTF-8"));
	        result.append("=");
	        result.append(URLEncoder.encode(entry.getValue(), "UTF-8"));
	    }    
	    return result.toString();
	}
	
	public String sendRequestApi(String fb_url, String method, String authorization, HashMap<String, String> sb) throws IOException {
		URL url = new URL(fb_url);
		HttpURLConnection con = (HttpURLConnection) url.openConnection();
		con.setRequestMethod(method);
		con.setDoOutput(true);
		con.setRequestProperty("Content-Type", "application/json; charset=utf-8");
		con.setRequestProperty("X-Cafe24-Client-Id", "1kuFAyNqHtQqWAI3oe6FuD");
		if (authorization != null && !"".equals(authorization)) {
			String[] key_value = authorization.split("\\|");
			con.setRequestProperty(key_value[0], key_value[1]);
		}
		if (sb != null) {
			String queryString = getDataString(sb);
			byte[] postData = queryString.getBytes( StandardCharsets.UTF_8 );
			 DataOutputStream wr = new DataOutputStream(con.getOutputStream());
	            wr.write(postData);
	            wr.flush();
	            wr.close();
		}
		int responseCode = con.getResponseCode();
		BufferedReader br;
		if (responseCode == 200) {
			br = new BufferedReader(new InputStreamReader(con.getInputStream(), "utf-8"));
		} else {
			br = new BufferedReader(new InputStreamReader(con.getErrorStream(), "utf-8"));
		}
		String inputLine;
		StringBuffer response = new StringBuffer();
		while ((inputLine = br.readLine()) != null) {
			response.append(inputLine);
		}
		br.close();
		return response.toString();

	}
	public static String makeAuthRandNumber() {
        Random random = new Random(System.currentTimeMillis());

        int range = (int)Math.pow(10,6);
        int trim = (int)Math.pow(10, 6-1);
        int result = random.nextInt(range)+trim;

        if(result>range){
            result = result - trim;
        }
        String rst = String.valueOf(result);
        return rst;
    }

}
