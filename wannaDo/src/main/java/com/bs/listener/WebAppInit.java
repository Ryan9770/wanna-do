package com.bs.listener;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.util.Properties;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;

// 주의사항 : 이클립스에서 servers 탭에서 마우스 우측을 누르고 stop을 해야
//			contextDestroyed() 메소드가 실행됨

//ServletContextListener : 웹 컨테이너가 실행되거나 종료될때 발생하는 이벤트 처리
@WebListener
public class WebAppInit implements ServletContextListener {
	private String pathname = "/WEB-INF/count.properties";
	
	
	@Override
	public void contextInitialized(ServletContextEvent sce) {
		// 서버가 시작되는 시점에 호출
		
		// 실제 파일 경로
		pathname = sce.getServletContext().getRealPath(pathname);
		
		loadFileCount();
		
		
	}

	@Override
	public void contextDestroyed(ServletContextEvent sce) {
		// 서버가 종료되는 시점에 호출
		saveFileCount();
	}
	
	private void saveFileCount() {
		// count.properties 파일에 접속자 수를 저장
		long toDay, yesterDay, total;
		FileOutputStream fos = null;
		Properties p = new Properties(); // properties는 맵과 유사, 파일처리가 쉬움
		
		try {
			toDay = CountManager.getToDayCount();
			yesterDay = CountManager.getYesterDayCount();
			total = CountManager.getTotalCount();
			
			p.setProperty("toDay", Long.toString(toDay));
			p.setProperty("yesterDay", Long.toString(yesterDay));
			p.setProperty("total", Long.toString(total));
			
			fos = new FileOutputStream(pathname);
			p.store(fos, "count");
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(fos!=null) {
				try {
					fos.close();
				} catch (Exception e2) {
				}
			}
		}
		
	}
	
	private void loadFileCount() {
		// count.properties 파일에 저장된 접속자수 읽어오기
		long toDay, yesterDay, total;
		FileInputStream fis = null;
		Properties p = null;
		
		try {
			File f = new File(pathname);
			if(!f.exists()) { // 파일 없으면 리턴
				return;
			}
			
			p = new Properties();
			fis = new FileInputStream(f);
			p.load(fis);
			
			toDay = Long.parseLong(p.getProperty("toDay"));
			yesterDay = Long.parseLong(p.getProperty("yesterDay"));
			total = Long.parseLong(p.getProperty("total"));
			
			CountManager.init(toDay, yesterDay, total);
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(fis!=null) {
				try {
					fis.close();
				} catch (Exception e2) {
				}
			}
		}
	}
}
