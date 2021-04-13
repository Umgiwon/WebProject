package com.kh.jsp.common;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Date;

import com.oreilly.servlet.multipart.FileRenamePolicy;

public class MyRenamePolicy implements FileRenamePolicy {

	@Override
	public File rename(File oldFile) {
		// test.jpg --> 20210413_163801_000.jpg
		
		// 컴퓨터 시간 가져오기
		long curTime = System.currentTimeMillis();
		
		// yyyyMMdd_hhmmss
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd_HHmmss");
		
		// 같은 이름의 파일 생성을 방지하기 위한 난수
		int randomNumber = (int)(Math.random() * 10000);
		
		// test.jpg --> test / .jpg (확장자) 떼고 파일 이름만 바꾸기
		String name = oldFile.getName();
		String body = "";  // 파일 명
		String ext = "";   // 확장자
		
		int dot = name.lastIndexOf('.'); // test.jpg.zip
		
		if(dot != -1) {
			// 확장자가 있다면
			body = name.substring(0, dot);
			ext = name.substring(dot);
		} else {
			body = name;
		}
		
		// 파일 명 바꾸기
		String filename = sdf.format(new Date(curTime))
				          + "_" + randomNumber + ext;
		
		File newFile = new File(oldFile.getParentFile(), filename);
				
		return newFile;
	}

}
