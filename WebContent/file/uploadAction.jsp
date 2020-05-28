
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
		int maxSize = 1024 * 1024 * 100;
		String encoding = "UTF-8";
		
		FileDTO dto =  new FileDTO();		
	
		MultipartRequest multipartRequest
		= new MultipartRequest(request,directory,maxSize,encoding,
				new DefaultFileRenamePolicy());
		
		String name = multipartRequest.getParameter("name");
		String pwd = multipartRequest.getParameter("pwd");
		String subject = multipartRequest.getParameter("subject");
		String content = multipartRequest.getParameter("content");
		
		dto.setName(name);
		dto.setPwd(pwd);
		dto.setSubject(subject);
		dto.setContent(content);

	Enumeration fileNames = multipartRequest.getFileNames();
	while(fileNames.hasMoreElements()){
		
		String parameter = (String) fileNames.nextElement();
		String fileName = multipartRequest.getOriginalFileName(parameter);
		String fileRealName = multipartRequest.getFilesystemName(parameter);
		dto.setFileName(fileName);
		dto.setFileRealName(fileRealName);
		
		if(fileName == null) continue;
		
		if(!fileName.endsWith(".jpg") && !fileName.endsWith(".png") && 
				!fileName.endsWith(".pdf") && !fileName.endsWith(".xls")){
			File file = new File(directory + fileRealName);
			file.delete();
%>

		<script>
		window.alert("저장할 수 없는 확장자입니다.");
		history.back();
		</script>
<% 
					
		}else{
			new FileDAO().insertFileBoard(dto);
%>
			<script>
				window.alert("업로드 되었습니다.");
				location.href='fileBoard.jsp';
			</script>

<% 
		}
	}
	%>
</body>
</html>