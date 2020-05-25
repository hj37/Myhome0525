package member;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class MemberDAO {
	//커넥션풀(DataSource)을 얻은 후 ConnectionDB접속
	private Connection getConnection() throws Exception{
		
		Context init = new InitialContext();
		DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/jspbeginner");
		//커넥션풀에 존재하는 커넥션 얻기 
		Connection con =  ds.getConnection();
		//커넥션 반환
		return con;				
	}
	
	/*insertMember()메소드 : 
	 * 가입할 회원정보들을 ? MemberBean객체의 각 변수에 저장한 후 매개변수로 전달받아 DB에 INSERT */
	 
	 
	 public void insertMember(MemberBean memberBean) {
		 Connection con = null;
		 PreparedStatement pstmt = null;
		 String sql="";
		 /*메소드안에서 지역변수라서 초기화를 해야함 */
		 
		 try {
			 //커넥션풀로부터 커넥션얻기(DB접속) 
			 con = getConnection();
			 sql = "insert into hojin (id,passwd,name,reg_date,email,address) values(?,?,?,now(),?,?)";
			 pstmt = con.prepareStatement(sql);
			 pstmt.setString(1, memberBean.getId());
			 pstmt.setString(2, memberBean.getPasswd());
			 pstmt.setString(3, memberBean.getName());
			 pstmt.setString(4, memberBean.getEmail());
			 pstmt.setString(5, memberBean.getAddress());
			 
			 pstmt.executeUpdate();	//Insert 실행 
		 }catch(Exception e) {
			 System.out.println("insertMember메소드 내부에서 예외발생: " + e.toString());
		 }finally {
			 try {
				 if(pstmt != null) {pstmt.close();}
				 if(con != null) {con.close();}
				 
			 }catch(SQLException e){
				 e.printStackTrace();
			 }
		 }//finally
		 
		 
		 
	 }//insertMember메서드 
	 
	 
	 public MemberBean Memberinfo(String id) {
		 Connection con = null;
		 PreparedStatement pstmt = null;
		 String sql="";
		 ResultSet rs = null;
		 /*메소드안에서 지역변수라서 초기화를 해야함 */
		 MemberBean memberBean = new MemberBean();
		 try {
			 //커넥션풀로부터 커넥션얻기(DB접속) 
			 con = getConnection();
			 sql = "select * from hojin where id=?";
			 pstmt = con.prepareStatement(sql);
			 pstmt.setString(1, id);
			 rs = pstmt.executeQuery();
			 
			 if(rs.next()) {
				 memberBean.setId(rs.getString("id"));
				 memberBean.setPasswd(rs.getString("passwd"));
				 memberBean.setName(rs.getString("name"));
				 memberBean.setReg_date(rs.getTimestamp("reg_date"));
				 memberBean.setEmail(rs.getString("email"));
				 memberBean.setAddress(rs.getString("address"));
			 }
			 
		 }catch(Exception e) {
			 System.out.println("insertMember메소드 내부에서 예외발생: " + e.toString());
		 }finally {
			 try {
				 if(rs != null) {rs.close();}
				 if(pstmt != null) {pstmt.close();}
				 if(con != null) {con.close();}
				 
			 }catch(SQLException e){
				 e.printStackTrace();
			 }
		 }//finally
		 return memberBean;
	 }//insertMember메서드
	 
	 
	 
	 //회원가입을 위해 사용자가 입력한 id값을 매개변수로 전달받아..
	 //DB에 사용자가 입력한 id값이 존재하는지 select하여..
	 //만약 사용자가 입력한 id에 해당하는 회원레코드가 select되면?
	 //check변수값을 1로 저장하여 <---- 아이디 중복을 나타내게 하고
	 //만약 사용자가 입력한 id에 해당하는 회원레코드가 없으면?
	 //check 변수값을 0으로 저장하여 <--- 아이디 중복 아님을 나타내게 함.
	 
	 //결과적으로.. 아이디중복이나 중복이 아니냐는 check변수에 저장되어 있으므로
	 //check변수값을 리턴함.
	 
	 
	 public void updateMember(MemberBean memberBean,String id) {
		 //Connection을 담을 변수 선언 
		 Connection con = null;
		 
		 //PreparedStatement를 담을 변수 선언
		 PreparedStatement pstmt = null;
		 
		 //SQL문을 생성해서 저장할 변수 선언 
		 String sql ="";
		 
		 try {
			 con = getConnection();
			 sql = "update hojin set id=?, passwd=?, name=?, email=?, address=? where id=?";
			 pstmt = con.prepareStatement(sql);
			 pstmt.setString(1,memberBean.getId());
			 
			 pstmt.setString(2,memberBean.getPasswd());
			 pstmt.setString(3,memberBean.getName());
			 pstmt.setString(4,memberBean.getEmail());
			 pstmt.setString(5,memberBean.getAddress());
			 pstmt.setString(6,id);
			 
			 pstmt.executeUpdate();	//update 실행 
		 }catch(Exception e) {
			 System.out.println("updateMember메소드 내부에서 예외발생 : " + e.toString());
		 }finally {
			 try {
				 if(pstmt != null) {pstmt.close();}
				 if(con != null) {con.close();}
			 }catch (Exception e) {
				 e.printStackTrace();
			}
		 }
	 }
	 
	 public int idCheck(String id) {
		 //Connection을 담을 변수선언
		 Connection con = null;
		 
		 //PreparedStatement를 담을 변수 선언
		 PreparedStatement pstmt = null;
		 
		 //SQL문을 생성해서 저장할 변수 선언
		 String sql="";
		 
		 //검색한 결과 데이터를 저장할 임시공간인? ResultSet을 담을 변수 선언
		 ResultSet rs = null;
		 
		 int check = 0; //아이디 중복이냐 아니냐 판단하는 값
		 
		 try {
			//커넥션풀로부터 커넥션 얻기
			con = getConnection();
			//매개변수로 전달받은 id에 해당하는 레코드 검색 sql문 만들기
			sql = "select * from hojin where id = ?";
			//SELECT 구문을 실행할 PreparedStatement 객체 얻기 
			pstmt = con.prepareStatement(sql);
			
			//?값 설정 
			pstmt.setString(1, id);
			//SELECT문 실행 후 검색한 결과를 ResultSet에 저장 후 얻기 
			rs = pstmt.executeQuery();
			
			//검색한 데이터 존재하면
				//check 변수값을 1로 저장
			//검색한 데이터가 존재하지 않으면 
				//check 변수값을 0으로 저장 
			if(rs.next()) {
				check = 1;
			}else {
				check = 0;
			}
			 
		} catch (Exception e) {
			System.out.println("idCheck메소드 내부에서 예외발생 : " +  e.toString());
		}finally {
			try {
				if(rs != null) {rs.close();}
				if(pstmt != null) {pstmt.close();}
				if(con != null) {con.close();}
			}catch(SQLException e) {
				e.printStackTrace();
			}
		}
		 return check;
	 }
	 
	 public int userCheck(String id, String passwd) {
		 //Connection을 담을 변수 선언 
		 Connection con = null;
		 
		 //PreparedStatement를 담을 변수 선언
		 PreparedStatement pstmt = null;
		 
		 //SQL문을 생성해서 저장할 변수 선언 
		 String sql ="";
		 
		 //검색한 결과 데이터를 저장할 임시공간인? ResultSet을 담을 변수 선언
		 ResultSet rs = null;
		 
		 int check = 0;
		 
		 try {
			 con = getConnection();
			 sql = "select * from hojin where id =?";
			 pstmt = con.prepareStatement(sql);
			 //?값 설정 
			pstmt.setString(1, id);
			
			//SELECT문 실행 후 검색한 결과를 ResultSet에 저장 후 얻기 
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				if(rs.getString("passwd").equals(passwd)) {
						check = 1; //아이디 맞음, 비밀번호 맞
				}else {//아이디 맞음, 비밀번호틀림 
						check = 0;
				}
			}else {
					check = -1;
			}
				
		 }catch(Exception e) {
			 System.out.println("userCheck메소드 내부에서 예외발생 : " + e.toString());
		 }finally {
			 try {
				 if(rs != null) {rs.close();}
				 if(pstmt != null) {pstmt.close();}
				 if(con != null) {con.close();}
			 }catch (Exception e) {
				 e.printStackTrace();
			}
		 }
		 return check;
	 }
	
}//MemberDAO클래스 

