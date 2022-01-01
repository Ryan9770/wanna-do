package com.bs.wd.member;

import java.util.HashMap;
import java.util.Map;
import java.util.Random;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bs.wd.common.FileManager;
import com.bs.wd.common.dao.CommonDAO;

@Service("member.memberService")
public class MemberServiceImpl implements MemberService {
	@Autowired
	private CommonDAO dao;
	@Autowired
	private FileManager fileManager;
	
	@Override
	public Member loginMember(String userId) {
		Member dto = null;

		try {
			dto = dao.selectOne("member.loginMember", userId);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return dto;
	}

	@Override
	public void insertMember(Member dto) throws Exception {
		try {
			if (dto.getEmail1().length() != 0 && dto.getEmail2().length() != 0) {
				dto.setEmail(dto.getEmail1() + "@" + dto.getEmail2());
			}

			if (dto.getTel1().length() != 0 && dto.getTel2().length() != 0 && dto.getTel3().length() != 0) {
				dto.setTel(dto.getTel1() + "-" + dto.getTel2() + "-" + dto.getTel3());
			}

			long memberSeq = dao.selectOne("member.memberSeq");
			dto.setMemberIdx(memberSeq);

			// 회원정보 저장
			dao.insertData("member.insertMember", memberSeq);

			// dao.insertData("member.insertMember1", dto);
			// dao.insertData("member.insertMember2", dto);
			dao.updateData("member.insertMember12", dto); // member1, member2 테이블 동시에
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public Member readMember(String userId) {
		Member dto = null;

		try {
			dto = dao.selectOne("member.readMember", userId);
			
			int membership = dao.selectOne("member.membershipNo",dto.getUserId());

			if(membership >= 22 && membership <51) {
				dto = null;
				dto = dao.selectOne("member.readCreatorMember", userId);
			} else {
				membership =0 ;
			}
			
			if (dto != null) {
				if (dto.getEmail() != null) {
					String[] s = dto.getEmail().split("@");
					dto.setEmail1(s[0]);
					dto.setEmail2(s[1]);
				}

				if (dto.getTel() != null) {
					String[] s = dto.getTel().split("-");
					dto.setTel1(s[0]);
					dto.setTel2(s[1]);
					dto.setTel3(s[2]);
				}
				
				if(dto.getCreatorEmail() != null) {
					String[] s = dto.getCreatorEmail().split("@");
					dto.setCreatorEmail1(s[0]);
					dto.setCreatorEmail2(s[1]);
				}
				
				if(dto.getCreatorTel()!=null) {
					String[] s = dto.getCreatorTel().split("-");
					dto.setCreatorTel1(s[0]);
					dto.setCreatorTel2(s[1]);
					dto.setCreatorTel3(s[2]);
				}
				
				if(dto.getCreator_reg_date()!=null) {
					String[] s = dto.getCreator_reg_date().split("-");
					dto.setCreator_reg_date(s[0]+"년 "+s[1]+"월 "+s[2]+"일");
				}
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return dto;
	}

	@Override
	public Member readMemberByName(String userName) {
		Member dto = null;

		try {
			dto = dao.selectOne("member.readMemberByName", userName);

		} catch (Exception e) {
			e.printStackTrace();
		}

		return dto;
	}
	
	@Override
	public Member readMemberByCreatorName(String creatorName) {
		Member dto = null;

		try {
			dto = dao.selectOne("member.readMemberByCreatorName", creatorName);

		} catch (Exception e) {
			e.printStackTrace();
		}

		return dto;
	}

	@Override
	public Member readMember(long memberIdx) {
		Member dto = null;

		try {
			dto = dao.selectOne("member.readMember2", memberIdx);

			if (dto != null) {
				if (dto.getEmail() != null) {
					String[] s = dto.getEmail().split("@");
					dto.setEmail1(s[0]);
					dto.setEmail2(s[1]);
				}

				if (dto.getTel() != null) {
					String[] s = dto.getTel().split("-");
					dto.setTel1(s[0]);
					dto.setTel2(s[1]);
					dto.setTel3(s[2]);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return dto;
	}

	@Override
	public void updateMembership(Map<String, Object> map) throws Exception {
		try {
			dao.updateData("member.updateMembership", map);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public void updateLastLogin(String userId) throws Exception {
		try {
			dao.updateData("member.updateLastLogin", userId);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public void updateMember(Member dto, String pathname) throws Exception {
		try {
			if (dto.getEmail1().length() != 0 && dto.getEmail2().length() != 0) {
				dto.setEmail(dto.getEmail1() + "@" + dto.getEmail2());
			}

			if (dto.getTel1().length() != 0 && dto.getTel2().length() != 0 && dto.getTel3().length() != 0) {
				dto.setTel(dto.getTel1() + "-" + dto.getTel2() + "-" + dto.getTel3());
			}
			
			dao.updateData("member.updateMember1", dto);
			dao.updateData("member.updateMember2", dto);
			
			String saveFilename = fileManager.doFileUpload(dto.getSelectFile(), pathname);
			if(saveFilename != null) {
				dto.setImageFilename(saveFilename);
			}
			
			int membership = dao.selectOne("member.membershipNo",dto.getUserId());

			if(membership >= 22 && membership <51) {
				if (dto.getCreatorTel1().length()!=0 && dto.getCreatorTel2().length()!=0 && dto.getCreatorTel3().length()!=0) {
					dto.setCreatorTel(dto.getCreatorTel1()+"-"+dto.getCreatorTel2()+"-"+dto.getCreatorTel3());
				}
				
				if(dto.getCreatorEmail1().length()!=0 && dto.getCreatorEmail2().length()!=0) {
					dto.setCreatorEmail(dto.getCreatorEmail1()+"@"+dto.getCreatorEmail2());
				}

				dao.updateData("member.updateCreatorInfo", dto);
			} 
			
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public void updateMember(Member dto) throws Exception {
		try {
			// 비밀번호 수정
			dao.updateData("member.updateMember3", dto);
			
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	
	@Override
	public void deleteMember(Map<String, Object> map) throws Exception {
		try {
			map.put("membership", 0);
			updateMembership(map);

			dao.deleteData("member.deleteMember2", map);
			dao.deleteData("member.deleteMember1", map);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public void generatePwd(Member dto) throws Exception {
		StringBuilder sb = new StringBuilder();
		Random rd = new Random();
		String s = "~!@#$%^&*+-ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789abcdefghijklmnopqrstuvwxyz";
		
		for(int i = 0 ; i<10 ; i++) {
			int n = rd.nextInt(s.length());
			sb.append(s.substring(n, n+1));
		}
		
		/* 메일 전송
		String result ;
		result = dto.getUserId() +"님의 새로 발급된 임시 패스워드는"+"<b>" +sb.toString() +"</b> 입니다.<br>"
				+ "로그인 후 반드시 패스워드를 변경하시기 바랍니다.";
		
 		Mail mail = new Mail();
		mail.setReceiverEmail(dto.getEmail());
		
		mail.setSenderEmail("보내는사람이메일@도메인"); // 환경설정 된 이메일
		mail.setSenderName("관리자");
		mail.setSubject("임시 패스워드 발급");
		mail.setContent(result);
		
		boolean b = mailSender.mailSend(mail);
		
		if(b) {
			dto.setUserPwd(sb.toString());
			updateMember(dto); // 회원 정보 수정 (바뀐 랜덤 비밀번호로 정보 수정)
		} else {
			throw new Exception("이메일 전송 중 오류가 발생했습니다.");
		}
		*/
		
		dto.setUserPwd(sb.toString());
		updateMember(dto);
	}

	@Override
	public void insertCreator(Member dto, String pathname) throws Exception {
		try {
			String saveFilename = fileManager.doFileUpload(dto.getSelectFile(), pathname);
			if(saveFilename != null) {
				dto.setImageFilename(saveFilename);
			}
			
			if (dto.getCreatorEmail1().length() != 0 && dto.getCreatorEmail2().length() != 0) {
				dto.setCreatorEmail(dto.getCreatorEmail1() + "@" + dto.getCreatorEmail2());
			}

			if (dto.getCreatorTel1().length() != 0 && dto.getCreatorTel2().length() != 0 && dto.getCreatorTel3().length() != 0) {
				dto.setCreatorTel(dto.getCreatorTel1() + "-" + dto.getCreatorTel2() + "-" + dto.getCreatorTel3());
			}

			long creatorSeq = dao.selectOne("member.creatorSeq");
			dto.setCreatorIdx(creatorSeq);

			// 정보 저장
			dao.insertData("member.insertCreator", dto);
			
			long memberIdx = dao.selectOne("member.memberIdx",dto.getUserId());
			
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("membership", 22);			
			map.put("memberIdx", memberIdx);
			
			updateMembership(map);
			
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public String readCreatorDate(String userId) {
		String day = "";
		try {
			day = dao.selectOne("member.readCreatorRegdate", userId);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return day;
	}
}
