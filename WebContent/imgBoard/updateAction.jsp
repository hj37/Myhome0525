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
	String original = "";
	int pageNum = 0;
	int num = 0;
	
	try{
		MultipartRequest multi = new MultipartRequest(request,imagePath,size,"UTF-8",new DefaultFileRenamePolicy());
		
		String name = multi.getParameter("name");
		String subject = multi.getParameter("subject");
		String content = multi.getParameter("content");
		String pwd = multi.getParameter("pwd");
		pageNum = Integer.parseInt(multi.getParameter("pageNum"));
		num = Integer.parseInt(multi.getParameter("num"));
		original = multi.getParameter("original");

		
		dto.setName(name);
		dto.setSubject(subject);
		dto.setContent(content);
		dto.setPwd(pwd);
		dto.setNum(num);
		
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
	File file2 = new File(imagePath + original);
	file2.delete();
	
	File file3 = new File(imagePath+ "sm_" + original);
	file3.delete();
	
	ImageIO.write(thumb,"jpg",file);
	ImgDAO dao = new ImgDAO();
	int check = dao.updateImgBoard(dto);
	
	if(check == 1){
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<script>
		window.alert("수정 되었습니다.");
	</script>
<%
 	response.sendRedirect("imgboard.jsp?pageNum=" + pageNum);
	}else{
%>
	<script>
				window.alert("비밀번호가 잘못됬습니다.");
				history.back();
	</script>
<%}%>

</body>
</html>