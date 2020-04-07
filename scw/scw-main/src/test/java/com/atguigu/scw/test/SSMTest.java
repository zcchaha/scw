package com.atguigu.scw.test;

import com.atguigu.scw.mapper.TAdminMapper;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

//1、使用Spring单元测试来驱动普通的测试方法
@RunWith(value= SpringJUnit4ClassRunner.class)
//2、加载Spring配置文件
@ContextConfiguration(locations={"classpath:spring/spring-bean.xml",
        "classpath:spring/spring-mybatis.xml","classpath:spring/spring-tx.xml"})
public class SSMTest {
    @Autowired
    TAdminMapper  tAdminMapper;
    @Test
    public void test(){
        long countByExample = tAdminMapper.countByExample(null);
        System.out.println("countByExample = " + countByExample);
    }
}
