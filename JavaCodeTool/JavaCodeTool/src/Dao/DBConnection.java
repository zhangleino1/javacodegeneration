package Dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.util.Properties;

import javax.swing.JTextArea ;

/**
 * 获取数据库连接
 * 
 * @author 杨涛
 * 
 */
public class DBConnection {

	// /** _Mysql数据库连接URL */
	// private String DB_URL =
	// "jdbc:mysql://127.0.0.1:3306/qq?useUnicode=true&characterEncoding=gb2312";
	//
	// /** _Mysql数据库连接驱动 */
	// private String DB_DRIVER = "com.mysql.jdbc.Driver";
	//
	// /** _Mysql数据库用户名 */
	// private String DB_USERNAME = "root";
	//
	// /** _Mysql数据库密码 */
	// private String DB_PASSWORD = "";

	/** _Mysql数据库连接URL */
	private String DB_URL;

	/** _Mysql数据库连接驱动 */
	private String DB_DRIVER;

	/** _Mysql数据库用户名 */
	private String DB_USERNAME;

	/** _Mysql数据库密码 */
	private String DB_PASSWORD;

	private JTextArea  pane;

	/**
	 * 获取数据库连接
	 * 
	 * @return
	 */
	public Connection getConnection() {
		/** 声明Connection连接对象 */
		Connection conn = null;
		try {
			/** 使用Class.forName()方法自动创建这个驱动程序的实例且自动调用DriverManager来注册它 */
			Class.forName(DB_DRIVER);
			/** 通过DriverManager的getConnection()方法获取数据库连接 */
			Properties props = new Properties();
			props.put("user", DB_USERNAME);
			props.put("password", DB_PASSWORD);
			props.put("remarksReporting", "true");
			conn = DriverManager.getConnection(DB_URL, props);
		} catch (Exception ex) {
			pane.setText("<span style=\"color:red;\">error:" + ex.toString()
					+ "查看控制台</span>");
			ex.printStackTrace();
		}
		return conn;
	}

	/**
	 * 关闭数据库连接
	 * 
	 * @param connect
	 */
	public void closeConnection(Connection conn) {
		try {
			if (conn != null) {
				/** 判断当前连接连接对象如果没有被关闭就调用关闭方法 */
				if (!conn.isClosed()) {
					conn.close();
				}
			}
		} catch (Exception ex) {
			pane.append("error:" + ex.toString()
					+ "查看控制台\n");
			ex.printStackTrace();
		}
	}

	public void testConnection() {
		Connection con = getConnection();
		if (con != null) {
			pane.append("连接成功\n");
		} else {
			pane.append("error:连接失败\n");
		}
		closeConnection(con);
	}

	public String getDB_URL() {
		return DB_URL;
	}

	public void setDB_URL(String dB_URL) {
		DB_URL = dB_URL;
	}

	public String getDB_DRIVER() {
		return DB_DRIVER;
	}

	public void setDB_DRIVER(String dB_DRIVER) {
		DB_DRIVER = dB_DRIVER;
	}

	public String getDB_USERNAME() {
		return DB_USERNAME;
	}

	public void setDB_USERNAME(String dB_USERNAME) {
		DB_USERNAME = dB_USERNAME;
	}

	public String getDB_PASSWORD() {
		return DB_PASSWORD;
	}

	public void setDB_PASSWORD(String dB_PASSWORD) {
		DB_PASSWORD = dB_PASSWORD;
	}

	public DBConnection(String dB_URL, String dB_DRIVER, String dB_USERNAME,
			String dB_PASSWORD, JTextArea  pane) {
		super();
		DB_URL = dB_URL;
		DB_DRIVER = dB_DRIVER;
		DB_USERNAME = dB_USERNAME;
		DB_PASSWORD = dB_PASSWORD;
		this.pane = pane;
	}

}