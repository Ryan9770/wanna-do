package com.bs.wd.trade;

import java.util.List;
import java.util.Map;

public interface TradeService {
	
	// 게시글 기능
	public void insertTrade(Trade dto, String pathname) throws Exception;
	public List<Trade> listTrade(Map<String, Object> map);
	public int dataCount(Map<String, Object> map);
	public void updateHitCount(int num) throws Exception;
	public Trade readTrade(int num);
	public Trade preReadTrade(Map<String, Object> map);
	public Trade nextReadTrade(Map<String, Object> map);
	public void updateTrade(Trade dto, String pathname) throws Exception;
	public void deleteTrade(int num, String pathname) throws Exception;
	
	// 답글 기능 
	public void insertReply(Reply dto) throws Exception;
	public List<Reply> listReply(Map<String, Object> map);
	public int replyCount(Map<String, Object> map);
	public void deleteReply(Map<String, Object> map) throws Exception;
	
	public List<Reply> listReplyAnswer(int answer);
	public int replyAnswerCount(int answer);
	
	//좋아요 기능 
	public void insertTradeLike(Map<String, Object> map) throws Exception;
	public void deleteTradeLike(Map<String, Object> map) throws Exception;
	public int tradeLikeCount(int num);
	public boolean userTradeLiked(Map<String, Object> map);
	
	
}
