package utils;

import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

public class LoadInfo {
	public void loadProperties(){
		Properties prop = new Properties(); 
        InputStream in = Object.class.getResourceAsStream("/test.properties"); 
        try { 
            prop.load(in); 
            prop.getProperty("initYears1").trim(); 
        } catch (Exception e) { 
            e.printStackTrace(); 
        } finally{
        	if(in!=null)
				try {
					in.close();
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
        }
	}
	
}
