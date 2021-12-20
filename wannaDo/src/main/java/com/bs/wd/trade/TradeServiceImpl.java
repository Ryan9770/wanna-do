package com.bs.wd.trade;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bs.wd.common.FileManager;
import com.bs.wd.common.dao.CommonDAO;

@Service("trade.tradeService")
public class TradeServiceImpl implements TradeService {

	@Autowired
	private CommonDAO dao;
	
	@Autowired
	private FileManager fileManager;
	
	@Override
	public void insertTrade(Trade dto, String pathname) throws Exception {
		try {
			
			String saveFilename = fileManager.doFileUpload(dto.getSelectFile(), pathname);
			if (saveFilename != null) {
				dto.setOriginalFilename(saveFilename);
			}
			dao.insertData("trade.insertTrade", dto);
		} catch (Exception e) {
			throw e;
		}
	}

	@Override
	public List<Trade> listTrade(Map<String, Object> map) {
		List<Trade> list = null;
		try {
			list = dao.selectList("trade.listTrade", map);
		} catch (Exception e) {
		}		
		return list;
	}

	@Override
	public int dataCount(Map<String, Object> map) {
		int result = 0;
		try {
			result = dao.selectOne("trade.dataCount", map);
		} catch (Exception e) {
		}
		return result;
	}
	
	
	@Override
	public void updateHitCount(int num) throws Exception{
		try {
			dao.updateData("trade.updateHitCount", num);
		} catch (Exception e) {
		}
	}
		
	@Override
	public Trade readTrade(int num) {
		Trade dto = null;
		
		try {
			dto = dao.selectOne("trade.readTrade", num);
		} catch (Exception e) {
		}
		
		return dto;
	}

	@Override
	public Trade preReadTrade(Map<String, Object> map) {
		Trade dto = null;
		try {
			dto = dao.selectOne("trade.preReadTrade", map);
		} catch (Exception e) {
		}
		
		return dto;
	}
	
	@Override
	public Trade nextReadTrade(Map<String, Object> map) {
		Trade dto = null;
		try {
			dto = dao.selectOne("trade.nextReadTrade", map);
		} catch (Exception e) {
		}
		
		return dto;
	}

	@Override
	public void updateTrade(Trade dto, String pathname) throws Exception {	
		try {
			String saveFilename = fileManager.doFileUpload(dto.getSelectFile(), pathname);
			if (saveFilename != null) {
				if(dto.getOriginalFilename().length() != 0) {
					fileManager.doFileDelete(dto.getOriginalFilename(), pathname);
				}
				
				dto.setOriginalFilename(saveFilename);
			}
			dao.updateData("trade.updateTrade", dto);	
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	
	}

	@Override
	public void deleteTrade(int num, String pathname) throws Exception {
		try {
			if(pathname != null) {
				fileManager.doFileDelete(pathname);
			}
			
			dao.deleteData("trade.deleteTrade", num);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public void insertReply(Reply dto) throws Exception {
		try {
			dao.insertData("trade.insertReply", dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}

	@Override
	public List<Reply> listReply(Map<String, Object> map) {
		List<Reply> list = null;
		
		try {
			list = dao.selectList("trade.listReply", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public int replyCount(Map<String, Object> map) {
		int result = 0;
		
		try {
			result = dao.selectOne("trade.replyCount", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public void deleteReply(Map<String, Object> map) throws Exception {
		try {
			dao.deleteData("trade.deleteReply", map);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public List<Reply> listReplyAnswer(int answer) {
		List<Reply> list = null;
		
		try {
			list = dao.selectList("trade.listReplyAnswer", answer);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public int replyAnswerCount(int answer) {
		int result = 0;
		
		try {
			result = dao.selectOne("trade.replyAnswerCount", answer);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
}
