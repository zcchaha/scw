package com.atguigu.scw.service.impl;

import com.atguigu.scw.bean.TMenu;
import com.atguigu.scw.bean.TMenuExample;
import com.atguigu.scw.mapper.TMenuMapper;
import com.atguigu.scw.service.MenuService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class MenuServiceImpl implements MenuService {
    @Autowired
    TMenuMapper tMenuMapper;

    @Override
    public List<TMenu> getPMenus() {
        //查询所有菜单
        List<TMenu> tMenus = tMenuMapper.selectByExample(null);
        //挑选出父菜单集合:当一个菜单的pid=0 它就是父菜单
        Map<Integer,TMenu> pmenus = new HashMap<Integer, TMenu>();
        for (TMenu tMenu : tMenus) {
            if (tMenu.getPid() == 0){
                //父菜单的id作为建， 父菜单对象作为value
                pmenus.put(tMenu.getId(),tMenu);
            }
        }
        //将子菜单设置到自己的父菜单的  children集合中
        //遍历所有的菜单，如果菜单的pid!=0 && pid 等于  pmenus集合中的一个menu的id时
        for (TMenu tMenu : tMenus) {
            //查找正在遍历的子菜单的父菜单对象
            //使用子菜单的pid去查找父标签
            TMenu tMenu1 = pmenus.get(tMenu.getPid());
            if (tMenu.getPid() != 0 && tMenu1 != null){
                //将 子菜单设置给自己的父菜单
                tMenu1.getChildren().add(tMenu);
            }
        }
//返回封装完毕的父菜单
        return new ArrayList<TMenu>(pmenus.values());
    }

    @Override
    public void delMenu(Integer id) {
        tMenuMapper.deleteByPrimaryKey(id);
    }

    @Override
    public void addMenu(TMenu tMenu) {
        tMenuMapper.insertSelective(tMenu);
    }

    @Override
    public TMenu getMenu(Integer id) {
        return tMenuMapper.selectByPrimaryKey(id);
    }

    @Override
    public void updateMenu(TMenu tMenu) {
        tMenuMapper.updateByPrimaryKeySelective(tMenu);
    }
}
