
<%@page import="img.ImgDAO"%>
<%@page import="img.ImgDTO"%>
<%@page language="java" contentType="text/html; charset=UTF-8"%>
<%@page import="java.io.File"%>
<%@page import="javax.imageio.ImageIO"%>
<%@page import="java.awt.Graphics2D"%>
<%@page import="java.awt.image.BufferedImage"%>
<%@page import="javax.media.jai.JAI"%>
<%@page import="javax.media.jai.RenderedOp"%>
<%@page import="java.awt.image.renderable.RenderableImage"%>
<%@page import="java.awt.image.renderable.ParameterBlock"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="java.util.Enumeration"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	ServletContext context = request.getServletContext();
	String imagePath = context.getRealPath("image");
// 	String directory = "C:/image";
	int size = 1 * 1024  * 1024;
	String filename = "";
	ImgDTO dto = new ImgDTO();
	
	try{
		MultipartRequest multi = new MultipartRequest(request,imagePath,size,"UTF-8",new DefaultFileRenamePolicy());
		
		String name = multi.getParameter("name");
		String subject = multi.getParameter("subject");
		String content = multi.getParameter("content");
		String pwd = multi.getParameter("pwd");
		dto.setName(name);
		dto.setSubject(subject);
		dto.setContent(content);
		dto.setPwd(pwd);
		
		Enumeration files = multi.getFileNames();
		String file = (String)files.nextElement();
		filename = multi.getFilesystemName(file);
		dto.setFileName(filename);
		dto.setFileRealName("sm_" + filename);
		
	}catch(Exception e){
		e.printStackTrace();
	}
	
	ParameterBlock pb = new ParameterBlock();
	pb.add(imagePath + "/" + filename);
	RenderedOp rOp = JAI.create("fileload", pb);
	
	BufferedImage bi = rOp.getAsBufferedImage();
	BufferedImage thumb = new BufferedImage(300,300,BufferedImage.TYPE_INT_RGB);
	Graphics2D g = thumb.createGraphics();
	g.drawImage(bi, 0, 0, 300,300,null);
	File file = new File(imagePath + "/sm_" + filename);
	ImageIO.write(thumb,"jpg",file);
	ImgDAO dao = new ImgDAO();
	dao.insertImgBoard(dto);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<script>
				window.alert("업로드 되었습니다.");
				location.href='imgboard.jsp';
</script>
</body>
</html>