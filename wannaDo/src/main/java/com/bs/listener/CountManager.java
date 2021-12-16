package com.bs.listener;

import java.util.Calendar;
import java.util.Timer;
import java.util.TimerTask;

import javax.servlet.ServletContext;
import javax.servlet.annotation.WebListener;
import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

// HttpSessionListener : 세션이 만들어지거나 소멸될때 발생하는 이벤트를 처리하는 리스너
@WebListener // 리스너 등록
public class CountManager implements HttpSessionListener{
	private static int currentCount;
	private static long toDayCount;
	private static long yesterDayCount;
	private static long totalCount;
	
	public CountManager() {
		// 자정이 되면 오늘 인원은 어제 인원이 되고 오늘인원은 0으로 변경
		TimerTask task = new TimerTask() {
			
			@Override
			public void run() {
				yesterDayCount = toDayCount;
				toDayCount = 0;
				
			}
		};
		
		Timer timer = new Timer();
		Calendar cal = Calendar.getInstance();
		cal.add(Calendar.DATE, 1);
		
		cal.set(Calendar.HOUR, 0);
		cal.set(Calendar.MINUTE, 0);
		cal.set(Calendar.SECOND, 0);
		cal.set(Calendar.MILLISECOND, 0);
		
		// 자정마다 1번 실행
		timer.schedule(task, cal.getTime(), 1000*60*60*24);
	}
	
	public static void init(long toDay, long yesterDay, long total) {
		toDayCount = toDay;
		yesterDayCount = yesterDay;
		totalCount = total;
	}
	
	@Override
	public void sessionCreated(HttpSessionEvent se) {
		// 세션이 만들어지는 시점에 호출
		HttpSession session = se.getSession();
		ServletContext context = session.getServletContext();
		
		
		synchronized (se) {
			currentCount++;
			toDayCount++;
			totalCount++;
			
			context.setAttribute("currentCount", currentCount);
			context.setAttribute("toDayCount", toDayCount);
			context.setAttribute("totalCount", totalCount);
			context.setAttribute("yesterDayCount", yesterDayCount);
		}	
	}

	@Override
	public void sessionDestroyed(HttpSessionEvent se) {
		// 세션이 소멸되는 시점에 호출
		HttpSession session = se.getSession();
		ServletContext context = session.getServletContext();
		
		synchronized (se) {
			currentCount--;
			if(currentCount < 0) {
				currentCount = 0;
			}
			
			context.setAttribute("currentCount", currentCount);
			context.setAttribute("toDayCount", toDayCount);
			context.setAttribute("totalCount", totalCount);
			context.setAttribute("yesterDayCount", yesterDayCount);
		}
	}

	public static int getCurrentCount() {
		return currentCount;
	}

	public static long getToDayCount() {
		return toDayCount;
	}

	public static long getYesterDayCount() {
		return yesterDayCount;
	}

	public static long getTotalCount() {
		return totalCount;
	}
	
	
}
