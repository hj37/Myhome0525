package board;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class BoardDAO {
	
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
		public void insertBoard(BoardBean bean) {
			String sql="";
			int num = 0; //새글 추가 시 글번호를 만들어서 저장할 변
			
			try {
				con = getConnection(); //DB연결
				//새 글 추가시 글번호 구해오기 
				//board테이블에 글이 없는 경우 : 글번호 1
				//board테이블에 글이 존재하는 경우 : 최근 글 번호 + 1
				//SQL문 만들기
				sql = "select max(num) from board"; //가장 큰 글번호 검색 
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
				sql = "insert into board(num,name,passwd,"
						+ "subject,content,"
						+ "re_ref,re_lev,re_seq,readcount,date,ip)"
						+ "values(?,?,?,?,?,?,?,?,?,now(),?)";
				
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, num);
				pstmt.setString(2, bean.getName());
				pstmt.setString(3, bean.getPasswd());
				pstmt.setString(4, bean.getSubject());
				pstmt.setString(5, bean.getContent());
				pstmt.setInt(6, num);		//주글(새글)의 글번호를 그룹번호로 지정 
				pstmt.setInt(7, 0);	//주글(새글)의 들여쓰기 정도값 0
				pstmt.setInt(8, 0);  //주글 순서 
				pstmt.setInt(9, 0);   //주글(새글)을 추가시 조회수 0 
				pstmt.setString(10,bean.getIp());	//새글을 작성한 사람의 Ip주
				
				pstmt.executeUpdate();	//insert실
				
			}catch (Exception e) {
				System.out.println("insertBoard메서드 내부에서 예외발생하였습니다:" +e.getMessage());
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
		
	
		public int getBoardCount() {
			String sql ="";
			int count = 0; //검색한 전체 글수를 저장할 용도
			
			try {
				//DB연결 
				con = getConnection();
				sql = "select count(*) from board";
				pstmt = con.prepareStatement(sql);
				rs = pstmt.executeQuery(); //select문 실행 
				
				if(rs.next()) {
					count = rs.getInt(1); //검색한 전체 글 개수 얻기 
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
		
		//글목록 검색 메소드
		//notice.jsp에서 호출하는 메소드로
		//getBoardList(각페이지마다 맨위에 첫번쨰로 보여질 시작글번호, 한 페이지당 보여지는 글개수)를 전달받아...
		//검색한 글정보(BoardBean)하나하나를 ArrayList에 담아.. 반환함.
		
		public List<BoardBean> getBoardList(int startRow,int pageSize){
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
		
		
		public void updateReadCount(int num) {
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql = "";
			try {
				//1,2 디비 연결
				con = getConnection();
				//3 sql update 테이블 set readcount = readcount + 1 where num = 
				sql = "update board set readcount = readcount + 1 where num =?";
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
		
		
		//글 하나의 정보를 검색하여 글정보를 제공해주는 메소드 
			public BoardBean getBoard(int num) {
					

				//매개변수로 전달 받은 글 번호에 해당하는 글을 검색해서 저장할 BoardDto객체 생성
				BoardBean bBean = new BoardBean();
				try {
					//커넥션풀로 커넥션 얻기(DB접속) 
					con = getConnection();
					
					//매개변수로 전달 받은 글번호에 해당 되는 글 하나의 정보를 검색하는 SELECT구문 만들기 
					String sql = "select * from board where num = ?";	
					//?기호 해당되는 값을 제외한 나머지 SELECT문장을 저장한? PreparedStatement실행 객체 얻기
					pstmt = con.prepareStatement(sql);
					//?기호에 해당되는 글번호를 설정
					pstmt.setInt(1, num);
					//SELECT구문 실행한 후 검색된 글 하나의 정보를 ResultSet에 저장 후 반환 받기
					rs = pstmt.executeQuery();
					
					//ResultSet임시 저장소에 검색한 데이터(글 하나의 정보)가 존재하면?
					if(rs.next()) {
						//ResultSet에서 검색한 글의 정보들을 꺼내와서 BoardDto객체의 각 변수에 저장  
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
					}
					
				} catch (Exception e) {
					
					System.out.println("getBoard메소드 내부에서 오류 : " + e.getMessage());
					
				}finally {
					if(rs != null) try{rs.close();}catch(Exception e) {e.printStackTrace();}
					if(pstmt != null) try{pstmt.close();}catch(Exception e) {e.printStackTrace();}
					if(con != null) try{con.close();}catch(Exception e) {e.printStackTrace();}
				}
				
				return bBean;	//DB로부터 검색한 하나의 글정보를 BoardDto객체에 저장 후 Update.jsp로 반환

			}
			
			
			/* 수정할 글정보(BoardBean)객체를 전달받아 DB에 있는 패스워드와 일치하면 글 수정 */
			public int updateBoard(BoardBean bBean) {
				int check = 0;
				Connection con = null;
				PreparedStatement pstmt = null;
				ResultSet rs = null;
				String sql = "";
				try {
					//1, 2 디비연결 
					con = getConnection();
					//3 sql num에 해당하는 paaswd가져오기 
					sql="select passwd from board where num=?";
					pstmt = con.prepareStatement(sql);
					pstmt.setInt(1, bBean.getNum());
					//4 rs= 실행 저장 
					rs = pstmt.executeQuery();
					
					//5 rs 데이터 있으면 비밀번호 비교 맞으면 check = 1
					//3 update 테이블 set name, subject,content where num
					//4. 실행 
					// 		틀리면 check = 0
					if(rs.next()) {
						if(bBean.getPasswd().equals(rs.getString("passwd"))) {
							check = 1;
							sql = "update board set name=?,subject=?,content=? where num =?";
							pstmt = con.prepareStatement(sql);
							pstmt.setString(1, bBean.getName());
							pstmt.setString(2, bBean.getSubject());
							pstmt.setString(3, bBean.getContent());
							pstmt.setInt(4,bBean.getNum());
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
			
	/*
	 답변 달기 필드 설명 
	 group(re_ref) 부모글과 그로부터 파생된 자식글들이 같은 값을 가지기 위한 필드
	 seq(re_seq) 같은 group 글들 내에서의 순서 
	 level(re_lev) 같은 group내에서의 깊이 (들여쓰기) 
	 
	 답변 달기 규칙 설명 
	 순서 1) group(re_ref)같은 부모글의 그룹번호(re_ref)를 사용한다.
	 
	 순서 2) seq(re_seq)값은 부모글의 seq(re_seq)에서 +1증가 한 값을 사용한다.
	 	단!! 부모글을 제외한 같은 group내에서 먼저 입력된 글은 seq값을 +1 증가시킨다.
	 	
	 순서 3)level(re_lev)값은 부모글의 re_lev에서 +1 증가 한 값을 사용한다.
	 */
			
	/* 답변달기 메소드 : 
	 * 부모글의 group(re_ref), seq(re_seq), level(re_lev) 값  + 
	 * 답변글내용 또한 지니고 있는 BoardBean객체 전달받아 처리 
	 */
	
	public void reInsertBoard(BoardBean bBean) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		int num = 0;
		try {
			//1, 2디비연결
			con = getConnection();
			/*답변글 글번호 구하기 */
			//3 기존 글 중 num이 가장 큰 글번호 가져오기
			sql = "select max(num) from board";
			pstmt = con.prepareStatement(sql);
			//4 rs=실행 저장
			rs = pstmt.executeQuery();
			
		//5 글번호가 있으면..
		if(rs.next()) {
			//답변글 번호 = 그글번호에 + 1
			num = rs.getInt(1) + 1;
		}else {
			num = 1;
		}
		
		/*re_seq 답글순서 재배치 */
		//부모글 그룹과 같은 그룹이면서 .. 부모글의 seq값보다 큰 답변글들은? seq값을 1증가시킨다.
		sql = "update board set re_seq = re_seq + 1 where re_ref=? and re_seq>?";
		pstmt = con.prepareStatement(sql);
		pstmt.setInt(1, bBean.getRe_ref());	//부모글 그룹번호
		pstmt.setInt(2, bBean.getRe_seq());	//부모글의 글 입력 순서 
		pstmt.executeUpdate(); 
		
		
/* 답변글 달기 */
//3 insert // re_seq + 1 re_lev + 1 답글 달기 
		sql = "insert into board values(?,?,?,?,?,?,?,?,?,?,?,?)";
		pstmt= con.prepareStatement(sql);
		pstmt.setInt(1, num);
		pstmt.setString(2, bBean.getName());
		pstmt.setString(3, bBean.getPasswd());
		pstmt.setString(4, bBean.getSubject());
		pstmt.setString(5, bBean.getContent());
		pstmt.setString(6, bBean.getFile());
		pstmt.setInt(7, bBean.getRe_ref());	//부모글 그룹번호 re_ref 사용
		pstmt.setInt(8, bBean.getRe_lev() + 1);	//부모글의 re_lev에 + 1을 하여 들여쓰기 
		pstmt.setInt(9, bBean.getRe_seq() + 1);	//부모글의 re_seq에 + 1을 하여 답글을 단순서 정하기 
		pstmt.setInt(10, 0);	//부모글의 re_seq에 + 1을 하여 답글을 단순서 정하기 
		pstmt.setTimestamp(11, bBean.getDate());	//부모글의 re_seq에 + 1을 하여 답글을 단순서 정하기 
		pstmt.setString(12, bBean.getIp());	//부모글의 re_seq에 + 1을 하여 답글을 단순서 정하기 

pstmt.executeUpdate();
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(rs != null) try {rs.close();} catch(SQLException ex) {}
			if(pstmt != null) try {pstmt.close();} catch(SQLException ex) {}
			if(con != null) try{con.close();}catch(SQLException ex) {}

		}

	}
	
	/*검색어를 전달받아 검색어에 해당하는 글개수를 DB로부터 가져와서 글개수 리턴 */
	public int getCount(String search) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		int count = 0;
		try {
			//1, 2디비연결 
			con = getConnection();
			//3 sql 검색어에 해당하는 게시판 글개수 가져오기 count(*) 
			sql = "select count(*) from board where subject like ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, "%"+ search + "%");
			//4 rs 실행저장
			rs = pstmt.executeQuery();
			//5 rs데이터 있으면 count 저장
			if(rs.next()) {
				count = rs.getInt(1);
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
	
	
	//* 글목록 가져오기2(검색어를 입력했을때....) */
	//getBoardList(각 페이지마다 맨위에 첫 번째로 보여질 시작 글번호, 한페이지당 보여줄 글 개수, 검색어) 를 
	//전달받아.. 글정보(BoardBean객체) 하나하나를 ArrayList에 담아.. getBoardList()메소드를..
	//호출한 곳으로 .. BoardBean객체들을 저장하고 있는 ArrayList객체를 리턴함.
	
	public List<BoardBean> getBoardList(int startRow, int pageSize, String search){
		List<BoardBean> boardList = new ArrayList<BoardBean>();
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
			sql = "select * from board where subject like ? order by re_ref desc, re_seq asc limit ?,?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, "%" + search + "%");	//'%안녕 %'
			pstmt.setInt(2, startRow);
			pstmt.setInt(3, pageSize);
			//4. rs 실행 저장 
			rs = pstmt.executeQuery();
			
			//5 while 데이터 있으면 BoardBean객체 생성 
			//rs => 자바빈 => boardList 한 칸 저장 
			while(rs.next()) {
				BoardBean bBean = new BoardBean();
				bBean.setContent(rs.getString("content"));
				bBean.setDate(rs.getTimestamp("date"));
				bBean.setFile(rs.getString("file"));
				bBean.setIp(rs.getString("ip"));
				bBean.setName(rs.getString("name"));
				bBean.setNum(rs.getInt("num"));
				bBean.setPasswd(rs.getString("passwd"));
				bBean.setRe_lev(rs.getInt("re_lev"));
				bBean.setRe_ref(rs.getInt("re_ref"));
				bBean.setRe_seq(rs.getInt("re_seq"));
				bBean.setReadcount(rs.getInt("readcount"));
				bBean.setSubject(rs.getString("subject"));
				
				boardList.add(bBean);
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
	
	/* 수정할 글정보(BoardBean)객체를 전달받아 DB에 있는 패스워드와 일치하면 글 수정 */
	public void deleteBoard(int num) {
		int check = 0;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		try {
			//1, 2 디비연결 
			con = getConnection();
			//3 sql num에 해당하는 paaswd가져오기 
			sql="delete from board where num=?";
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

		
		 
}//BoardDAO클래스 끝 
