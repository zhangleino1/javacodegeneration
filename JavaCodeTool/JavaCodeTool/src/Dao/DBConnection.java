package Dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.util.Properties;

import javax.swing.JTextArea ;

/**
 * ��ȡ���ݿ�����
 * 
 * @author ����
 * 
 */
public class DBConnection {

	// /** _Mysql���ݿ�����URL */
	// private String DB_URL =
	// "jdbc:mysql://127.0.0.1:3306/qq?useUnicode=true&characterEncoding=gb2312";
	//
	// /** _Mysql���ݿ��������� */
	// private String DB_DRIVER = "com.mysql.jdbc.Driver";
	//
	// /** _Mysql���ݿ��û��� */
	// private String DB_USERNAME = "root";
	//
	// /** _Mysql���ݿ����� */
	// private String DB_PASSWORD = "";

	/** _Mysql���ݿ�����URL */
	private String DB_URL;

	/** _Mysql���ݿ��������� */
	private String DB_DRIVER;

	/** _Mysql���ݿ��û��� */
	private String DB_USERNAME;

	/** _Mysql���ݿ����� */
	private String DB_PASSWORD;

	private JTextArea  pane;

	/**
	 * ��ȡ���ݿ�����
	 * 
	 * @return
	 */
	public Connection getConnection() {
		/** ����Connection���Ӷ��� */
		Connection conn = null;
		try {
			/** ʹ��Class.forName()�����Զ�����������������ʵ�����Զ�����DriverManager��ע���� */
			Class.forName(DB_DRIVER);
			/** ͨ��DriverManager��getConnection()������ȡ���ݿ����� */
			Properties props = new Properties();
			props.put("user", DB_USERNAME);
			props.put("password", DB_PASSWORD);
			props.put("remarksReporting", "true");
			conn = DriverManager.getConnection(DB_URL, props);
		} catch (Exception ex) {
			pane.setText("<span style=\"color:red;\">error:" + ex.toString()
					+ "�鿴����̨</span>");
			ex.printStackTrace();
		}
		return conn;
	}

	/**
	 * �ر����ݿ�����
	 * 
	 * @param connect
	 */
	public void closeConnection(Connection conn) {
		try {
			if (conn != null) {
				/** �жϵ�ǰ�������Ӷ������û�б��رվ͵��ùرշ��� */
				if (!conn.isClosed()) {
					conn.close();
				}
			}
		} catch (Exception ex) {
			pane.append("error:" + ex.toString()
					+ "�鿴����̨\n");
			ex.printStackTrace();
		}
	}

	public void testConnection() {
		Connection con = getConnection();
		if (con != null) {
			pane.append("���ӳɹ�\n");
		} else {
			pane.append("error:����ʧ��\n");
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