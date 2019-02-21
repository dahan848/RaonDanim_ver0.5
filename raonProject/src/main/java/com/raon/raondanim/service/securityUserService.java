package com.raon.raondanim.service;

public interface securityUserService {
    void countFailure(String username); //로그인 실패시 실패 카운트 증가 
    int checkFailureCount(String username); //로그인 시도하는 사용자의 로그인 실패 회수 체크
    void disabledUsername(String username); //사용자 계정 비활성화 
}
