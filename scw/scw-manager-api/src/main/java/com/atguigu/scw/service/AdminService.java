package com.atguigu.scw.service;

import com.atguigu.scw.bean.TAdmin;

import java.util.List;

public interface AdminService {
    TAdmin dologin(String loginacct, String userpswd);

    List<TAdmin> getAllAdmins(String condition);

    void addAdmin(TAdmin admin);

    void updateAdmin(TAdmin admin);

    TAdmin getAdmin(Integer id);

    void deleteAdmin(Integer id);

    void batchDelAdmins(List<Integer> ids);
}
