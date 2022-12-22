package com.tech.blog.helper;

import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;

public class ImageHelper {
	public static boolean deleteFile(String path) {
		boolean result=false;
		try {
			File file=new File(path);
			result=file.delete();
			
		}catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
	public static boolean saveFile(InputStream is, String path) {
		boolean result=false;
		try {
			byte b[]=new byte[is.available()];
			is.read(b);
			
			// write file to path
			FileOutputStream fos=new FileOutputStream(path);
			fos.write(b);
			fos.close();
			result=true;	
		}catch(Exception e) {
			e.printStackTrace();
		}
		return result;
	}
}

