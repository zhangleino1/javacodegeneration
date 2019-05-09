package ui;

import java.awt.EventQueue;

import javax.swing.JFrame;
import javax.swing.JPanel;
import javax.swing.border.EmptyBorder;
import javax.swing.JFileChooser;
import javax.swing.JLabel;
import javax.swing.JTextField;
import javax.swing.JButton;
import javax.swing.UIManager;

import java.awt.event.ActionListener;
import java.awt.event.ActionEvent;
import java.awt.event.FocusEvent;
import java.awt.event.FocusListener;
import java.io.File;

import javax.swing.JTextArea ;

import org.jvnet.substance.SubstanceLookAndFeel;
import org.jvnet.substance.skin.CremeSkin;

import com.GerneraCode;

public class MainFrame extends JFrame {

	/** Oracle数据库连接URL */
	private final static String DB_URL = "jdbc:oracle:thin:@192.168.1.98:1521:orcl";

	/** Oracle数据库连接驱动 */
	private final static String DB_DRIVER = "oracle.jdbc.driver.OracleDriver";

	/** 数据库用户名 */
	private final static String DB_USERNAME = "wrmis";

	/** 数据库密码 */
	private final static String DB_PASSWORD = "wrmis";
	private static final long serialVersionUID = 1L;
	private JPanel contentPane;
	private JTextField dbUrl;
	private JTextField dbDriver;
	private JTextField dbUser;
	private JTextField dbPwd;
	private JTextField tableName;
	private JTextField pagePath;
	private JTextField svcPath;
	private JTextField implPath;
	private JTextField domainName;
	private JTextArea  editorPane;
	/**
	 * Launch the application.
	 */
	public static void main(String[] args) {
		EventQueue.invokeLater(new Runnable() {
			public void run() {
				try {
					SubstanceLookAndFeel.setSkin(new CremeSkin());//substance skin
//					UIManager.setLookAndFeel(UIManager.getSystemLookAndFeelClassName()); //windows默认皮肤
					MainFrame frame = new MainFrame();
					frame.setVisible(true);
					frame.setResizable(false);
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		});
	}

	/**
	 * Create the frame.
	 */
	public MainFrame() {
		setTitle("JavaCodeGerneralTool author:zhanglei");
		setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		setBounds(100, 100, 480, 483);
		contentPane = new JPanel();
		contentPane.setBorder(new EmptyBorder(5, 5, 5, 5));
		setContentPane(contentPane);
		contentPane.setLayout(null);

		JLabel lblNewLabel = new JLabel(
				"\u6570\u636E\u5E93\u8FDE\u63A5URL\uFF1A");
		lblNewLabel.setBounds(10, 10, 93, 15);
		contentPane.add(lblNewLabel);

		dbUrl = new JTextField();
		dbUrl.setText(DB_URL);
		dbUrl.setBounds(119, 7, 261, 21);
		contentPane.add(dbUrl);
		dbUrl.setColumns(10);

		JButton btnNewButton = new JButton("\u6062\u590D");
		btnNewButton.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent arg0) {
				dbUrl.setText(DB_URL);
			}
		});
		btnNewButton.setBounds(390, 6, 72, 23);
		contentPane.add(btnNewButton);

		JLabel lblNewLabel_1 = new JLabel(
				"\u6570\u636E\u5E93\u8FDE\u63A5\u9A71\u52A8\uFF1A");
		lblNewLabel_1.setBounds(10, 41, 99, 15);
		contentPane.add(lblNewLabel_1);

		dbDriver = new JTextField();
		dbDriver.setText(DB_DRIVER);
		dbDriver.setBounds(119, 38, 261, 21);
		contentPane.add(dbDriver);
		dbDriver.setColumns(10);

