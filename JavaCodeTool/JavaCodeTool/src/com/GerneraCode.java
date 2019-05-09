package com;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.io.Writer;
import java.sql.Connection;
import java.sql.DatabaseMetaData;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.swing.JTextArea;

import freemarker.template.Configuration;
import freemarker.template.Template;

import Dao.DBConnection;

/**
 * 代码生成器
 * 
 * @author Administrator
 * 
 */
public class GerneraCode {
	private String dbUrl;
	private String dbDriver;
	private String dbUser;
	private String dbPwd;
	private String tableName;
	private String domainName;
	private String pagesPath;
	private String svcPath;
	private String implPath;
	private Configuration cfg;
	private JTextArea pane;
	private DBConnection dbCon;

	public GerneraCode(String dbUrl, String dbDriver, String dbUser,
			String dbPwd, String tableName, String domainName,
			String pagesPath, String svcPath, String implPath, JTextArea pane) {
		super();
		this.dbUrl = dbUrl;
		this.dbDriver = dbDriver;
		this.dbUser = dbUser;
		this.dbPwd = dbPwd;
		this.tableName = tableName;
		this.domainName = domainName;
		this.pagesPath = pagesPath;
		this.svcPath = svcPath;
		this.implPath = implPath;
		this.pane = pane;
		init();
	}

	/**
	 * 初始化
	 */
	public void init() {
		File file = new File("bin/resource/template");
		cfg = new Configuration();
		try {
			cfg.setDirectoryForTemplateLoading(file);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			pane.append("error:" + e.toString() + "查看控制台\n");
		}
	}

	/**
	 * 表名返回表字段信息
	 * 
	 * @param table
	 *            表名
	 * @return 表字段信息
	 */
	public HashMap<String, Object> loadDbTableInfo(String table) {
		HashMap<String, Object> root = new HashMap<String, Object>();
		List<HashMap<String, String>> list = new ArrayList<HashMap<String, String>>();
		dbCon = new DBConnection(this.dbUrl, this.dbDriver, this.dbUser,
				this.dbPwd, this.pane);
		Connection con = dbCon.getConnection();
		ResultSet rs;
		try {
			DatabaseMetaData dbmd = con.getMetaData();
			rs = dbmd.getColumns(null, "%", table, "%");
			while (rs.next()) {
				HashMap<String, String> map = new HashMap<String, String>();
				map.put("COLUMN_NAME", rs.getString("COLUMN_NAME")
						.toLowerCase());
				map.put("REMARKS", rs.getString("REMARKS"));
				map.put("TYPE_NAME", rs.getString("TYPE_NAME"));
				list.add(map);
			}
			rs = dbmd.getTables(null, "%", table, new String[] { "TABLE" });
			if (rs.next()) {
				root.put("tableComment", rs.getString("REMARKS"));// table
																	// comment
			}
			root.put("list", list);
			root.put("title", tableName);// tableName
			root.put("domainName", domainName);
			return root;
		} catch (Exception e) {
			pane.append("error:" + e.toString() + "查看控制台\n");
			e.printStackTrace();
		} finally {
			dbCon.closeConnection(con);
		}
		return root;
	}

	/**
	 * 生成新文件
	 * 
	 * @param root
	 *            信息封装
	 * @param newFileName
	 *            新文件名字
	 * @param templeName
	 *            模版名字
	 * @param newFilePath
	 *            新文件路径
	 */
	public void startMake(HashMap<String, Object> root, String newFileName,
			String templeName, String newFilePath) {
		Template t;
		try {
			t = cfg.getTemplate(templeName);
			Writer out = new OutputStreamWriter(new FileOutputStream(
					newFilePath + "/" + newFileName), "utf-8");
			t.process(root, out);
			out.flush();
			out.close();
			pane.append(newFilePath + "/" + newFileName + "生成成功\n");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			pane.append("error:" + e.toString() + "查看控制台\n");
		}
	}

	public void begin() {
		HashMap<String, Object> root = this.loadDbTableInfo(tableName);
		this.startMake(root, "I" + this.domainName + "Svc.java", "svc.ftl",
				svcPath);// 生成svc文件
		this.startMake(root, this.domainName + "Impl.java", "Impl.ftl",
				implPath);// 生成Impl文件
		this.startMake(root, this.domainName + "_Form.html", "Form.ftl",
				pagesPath);// 生成form 页面
		this.startMake(root, this.domainName + "_View.html", "View.ftl",
				pagesPath);// 生成view 页面
		this.startMake(root, this.domainName + ".html", "mainhtml.ftl",
				pagesPath);// 生成main.html 页面
		this.startMake(root, this.domainName + ".js", "js.ftl",
				pagesPath);// 生成js 页面
		
	}

	public void testConnection() {
		dbCon = new DBConnection(this.dbUrl, this.dbDriver, this.dbUser,
				this.dbPwd, this.pane);
		dbCon.testConnection();
	}

	public String getDbUrl() {
		return dbUrl;
	}

	public void setDbUrl(String dbUrl) {
		this.dbUrl = dbUrl;
	}

	public String getDbDriver() {
		return dbDriver;
	}

	public void setDbDriver(String dbDriver) {
		this.dbDriver = dbDriver;
	}

	public String getDbUser() {
		return dbUser;
	}

	public void setDbUser(String dbUser) {
		this.dbUser = dbUser;
	}

	public String getDbPwd() {
		return dbPwd;
	}

	public void setDbPwd(String dbPwd) {
		this.dbPwd = dbPwd;
	}

	public String getTableName() {
		return tableName;
	}

	public void setTableName(String tableName) {
		this.tableName = tableName;
	}

	public String getDomainName() {
		return domainName;
	}

	public void setDomainName(String domainName) {
		this.domainName = domainName;
	}

	public String getPagesPath() {
		return pagesPath;
	}

	public void setPagesPath(String pagesPath) {
		this.pagesPath = pagesPath;
	}

	public String getSvcPath() {
		return svcPath;
	}

	public void setSvcPath(String svcPath) {
		this.svcPath = svcPath;
	}

	public String getImplPath() {
		return implPath;
	}

	public void setImplPath(String implPath) {
		this.implPath = implPath;
	}

	public Configuration getCfg() {
		return cfg;
	}

	public void setCfg(Configuration cfg) {
		this.cfg = cfg;
	}

}
