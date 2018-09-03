package db;

import java.sql.*;

public class DbConnect {
	private Connection con;
	private PreparedStatement checkUser, getUser, getFile, insertUser,changePass,getpass,changePhoto,getSearchUser,getMsg,insertMsg;
        private Statement st;
        
	public Statement getSt(){
            return st;
        }
        
	public DbConnect() {
		try{
			Class.forName("com.mysql.jdbc.Driver");
			con=DriverManager.getConnection("jdbc:mysql://localhost:3306/ptalk","root","incapp");
                        st=con.createStatement();
                        changePhoto=con.prepareStatement("update user_info set photo=? where email=?");
                        getFile=con.prepareStatement("select filename,ufile from ptalk where pid=?");
			getUser=con.prepareStatement("select * from user_info where email=? and pass=? ");
                        insertMsg=con.prepareStatement("insert into ptalk (sid,rid,udate,msg,filename,ufile) values (?,?,now(),?,?,?) ");
                        getMsg=con.prepareStatement("select * from ptalk where sid=? and rid=?");
                        changePass=con.prepareStatement("update user_info set pass=? where email=?");
			checkUser=con.prepareStatement("select * from user_info where email=? ");
			insertUser=con.prepareStatement("insert into user_info values (?,?,?,?,?,?,?,?,?,?) ");
                        getpass=con.prepareStatement("select * from user_info where email=?");
			getSearchUser=con.prepareStatement("select * from user_info where state=? and city=? and area like ? and email !=?");
		}
		catch(Exception ex) {
			ex.printStackTrace();
		}
	}
        
        public ResultSet getMsg(String s, String r){
        try{        
            getMsg.setString(1, s);
            getMsg.setString(2, r);
            ResultSet rs=getMsg.executeQuery();
            return rs;
        }catch(Exception ex){
            ex.printStackTrace();
            return null;
        }
    }
        
        public ResultSet getFile(int p){
        try{        
            getFile.setInt(1, p);
            ResultSet r=getFile.executeQuery();
            if(r.next()){
                return r;
            }else{
                return null;
            }
        }catch(Exception ex){
            ex.printStackTrace();
            return null;
        }
    }
        
    public String insertMsg(String s,String r,String m,String fn,java.io.InputStream in) {
        try{        
            insertMsg.setString(1, s);
            insertMsg.setString(2, r);
            insertMsg.setString(3, m);
            insertMsg.setString(4, fn);
            insertMsg.setBinaryStream(5, in);
           int x=insertMsg.executeUpdate();
           if(x==1)
            return "Done";
           else 
            return "Error";
        }catch(Exception ex){
            ex.printStackTrace();
            return "Exception";
        }
    }
        
        public String changePhoto(String e,java.io.InputStream im) {
		try {
			changePhoto.setString(2, e);
			changePhoto.setBinaryStream(1, im);
			int x=changePhoto.executeUpdate();
			if(x==1)
				return "Done";
			else
				return "Error";
		}catch(Exception ex){
                    ex.printStackTrace();
                    return "Exception";
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
        
        public ResultSet getSearchUser(String s, String c, String a,String e) {
		try {
			getSearchUser.setString(1, s);
			getSearchUser.setString(2, c);
			getSearchUser.setString(3, "%"+a+"%");
			getSearchUser.setString(4, e);
			ResultSet rs=getSearchUser.executeQuery();
                        return rs;
		}
		catch(Exception ex) {
                    ex.printStackTrace();
                    return null;	
		}
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