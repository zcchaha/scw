package com.atguigu.scw.service;

import com.atguigu.scw.bean.TMenu;

import java.util.List;

public interface MenuService {
    List<TMenu> getPMenus();

    void delMenu(Integer id);

    void addMenu(TMenu tMenu);

    TMenu getMenu(Integer id);

    void updateMenu(TMenu tMenu);
}
