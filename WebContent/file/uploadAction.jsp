
<%@page import="file.FileDTO"%>
<%@page import="java.util.Enumeration"%>
<%@page import="java.io.File"%>
<%@page import="file.FileDAO"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JSP파일 업로드</title>
</head>
<body>
	<%
		String directory = "C:/upload/";
		String name = request.getParameter("name");
		String subject = request.getParameter("subject");
		int maxSize = 1024 * 1024 * 100;
		String encoding = "UTF-8";
		
		FileDTO dto =  new FileDTO();		
		dto.setName(name);
		
		
		MultipartRequest multipartRequest
		= new MultipartRequest(request,directory,maxSize,encoding,
				new DefaultFileRenamePolicy());
		
	Enumeration fileNames = multipartRequest.getFileNames();
	while(fileNames.hasMoreElements()){
		
		String parameter = (String) fileNames.nextElement();
		String fileName = multipartRequest.getOriginalFileName(parameter);
		String fileRealName = multipartRequest.getFilesystemName(parameter);
		dto.setFileName(fileName);
		dto.setFileRealName(fileRealName);
		
		if(fileName == null) continue;
		
		if(!fileName.endsWith(".jpg") && !fileName.endsWith(".hwp") && 
				!fileName.endsWith(".pdf") && !fileName.endsWith(".xls")){
			File file = new File(directory + fileRealName);
			file.delete();
			out.write("업로드할 수 없는 확장자입니다.");
			
		}else{
			new FileDAO().insertFileBoard(dto);
			out.write("파일명: " + fileName + "<br>");
			out.write("실제 파일명:" + fileRealName + "<br>");
		}
	}
	%>
</body>
</html>