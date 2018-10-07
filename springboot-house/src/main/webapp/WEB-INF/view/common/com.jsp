<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<%
	//取BASE PATH
	String _path = request.getContextPath();
	String _port = request.getServerPort() == 80 || request.getServerPort() == 443 ? ""
			: ":" + request.getServerPort();
	String _basePath = request.getScheme() + "://" + request.getServerName() + _port + _path;
	
	// _basePath = _basePath.replaceFirst("http:", "https:");
	
	//_basePath = _basePath.replaceFirst("http:", "https:");
	System.out.println(_basePath);
	request.setAttribute("basePath", _basePath);
	
//	System.out.println(request.getHeader("X-Forwarded-Scheme"));
	
%>

