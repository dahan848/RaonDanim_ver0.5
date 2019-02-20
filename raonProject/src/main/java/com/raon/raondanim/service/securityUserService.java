package com.raon.raondanim.service;

public interface securityUserService {
    void countFailure(String username);
    int checkFailureCount(String username);
    void disabledUsername(String username);
}
