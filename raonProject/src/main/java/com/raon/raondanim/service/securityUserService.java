package com.raon.raondanim.service;


public interface securityUserService {
    void countFailure(String username); //濡쒓렇�씤 �떎�뙣�떆 �떎�뙣 移댁슫�듃 利앷� 
    int checkFailureCount(String username); //濡쒓렇�씤 �떆�룄�븯�뒗 �궗�슜�옄�쓽 濡쒓렇�씤 �떎�뙣 �쉶�닔 泥댄겕
    void disabledUsername(String username); //�궗�슜�옄 怨꾩젙 鍮꾪솢�꽦�솕 
    void updateFailureCountReset(String username); //濡쒓렇�씤 �꽦怨듭떆 濡쒓렇�씤 �떎�뙣 �쉶�닔 珥덇린�솕 : 0
    
    
}
