package com.raon.raondanim.dao;

import java.util.List;
import java.util.Map;

public interface WithReplyDao {
	
	public List<Map<String, Object>> selectAll();
	
	public int insertReply(Map<String, Object> param);
	public int updateReply(Map<String, Object> param);
	public int deleteReply(int num);
	
	//REPLY_NUM 으로  select
	public Map<String, Object> selectOne(int num);
	//USER_NUM 으로 select
	public Map<String, Object> selectByUserNum(int num);
	//WITH_NUM 으로  select
	public List<Map<String, Object>> selectByWithNum(int num);
	
	//페이징
	public List<Map<String, Object>> replyList(Map<String, Object> param);
	public int selectTotalCount();	
}