		JButton btnNewButton_1 = new JButton("\u6062\u590D");
		btnNewButton_1.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent arg0) {
				dbDriver.setText(DB_DRIVER);
			}
		});
		btnNewButton_1.setBounds(390, 37, 72, 23);
		contentPane.add(btnNewButton_1);

		JLabel lblNewLabel_2 = new JLabel("\u7528\u6237\u540D\uFF1A");
		lblNewLabel_2.setBounds(10, 69, 54, 15);
		contentPane.add(lblNewLabel_2);

		dbUser = new JTextField();
		dbUser.setBounds(78, 66, 149, 21);
		contentPane.add(dbUser);
		dbUser.setText(DB_USERNAME);
		dbUser.setColumns(10);

		JLabel label = new JLabel("\u5BC6\u7801\uFF1A");
		label.setBounds(257, 69, 46, 15);
		contentPane.add(label);

		dbPwd = new JTextField();
		dbPwd.setText("wrmis");
		dbPwd.setBounds(313, 66, 149, 21);
		contentPane.add(dbPwd);
		dbPwd.setColumns(10);

		JLabel lblNewLabel_3 = new JLabel("\u8868\u540D\uFF1A");
		lblNewLabel_3.setBounds(10, 97, 54, 15);
		contentPane.add(lblNewLabel_3);

		tableName = new JTextField();
		tableName.setBounds(78, 94, 149, 21);
		contentPane.add(tableName);
		tableName.setColumns(10);

		JLabel lblNewLabel_4 = new JLabel("html\u548Cjs\u8DEF\u5F84\uFF1A");
		lblNewLabel_4.setBounds(10, 122, 93, 15);
		contentPane.add(lblNewLabel_4);

		pagePath = new JTextField();
		pagePath.setBounds(98, 119, 282, 21);
		contentPane.add(pagePath);
		pagePath.setColumns(10);

		JButton btnNewButton_2 = new JButton("\u9009\u62E9");
		btnNewButton_2.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent arg0) {
				choicePath(pagePath);
			}
		});
		btnNewButton_2.setBounds(390, 118, 72, 23);
		contentPane.add(btnNewButton_2);

		JLabel lblNewLabel_5 = new JLabel("svc\u63A5\u53E3\u8DEF\u5F84\uFF1A");
		lblNewLabel_5.setBounds(10, 147, 78, 15);
		contentPane.add(lblNewLabel_5);

		svcPath = new JTextField();
		svcPath.setBounds(98, 144, 282, 21);
		contentPane.add(svcPath);
		svcPath.setColumns(10);

		JButton btnNewButton_3 = new JButton("\u9009\u62E9");
		btnNewButton_3.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent arg0) {
				choicePath(svcPath);
			}
		});
		btnNewButton_3.setBounds(390, 143, 72, 23);
		contentPane.add(btnNewButton_3);

		JLabel lblNewLabel_6 = new JLabel("Impl\u5B9E\u73B0\u8DEF\u5F84\uFF1A");
		lblNewLabel_6.setBounds(10, 172, 93, 15);
		contentPane.add(lblNewLabel_6);

		implPath = new JTextField();
		implPath.setBounds(98, 169, 282, 21);
		contentPane.add(implPath);
		implPath.setColumns(10);

		JButton btnNewButton_4 = new JButton("\u9009\u62E9");
		btnNewButton_4.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent arg0) {
				choicePath(implPath);
			}
		});
		btnNewButton_4.setBounds(390, 168, 72, 23);
		contentPane.add(btnNewButton_4);

		JLabel lblNewLabel_7 = new JLabel("\u5BF9\u8C61\u540D\uFF1A");
		lblNewLabel_7.setBounds(250, 97, 54, 15);
		contentPane.add(lblNewLabel_7);

		domainName = new JTextField();
		domainName.setBounds(314, 94, 148, 21);
		contentPane.add(domainName);
		domainName.setColumns(10);
		domainName.addFocusListener(new FocusListener(){

			@Override
			public void focusGained(FocusEvent arg0) {
				// TODO Auto-generated method stub
				String tableNameS=tableName.getText();
				int index=0;
				if((index=tableNameS.indexOf("_"))>0){
					String [] s=tableNameS.split("_");
					String p=s[0];
					String name=s[1].toLowerCase();
					name=p+name.substring(0, 1).toUpperCase()+name.substring(1, name.length());
					domainName.setText(name);
				}
			}

			@Override
			public void focusLost(FocusEvent arg0) {
				// TODO Auto-generated method stub
				
			}});
		JButton btnNewButton_5 = new JButton("\u751F\u6210\u4EE3\u7801");
		btnNewButton_5.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent arg0) {
				GerneraCode tool=new GerneraCode(dbUrl.getText(),dbDriver.getText(),dbUser.getText(),dbPwd.getText(),tableName.getText(),domainName.getText(),pagePath.getText(),svcPath.getText(),implPath.getText(),editorPane);
				tool.begin();
			}
		});
		btnNewButton_5.setBounds(10, 199, 229, 23);
		contentPane.add(btnNewButton_5);

		editorPane = new JTextArea ();
		editorPane.setBounds(10, 232, 452, 207);
//		editorPane.setContentType("text/html");
		contentPane.add(editorPane);
		
		JButton btnNewButton_6 = new JButton("\u6D4B\u8BD5\u6570\u636E\u5E93\u8FDE\u63A5");
		btnNewButton_6.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				GerneraCode tool=new GerneraCode(dbUrl.getText(),dbDriver.getText(),dbUser.getText(),dbPwd.getText(),tableName.getText(),domainName.getText(),pagePath.getText(),svcPath.getText(),implPath.getText(),editorPane);
				tool.testConnection();
			}
		});
		btnNewButton_6.setBounds(250, 199, 212, 23);
		contentPane.add(btnNewButton_6);
	}

	public void choicePath(JTextField te) {
		String filePath = new File("").getAbsolutePath();
		if (filePath != null && filePath.length() > 0) {
			filePath = new java.io.File(filePath).getParent();
		}
		javax.swing.JFileChooser chooser = new javax.swing.JFileChooser(
				filePath);

		// 只是用于目录选择
		chooser.setFileSelectionMode(JFileChooser.DIRECTORIES_ONLY);

		int returnVal = chooser.showOpenDialog(this);
		if (returnVal == javax.swing.JFileChooser.APPROVE_OPTION) {
			te.setText(chooser.getSelectedFile().getAbsolutePath());
		}
	}
}
