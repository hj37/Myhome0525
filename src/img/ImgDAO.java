package img;

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


public class ImgDAO {
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
			//게시판 board테이블에 새글정보를 추가 시키는 메소드
			public void insertImgBoard(ImgDTO dto){
				String sql="";
				int num = 0; //새글 추가 시 글번호를 만들어서 저장할 변
				
				try {
					con = getConnection(); //DB연결
					//새 글 추가시 글번호 구해오기 
					//board테이블에 글이 없는 경우 : 글번호 1
					//board테이블에 글이 존재하는 경우 : 최근 글 번호 + 1
					//SQL문 만들기
					sql = "select max(num) from imgboard"; //가장 큰 글번호 검색 
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
					sql = "insert into imgboard(fileName,fileRealName,count,"
							+ " name,date,"
							+ " subject,content,num,pwd)"
							+ " values(?,?,?,?,now(),?,?,?,?)";
					
					pstmt = con.prepareStatement(sql);
					pstmt.setString(1, dto.getFileName());
					pstmt.setString(2, dto.getFileRealName());
					pstmt.setInt(3, dto.getCount());
					pstmt.setString(4, dto.getName());
					pstmt.setString(5, dto.getSubject());
					pstmt.setString(6, dto.getContent());		
					pstmt.setInt(7, num);	
					pstmt.setString(8, dto.getPwd());	

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
			
			
			//글 하나의 정보를 검색하여 글정보를 제공해주는 메소드 
			public ImgDTO getFileBoard(int num) {
					

				//매개변수로 전달 받은 글 번호에 해당하는 글을 검색해서 저장할 BoardDto객체 생성
				ImgDTO dto = new ImgDTO();
				try {
					//커넥션풀로 커넥션 얻기(DB접속) 
					con = getConnection();
					
					//매개변수로 전달 받은 글번호에 해당 되는 글 하나의 정보를 검색하는 SELECT구문 만들기 
					String sql = "select * from imgboard where num = ?";	
					//?기호 해당되는 값을 제외한 나머지 SELECT문장을 저장한? PreparedStatement실행 객체 얻기
					pstmt = con.prepareStatement(sql);
					//?기호에 해당되는 글번호를 설정
					pstmt.setInt(1, num);
					//SELECT구문 실행한 후 검색된 글 하나의 정보를 ResultSet에 저장 후 반환 받기
					rs = pstmt.executeQuery();
					
					//ResultSet임시 저장소에 검색한 데이터(글 하나의 정보)가 존재하면?
					if(rs.next()) {
						//ResultSet에서 검색한 글의 정보들을 꺼내와서 BoardDto객체의 각 변수에 저장  
						dto.setFileName(rs.getString(1));
						dto.setFileRealName(rs.getString(2));
						dto.setCount(rs.getInt(3));
						dto.setName(rs.getString(4));
						
						dto.setDate(rs.getTimestamp(5));
						dto.setSubject(rs.getString(6));
						dto.setContent(rs.getString(7));
						dto.setNum(rs.getInt(8));
					
					}
					
				} catch (Exception e) {
					
					System.out.println("getFileBoard메소드 내부에서 오류 : " + e.getMessage());
					
				}finally {
					if(rs != null) try{rs.close();}catch(Exception e) {e.printStackTrace();}
					if(pstmt != null) try{pstmt.close();}catch(Exception e) {e.printStackTrace();}
					if(con != null) try{con.close();}catch(Exception e) {e.printStackTrace();}
				}
				
				return dto;	//DB로부터 검색한 하나의 글정보를 BoardDto객체에 저장 후 Update.jsp로 반환

			}
			
			
			public int getImgBoardCount() {
				String sql ="";
				int count = 0; //검색한 전체 글수를 저장할 용도
				
				try {
					//DB연결 
					con = getConnection();
					sql = "select count(*) from imgboard";
					pstmt = con.prepareStatement(sql);
					rs = pstmt.executeQuery(); //select문 실행 
					
					if(rs.next()) {
						count = rs.getInt(1); //검색한 전체 글 개수 얻기 
					}
				}catch(Exception e) {
					System.out.println("getImgBoardCount메소드에서 예외발생 : "+e);
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
			
			
			public List<ImgDTO> getImgBoardList(int startRow,int pageSize){
				String sql = "";
				List<ImgDTO> boardList = new ArrayList<ImgDTO>();
				
				try {
					//DB연결 
					
					con = getConnection();
					//SQL문 만들기 
					//정렬 re_ref 내림차순 정렬하여 검색한 후 re_seq 오름차순정렬하여 검색해 오는데 
					//limit 각 페이지마다 맨위에 첫번째로 보여질 시작글 번호, 한 페이지당 보여줄 글개수 
					sql = "select * from imgboard order by num desc limit ?,?";
					
					pstmt = con.prepareStatement(sql);
					pstmt.setInt(1, startRow);
					pstmt.setInt(2, pageSize);
					
					rs = pstmt.executeQuery();
					
					while(rs.next()) {
						//rs=> BoardBean에 저장 
						
						ImgDTO dto = new ImgDTO();
						
						dto.setFileName(rs.getString("fileName"));
						dto.setFileRealName(rs.getString("fileRealName"));
						dto.setCount(rs.getInt("count"));
						dto.setName(rs.getString("name"));
						
						dto.setDate(rs.getTimestamp("date"));
						dto.setSubject(rs.getString("subject"));
						dto.setContent(rs.getString("content"));
						dto.setNum(rs.getInt("num"));
												 
						boardList.add(dto);
					}//while반복
				}catch (Exception e) {
					System.out.println("getImgBoardList메소드에서 예외발생 : " +e);
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
	
			
			/*검색어를 전달받아 검색어에 해당하는 글개수를 DB로부터 가져와서 글개수 리턴 */
			public int getImgCount(String search) {
				Connection con = null;
				PreparedStatement pstmt = null;
				ResultSet rs = null;
				String sql = "";
				int count = 0;
				try {
					//1, 2디비연결 
					con = getConnection();
					//3 sql 검색어에 해당하는 게시판 글개수 가져오기 count(*) 
					sql = "select count(*) from imgboard where subject like ?";
					pstmt = con.prepareStatement(sql);
					pstmt.setString(1, "%"+ search + "%");
					//4 rs 실행저장
					rs = pstmt.executeQuery();
					//5 rs데이터 있으면 count 저장
					if(rs.next()) {
						count = rs.getInt(8);
					}
					
				}catch(Exception e) {
					e.printStackTrace();
				}finally {
					if(rs != null)try {rs.close();} catch(SQLException ex) {}
					if(pstmt != null) try {pstmt.close();} catch(SQLException ex) {}
					if(con != null) try {con.close();} catch(SQLException ex) {}
				}	
				return count;
			}
			
			
			public List<ImgDTO> getSearchFileList(int startRow, int pageSize, String search){
				List<ImgDTO> boardList = new ArrayList<ImgDTO>();
				Connection con = null;
				PreparedStatement pstmt = null;
				ResultSet rs = null;
				String sql = "";
				try {
					//1, 2디비연결 
					con = getConnection();
					//3 sql 전체 데이터 가져오기 
					// 글제목에 앞뒤에 어떤문자가 와도 상관없이 keyWord(검색어)를 가진 데이터를 ...
					//검색하는데...
					//정렬 re_ref 내림차순 re_seq 오름차순 정렬하여...
					//limit 각페이지마다 맨위에 첫번째로 보여질 시작글번호부터 ~, 한페이지당 보여줄 글개수만큼 검색함.
					sql = "select * from imgboard where subject like ? limit ?,?";
					pstmt = con.prepareStatement(sql);
					pstmt.setString(1, "%" + search + "%");	//'%안녕 %'
					pstmt.setInt(2, startRow);
					pstmt.setInt(3, pageSize);
					//4. rs 실행 저장 
					rs = pstmt.executeQuery();
					
					//5 while 데이터 있으면 BoardBean객체 생성 
					//rs => 자바빈 => boardList 한 칸 저장 
					while(rs.next()) {
						ImgDTO dto = new ImgDTO();
						dto.setFileName(rs.getString("fileName"));
						dto.setFileRealName(rs.getString("fileRealName"));
						dto.setCount(rs.getInt("count"));
						dto.setName(rs.getString("name"));
						
						dto.setDate(rs.getTimestamp("date"));
						dto.setSubject(rs.getString("subject"));
						dto.setContent(rs.getString("content"));
						dto.setNum(rs.getInt("num"));
						boardList.add(dto);
					}
					
					
				}catch (Exception e) {
					e.printStackTrace();
				}finally {
					if(rs != null)try {rs.close();} catch(SQLException ex) {}
					if(pstmt != null) try {pstmt.close();} catch(SQLException ex) {}
					if(con != null) try {con.close();} catch(SQLException ex) {}
				}
				return boardList;
			}
			
			
			public void updateImgCount(int num) {
				Connection con = null;
				PreparedStatement pstmt = null;
				ResultSet rs = null;
				String sql = "";
				try {
					//1,2 디비 연결
					con = getConnection();
					//3 sql update 테이블 set readcount = readcount + 1 where num = 
					sql = "update imgboard set count = count + 1 where num =?";
					pstmt = con.prepareStatement(sql);
					pstmt.setInt(1, num);
					//4. 실행 
					pstmt.executeUpdate();
				}catch (Exception e) {
					e.printStackTrace();
				}finally {
					if(rs != null) try {rs.close();} catch(SQLException ex) {}
					if(pstmt != null) try {pstmt.close();} catch(SQLException ex) {}
					if(con != null)try {con.close(); } catch(SQLException ex) {} 
				}
			}
			
			public ArrayList<ImgDTO> getList(){
				ArrayList<ImgDTO> list = new ArrayList<ImgDTO>();
				try {
					con = getConnection();
					String sql ="select * from imgboard";

					PreparedStatement pstmt = con.prepareStatement(sql);
					ResultSet rs = pstmt.executeQuery();
					while(rs.next()) {
						ImgDTO img = new ImgDTO();
						img.setFileName(rs.getString(1));
						img.setFileRealName(rs.getString(2));
						img.setCount(rs.getInt(3));
						img.setName(rs.getString(4));
						img.setDate(rs.getTimestamp(5));
						img.setSubject(rs.getString(6));
						img.setContent(rs.getString(7));
						img.setNum(rs.getInt(8));	
						
						list.add(img);
					}
				}catch(Exception e) {
					e.printStackTrace();
				}
				return list;
			}
			
			/* 수정할 글정보(BoardBean)객체를 전달받아 DB에 있는 패스워드와 일치하면 글 수정 */
			public int updateImgBoard(ImgDTO dto) {
				int check = 0;
				Connection con = null;
				PreparedStatement pstmt = null;
				ResultSet rs = null;
				String sql = "";
				try {
					//1, 2 디비연결 
					con = getConnection();
					//3 sql num에 해당하는 paaswd가져오기 
					sql="select pwd from imgboard where num=?";
					pstmt = con.prepareStatement(sql);
					pstmt.setInt(1, dto.getNum());
					//4 rs= 실행 저장 
					rs = pstmt.executeQuery();
					
					//5 rs 데이터 있으면 비밀번호 비교 맞으면 check = 1
					//3 update 테이블 set name, subject,content where num
					//4. 실행 
					// 		틀리면 check = 0
					if(rs.next()) {
						if(dto.getPwd().equals(rs.getString("pwd"))) {
							check = 1;
							sql = "update imgboard set name=?,subject=?,fileName=?,fileRealName=? where num =?";
							pstmt = con.prepareStatement(sql);
							pstmt.setString(1, dto.getName());
							pstmt.setString(2, dto.getSubject());
							pstmt.setString(3, dto.getFileName());
							pstmt.setString(4, dto.getFileRealName());
							pstmt.setInt(5,dto.getNum());
							//4
							pstmt.executeUpdate();
						}
					}else {
						check = 0;
					}
				}catch(Exception e) {
					e.printStackTrace();
				}finally {
					if(rs != null) try {rs.close();} catch(SQLException ex) {}
					if(pstmt != null) try {pstmt.close();} catch(SQLException ex) {}
					if(con != null) try{con.close();}catch(SQLException ex) {}
				}

				return check;
			}
			
			public void imgdeleteBoard(int num) {
				int check = 0;
				Connection con = null;
				PreparedStatement pstmt = null;
				ResultSet rs = null;
				String sql = "";
				try {
					//1, 2 디비연결 
					con = getConnection();
					//3 sql num에 해당하는 paaswd가져오기 
					sql="delete from imgboard where num=?";
					pstmt = con.prepareStatement(sql);
					pstmt.setInt(1, num);
					//4 rs= 실행 저장 
					pstmt.executeUpdate();
				}catch(Exception e) {
					e.printStackTrace();
				}finally {
					if(rs != null) try {rs.close();} catch(SQLException ex) {}
					if(pstmt != null) try {pstmt.close();} catch(SQLException ex) {}
					if(con != null) try{con.close();}catch(SQLException ex) {}
				}

			}

			
			
}
