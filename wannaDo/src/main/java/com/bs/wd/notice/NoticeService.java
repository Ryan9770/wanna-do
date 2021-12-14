package com.bs.wd.notice;

import java.util.List;
import java.util.Map;

public interface NoticeService {
	public int dataCount(Map<String, Object> map);
	public List<Notice> listNotice(Map<String, Object> map);
	public List<Notice> listNoticeTop();
	
	public void updateHitCount(int num) throws Exception;
	public Notice readNotice(int num);
	public Notice preReadNotice(Map<String, Object> map);
	public Notice nextReadNotice(Map<String, Object> map);
	
	public List<Notice> listFile(int num);
	public Notice readFile(int fileNum);
}
