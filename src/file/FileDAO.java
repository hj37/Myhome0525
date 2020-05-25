package file;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import board.BoardBean;

public class FileDAO {
	Connection con;
	PreparedStatement pstmt;
	ResultSet rs;
	
	//커넥션풀(DataSource)을 얻은 후 ConnecionDB접속
		private Connection getConnection() throws Exception{
			Context init = new InitialContext();
			DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/jspbeginner");
			//커넥션풀에 존재하는 커넥션 얻기
			Connection con = ds.getConnection();
			//커넥션 반환
			return con;
		}
		
		
	public int upload(String fileName, String fileRealName,String id) {
		try {
			con = getConnection();
			String sql = "insert into file values(?,?,0)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, fileName);
			pstmt.setString(2, fileRealName);
			pstmt.setString(3,id);
			return pstmt.executeUpdate();
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	//게시판 board테이블에 새글정보를 추가 시키는 메소드
			public void insertFileBoard(FileDTO dto) {
				String sql="";
				int num = 0; //새글 추가 시 글번호를 만들어서 저장할 변
				
				try {
					con = getConnection(); //DB연결
					//새 글 추가시 글번호 구해오기 
					//board테이블에 글이 없는 경우 : 글번호 1
					//board테이블에 글이 존재하는 경우 : 최근 글 번호 + 1
					//SQL문 만들기
					sql = "select max(num) from file"; //가장 큰 글번호 검색 
					pstmt = con.prepareStatement(sql);
					rs = pstmt.executeQuery(); //검색 후 값 얻기 
					
					if(rs.next()) {//가장 큰 글번호가 검색되면 
						//가장 큰 글번호에 + 1한 글번호를 ? 새글의 글번호로 사용하기 위해 저장 
						num = rs.getInt("max(num)") + 1; //가장 최신 번호 검색하기 위해 
						//column 이름이 바뀜 1로 적어도 됨 
					}else {
						num  = 1; //board테이블에 글이 저장되어 있지 않다면 새 글 추가시 1을 사용하기 위함 
					}
					
					
					//insert SQL문만들기 
					sql = "insert into file(fileName,fileRealName,downloadCount,"
							+ "name,date,"
							+ "subject,cotent,num)"
							+ "values(?,?,?,?,now(),?,?,?)";
					
					pstmt = con.prepareStatement(sql);
					pstmt.setString(1, dto.getFileName());
					pstmt.setString(2, dto.getFileRealName());
					pstmt.setInt(3, dto.getDownloadCount());
					pstmt.setString(4, dto.getName());
					pstmt.setString(5, dto.getSubject());
					pstmt.setString(6, dto.getContent());		
					pstmt.setInt(7, dto.getNum());	
			
					pstmt.executeUpdate();	//insert실
					
				}catch (Exception e) {
					System.out.println("insertFileBoard메서드 내부에서 예외발생하였습니다:" +e.getMessage());
				}finally {
					try {
						if(rs != null) {rs.close();}
						if(pstmt != null) {pstmt.close();}
						if(con != null) {con.close();}
					}catch(SQLException e) {
						e.printStackTrace();
					}
				}
			}//insertBoard
			
			
			public int getFileBoardCount() {
				String sql ="";
				int count = 0; //검색한 전체 글수를 저장할 용도
				
				try {
					//DB연결 
					con = getConnection();
					sql = "select count(*) from file";
					pstmt = con.prepareStatement(sql);
					rs = pstmt.executeQuery(); //select문 실행 
					
					if(rs.next()) {
						count = rs.getInt(8); //검색한 전체 글 개수 얻기 
					}
				}catch(Exception e) {
					System.out.println("getBoardCount메소드에서 예외발생 : "+e);
				}finally {
					try {
						if(rs != null) {rs.close();}
						if(pstmt != null) {pstmt.close();}
						if(con != null) {con.close();}
						}catch(SQLException e) {
							e.printStackTrace();
						}
				}
				return count;	//검색한 전체 글 수 notice.jsp로 반환   
			}		
			
			
			public List<FileDTO> getBoardList(int startRow,int pageSize){
				String sql = "";
				List<BoardBean> boardList = new ArrayList<BoardBean>();
				
				try {
					//DB연결 
					
					con = getConnection();
					//SQL문 만들기 
					//정렬 re_ref 내림차순 정렬하여 검색한 후 re_seq 오름차순정렬하여 검색해 오는데 
					//limit 각 페이지마다 맨위에 첫번째로 보여질 시작글 번호, 한 페이지당 보여줄 글개수 
					sql = "select * from board order by num desc limit ?,?";
					
					pstmt = con.prepareStatement(sql);
					pstmt.setInt(1, startRow);
					pstmt.setInt(2, pageSize);
					
					rs = pstmt.executeQuery();
					
					while(rs.next()) {
						BoardBean bBean = new BoardBean();
						//rs=> BoardBean에 저장 
						 bBean.setContent(rs.getString("content"));
						 bBean.setDate(rs.getTimestamp("date"));
						 bBean.setIp(rs.getString("ip"));
						 bBean.setName(rs.getString("name"));
						 bBean.setNum(rs.getInt("num"));
						 bBean.setPasswd(rs.getString("passwd"));
						 bBean.setRe_lev(rs.getInt("re_lev"));
						 bBean.setRe_ref(rs.getInt("re_ref"));
						 bBean.setRe_seq(rs.getInt("re_seq"));
						 bBean.setReadcount(rs.getInt("readcount"));
						 bBean.setSubject(rs.getString("subject"));
						 
						 //BoardBean => ArrayList에 추가 
						 
						 boardList.add(bBean);
					}//while반복
				}catch (Exception e) {
					System.out.println("getBoardList메소드에서 예외발생 : " +e);
					// TODO: handle exception
				}finally {
					try {
						if(rs != null) {rs.close();}
						if(pstmt != null){pstmt.close();}
						if(con != null) {con.close();}
					}catch(SQLException e) {
						e.printStackTrace();
					}
					
				}
				return boardList; //ArrayList를 notice.jsp로 리턴 
			}//getBoardList메소드 끝 
	
	
	
	
			
	
	public int hit(String fileRealName) {
		try {
			con = getConnection();
			String sql = "update file set downloadCount = downloadCount + 1 where fileRealName = ?";
					
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, fileRealName);
			return pstmt.executeUpdate();
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1; 
	}
	
	public ArrayList<FileDTO> getList(){
		ArrayList<FileDTO> list = new ArrayList<FileDTO>();
		try {
			con = getConnection();
			String sql ="select * from file";

			PreparedStatement pstmt = con.prepareStatement(sql);
			ResultSet rs = pstmt.executeQuery();
			while(rs.next()) {
				FileDTO file = new FileDTO();
				file.setFileName(rs.getString(1));
				file.setFileRealName(rs.getString(2));
				file.setDownloadCount(rs.getInt(3));
				file.setName(rs.getString(4));
				file.setDate(rs.getTimestamp(5));
				file.setSubject(rs.getString(6));
				file.setContent(rs.getString(7));
				file.setNum(rs.getInt(8));	
				
				list.add(file);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
}
