package kr.mypr.admin.util;

import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Enumeration;

@Aspect
public class logAop {

	private static final Logger logger = LoggerFactory.getLogger(logAop.class);
	

	//�ش�Ǵ� ��Ʈ�ѷ��� ��û�� ���������� AOP�� �����Ѵ�.
	// controller ��Ű�� �ȿ� �ִ� ���ϵ��� ���� AOP�� ��ģ�� ������ �ڿ� ���� �Ǿ� �ִ� AjaxController, LoginController�� �����Ѵ�.
	// ���⿡ �ۼ����� ������ ���� ���õ����� ���� ó�� controller ��Ű�� ��ü�� ��ġ�� �ߴµ� ���� �����ϰ��� �ϴ� ������ ������� �Ʒ�ó���Ѵ�.
	@Around("execution(* kr.mypr.admin.controller..*.*(..)) || execution(* kr.mypr.admin.controller..*.*(..)) ")
	public Object setMapParamter(ProceedingJoinPoint joinPoint) throws Throwable { //
		// request, response ��ü ������
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest();
		HttpServletResponse response = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getResponse();
		/**
		 * ���� ������Ʈ������ ��ū üũ�� aop ���� ���� ��� login��� ���� ��δ� ���͸� ��ġ�� �ʵ��� ������ �Ѵ�.
		 */
		/*
			Common common = new Common();
			DynamicValueObject error = new DynamicValueObject();
			DynamicValueObject rst_dy = new DynamicValueObject();
			DynamicValueObject data = new DynamicValueObject();
			int err_code = 0;
			err_code = common.checkToken(request);
			if(err_code > 0) return Common.common_error_return(error, rst_dy, data, err_code);
		 */
		
		
		// request�� ��ܿ� url, �Ķ���� �ֿܼ����
		logger.warn("################################################################################################");
		logger.warn("protocol    :  " + request.getProtocol());
		logger.warn("URL         :  " + request.getRequestURL());
		logger.warn("method      :  " + request.getMethod());
		logger.warn("referer     :  " + request.getHeader("referer"));
		Enumeration params = request.getParameterNames();
		int index = 1;
		while (params.hasMoreElements()) {
			String name = (String) params.nextElement();
			logger.warn("param [" + (index++) + "]   :  " + name + " - " + request.getParameter(name));
		}
		logger.warn("################################################################################################");
		return joinPoint.proceed();
	}
}
