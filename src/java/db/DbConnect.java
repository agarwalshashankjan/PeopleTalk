package db;

import java.sql.*;

public class DbConnect {
	private Connection con;
	private PreparedStatement checkUser, getUser, insertUser,changePass,getpass;
        private Statement st;
        
	public Statement getSt(){
            return st;
        }
        
	public DbConnect() {
		try{
			Class.forName("com.mysql.jdbc.Driver");
			con=DriverManager.getConnection("jdbc:mysql://localhost:3306/ptalk","root","incapp");
                        st=con.createStatement();
			getUser=con.prepareStatement("select * from user_info where email=? and pass=? ");
                        changePass=con.prepareStatement("update user_info set pass=? where email=?");
			checkUser=con.prepareStatement("select * from user_info where email=? ");
			insertUser=con.prepareStatement("insert into user_info values (?,?,?,?,?,?,?,?,?,?) ");
                        getpass=con.prepareStatement("select * from user_info where email=?");
//			getSearchUser=con.prepareStatement("select * from user_info where state=? or city=? or area=? ");
		}
		catch(Exception ex) {
			ex.printStackTrace();
		}
	}
        
        public ResultSet getUser(String e, String p) {
		try {
			getUser.setString(1, e);
			getUser.setString(2, p);
			ResultSet rs=getUser.executeQuery();
                        if(rs.next())
			   return rs;
		}
		catch(Exception ex) {
			
		}
		return null;
	}
	public int changePass(String e, String p) {
		try {
			changePass.setString(2, e);
			changePass.setString(1, p);
			int rs=changePass.executeUpdate();
                        if(rs!=-1)
			   return rs;
                        else
                            return -1;
		}
		catch(Exception ex) {
                    ex.printStackTrace();
			return -1;
		}
		
	}
	
	public ResultSet checkUser(String e) {
		try {
			checkUser.setString(1, e);
			ResultSet rs=checkUser.executeQuery();
			if(rs.next())
                            return rs;
                        else{
                            return null;
                        }
		}
		catch(Exception ex) {
			 ex.printStackTrace();
            return null;
		}

	}
        
        public ResultSet getpass(String e) {
		try {
			getpass.setString(1, e);
			ResultSet rs=getpass.executeQuery();
			if(rs.next())
                            return rs;
                        else{
                            return null;
                        }
		}
		catch(Exception ex) {
			 ex.printStackTrace();
            return null;
		}

	}
	
	public String insertUser(String e,String p,String n,String ph,
			String gen,java.sql.Date d,String s,String c,String a,java.io.InputStream im) {
		try {
			insertUser.setString(1, e);
			insertUser.setString(2, p);
			insertUser.setString(7, n);
			insertUser.setString(3, ph);
			insertUser.setString(5, gen);
			insertUser.setDate(6, d);
			insertUser.setString(8, s);
			insertUser.setString(9, c);
			insertUser.setString(4, a);
			insertUser.setBinaryStream(10, im);
			int x=insertUser.executeUpdate();
			if(x==1)
				return "Done";
			else
				return "Error";
		}catch(java.sql.SQLIntegrityConstraintViolationException ex){
                    ex.printStackTrace();
                    return "Already";
                }catch(Exception ex){
                    ex.printStackTrace();
                    return "Exception";
                }
            }
}