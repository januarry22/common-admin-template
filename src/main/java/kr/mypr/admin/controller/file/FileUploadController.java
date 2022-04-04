package kr.mypr.admin.controller.file;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.UUID;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.tika.exception.TikaException;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import kr.mypr.admin.service.MasterService;

@Controller
@RequestMapping({"/api/file/*"})
public class FileUploadController {

		@Inject MasterService masterService;
	
		String setCharEncoding = "UTF-8";
	    public static String UPLOAD_PATH = "/resources/images/";
	    @Value("#{props['domain.url']}")
	    String domain_url;

	    public FileUploadController() {
	    }

	    public String fileupload(MultipartFile file1, HttpServletRequest request) {
	        try {
	            if (!file1.isEmpty()) {
	                String fileName = "";
	                String strToday = simpleDate("yyyyMMddkms");
	                String path = request.getServletContext().getRealPath(UPLOAD_PATH);
	                fileName = file1.getOriginalFilename();
	                String ext = fileName.substring(fileName.lastIndexOf(".") + 1);
	                if (checkLang(fileName)) {
	                    fileName = UUID.randomUUID().toString().replace("-", "") + "." + ext;
	                }

	                fileName = strToday + "_" + fileName;
	                file1.transferTo(new File(path + fileName));
	                return this.domain_url + UPLOAD_PATH + fileName;
	            }
	        } catch (Exception var7) {
	            var7.printStackTrace();
	        }

	        return null;
	    }

	    public static void mkDir(String realPath) {
	        File updir = new File(realPath);
	        if (!updir.exists()) {
	            updir.mkdirs();
	        }

	    }

	    public static String simpleDate(String fommat) {
	        SimpleDateFormat sdf = new SimpleDateFormat(fommat);
	        Calendar c1 = Calendar.getInstance();
	        String strToday = sdf.format(c1.getTime());
	        return strToday;
	    }

	    public static boolean checkLang(String str) {
	        return str.matches(".*[ㄱ-ㅎㅏ-ㅣ가-힣]+.*");
	    }

	    @RequestMapping({"/upload_binary"})
	    @ResponseBody
	    private String file_uploader(HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {
	        request.setCharacterEncoding("utf-8");
	        String realname = request.getHeader("file-name");
	        String subPath = UPLOAD_PATH + "notice" + "/";
	        String path = request.getServletContext().getRealPath(subPath);
	        mkDir(path);
	        InputStream is = request.getInputStream();
	        OutputStream os = new FileOutputStream(path + realname);
	        byte[] b = new byte[Integer.parseInt(request.getHeader("file-size"))];

	        int numRead;
	        while((numRead = is.read(b, 0, b.length)) != -1) {
	            os.write(b, 0, numRead);
	        }

	        if (is != null) {
	            is.close();
	        }

	        os.flush();
	        os.close();
	        return subPath + realname;
	    }

	    @RequestMapping({"/upload_multipart"})
	    @ResponseBody
	    private String file_uploader2(HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {
	        response.setCharacterEncoding(this.setCharEncoding);
	        response.setContentType("text/html; charset=" + this.setCharEncoding + " \" ");
	        String realPath = request.getServletContext().getRealPath(UPLOAD_PATH);
	        String filename = this.multipart_upload(request, realPath);
	        PrintWriter out = response.getWriter();
	        out.println("<script>");
	        out.println("opener.pasteHTML('" + filename + "');");
	        out.println("self.close();");
	        out.println("</script>");
	        out.flush();
	        return null;
	    }

	    @PostMapping({"/ajaxupload"})
	    @ResponseBody
	    private String ajaxupload(HttpServletRequest request, HttpServletResponse response, HttpSession session, Model model) throws Exception {
	        response.setContentType("text/html; charset=" + this.setCharEncoding + " \" ");
	        String subPath = request.getParameter("sub_path");
	        System.out.print("subPath>>>>>>>>>>>>>>>"+subPath);
	        subPath = UPLOAD_PATH + subPath + "/";
	        String realPath = request.getServletContext().getRealPath(subPath);
	        Map<String,Object> fileData = this.multipart_uploadHashMap(request, realPath);
	        String filename=fileData.get("name").toString();
	        
	        fileData.put("url", domain_url+subPath + filename);
	        
	        //db 업로드 
			int record = masterService.dataCreate("mapper.admin.CommonFileMapper", "create", fileData);
			String seq = fileData.get("file_seq").toString();
			System.out.print("seq"+seq);
			
	        return seq;
	    }

//	    @PostMapping({"/ajaxupload"})
//	    @ResponseBody
//	    private String ajaxupload(HttpServletRequest request, HttpServletResponse response, HttpSession session, Model model) throws Exception {
//	        response.setContentType("text/html; charset=" + this.setCharEncoding + " \" ");
//	        String subPath = request.getParameter("sub_path");
//	        System.out.print("subPath>>>>>>>>>>>>>>>"+subPath);
//	        subPath = UPLOAD_PATH + subPath + "/";
//	        String realPath = request.getServletContext().getRealPath(subPath);
//	        Map<String,Object> fileData = this.multipart_uploadHashMap(request, realPath);
//	        String filename=fileData.get("name").toString();
//	        fileData.put("url", subPath + filename);
//	        
//	        System.out.print("fileData>>>>>>>>>>>>>>>"+fileData);
//	        return subPath + filename;
//	    }

	    public String multipart_upload(HttpServletRequest request, String realPath) throws IllegalStateException, IOException {
	        mkDir(realPath);
	        String filename = "";
	        MultipartHttpServletRequest multipartHttpServletRequest = (MultipartHttpServletRequest)request;
	        Iterator<String> iterator = multipartHttpServletRequest.getFileNames();
	        MultipartFile mrequest = null;

	        while(iterator.hasNext()) {
	            mrequest = multipartHttpServletRequest.getFile((String)iterator.next());
	            String filenameTemp = mrequest.getOriginalFilename();
	            String ext = filenameTemp.substring(filenameTemp.lastIndexOf(".") + 1);
	            filename = filename + UUID.randomUUID().toString().replace("-", "") + "." + ext;
	            if (!mrequest.isEmpty()) {
	                mrequest.transferTo(new File(realPath + filename));
	            }
	        }

	        return filename;
	    }
	    
	    public Map<String,Object> multipart_uploadHashMap(HttpServletRequest request, String realPath) throws IllegalStateException, IOException {
	    	Map<String, Object> data = new HashMap();
	        mkDir(realPath);
	        String filename = "";
	        MultipartHttpServletRequest multipartHttpServletRequest = (MultipartHttpServletRequest)request;
	        Iterator<String> iterator = multipartHttpServletRequest.getFileNames();
	        MultipartFile mrequest = null;
	       
	        String filenameTemp= null;
	        String ext= null;
	        while(iterator.hasNext()) {
	            mrequest = multipartHttpServletRequest.getFile((String)iterator.next());
	            filenameTemp = mrequest.getOriginalFilename();
	            ext = filenameTemp.substring(filenameTemp.lastIndexOf(".") + 1);
	            filename = filename + UUID.randomUUID().toString().replace("-", "") + "." + ext;
	            if (!mrequest.isEmpty()) {
	                mrequest.transferTo(new File(realPath + filename));
	            }
	        }
//	        System.out.print("filenameTemp"+filenameTemp);
//	        System.out.print("ext"+ext);
//	        System.out.print("filename"+filename);
	        
	        data.put("ori_name", filenameTemp);
	        data.put("ext", ext);
	        data.put("name", filename);

	        return data;
	    }

	  
}
