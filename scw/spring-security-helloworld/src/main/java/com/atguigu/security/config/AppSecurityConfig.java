package com.atguigu.security.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.authentication.encoding.Md5PasswordEncoder;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.method.configuration.EnableGlobalMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.Md4PasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.access.AccessDeniedHandler;
import org.springframework.security.web.authentication.rememberme.JdbcTokenRepositoryImpl;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.sql.DataSource;
import java.io.IOException;

@Configuration  //除Controller Service Repository Compoment之外的另一个逐渐注解标签
@EnableWebSecurity  //启用sprigsecurity web 功能，可以进行权限控制
@EnableGlobalMethodSecurity(prePostEnabled = true)
public class AppSecurityConfig extends WebSecurityConfigurerAdapter {
    //springsecurity会对访问项目的所有请求进行检查
    //授权：指定访问的资源需要的权限
    @Autowired
    DataSource dataSource;
    @Override
    protected void configure(HttpSecurity http) throws Exception {
        //实验1、首页和静态资源放行
        //authorizeRequests()进行授权的方法
        //antMatchers("/映射地址")对指定的路径进行授权
        //.hasAnyAuthority("前面地址需要的权限")
        //.hasAnyRole("前面地址需要的角色")
        //permitAll()授权所有人都可以进行访问
        //.anyRequest()上面没有配置的其他的映射地址的授权管理
        //authenticated() :需要授权(只要用户登录成功 无论主体的权限是什么都可以访问anyRquest中的映射)
        http.authorizeRequests()
            .antMatchers("/index.jsp","/layui/**").permitAll()
                //5.自定义访问权限控制
//                .antMatchers("/level2/**").hasRole("ZCC")
//                .antMatchers("/level3/**").hasAnyAuthority("user:add","user:delete")
            .anyRequest().authenticated();

        //6.退出
        http.logout()
                .logoutUrl("/user-logout").logoutSuccessUrl("/index.jsp");


        //实验2：如果访问未授权的页面跳转到登录页面让用户登录
        //2.1 如果访问未授权页面 跳转到springsecurity提供的默认登录页面
        // http.formLogin()
        //2.2 如果访问为授权页面  跳转到自定义的登录页面 和表单自定义
        http.formLogin().loginPage("/index.jsp")
                .loginProcessingUrl("/login") //设置springsecurity 处理登录页面提交的登录请求的映射地址

                .usernameParameter("loginacct") //用来接收登录请求的name属性值
                .passwordParameter("userpswd")
                .defaultSuccessUrl("/main.html"); //登录成功的重定向地址
        //2.3 如果登录表单提交方式为get，不会报错，如果登录表单提交方式为post，则报错缺少_csrf参数
        //实验3：  自定义登录表单的登录逻辑：  get方式不会要求_csrf参数
        //如果访问页面失败跳转回登录页面  springsecurity会向域中设置失败消息在页面中可以获取：${SPRING_SECURITY_LAST_EXCEPTION.message}
        //get方式没有    post
        //登录请求提交时报错：No AuthenticationProvider  ，证明loginProcessingUrl("/login")配置正确，但是springsecurity没有合适的账号密码处理本次登录请求
        http.csrf().disable();//为了避免post提交登录请求报错
        //7.自定义异常处理
        http.exceptionHandling()
                //7.1
//                .accessDeniedPage("/unauthed");
                //7.2
                .accessDeniedHandler(new AccessDeniedHandler() {
            @Override
            public void handle(HttpServletRequest request, HttpServletResponse response, AccessDeniedException accessDeniedException) throws IOException, ServletException {
                //获取异常信息
                String msg = accessDeniedException.getMessage();
                //将异常存在request域中
                request.setAttribute("errorMsg" , msg);
                //转发到异常页面
                request.getRequestDispatcher("/unauthed").forward(request,response);
            }
        });
        //实验8.1  记住我  cookie版  ： 服务器将cookie版记住我主体信息存在application域中，当服务器重启会失效
        //以后浏览器提交的登录请求时 只要携带remeber-me  参数，springsecurity会自动保存主体
//        http.rememberMe();
        //实验8.2 记住我数据库版
        JdbcTokenRepositoryImpl jdbcTokenRepository = new JdbcTokenRepositoryImpl();
        jdbcTokenRepository.setDataSource(dataSource);
        http.rememberMe().tokenRepository(jdbcTokenRepository);

    }

    //认证：主题创建（登录 查询用户和他的权限信息）

    //用户详情查询服务组件的接口
    @Autowired
    UserDetailsService userDetailsService;
    @Override
    protected void configure(AuthenticationManagerBuilder auth) throws Exception {
        //实验4：自定义主体的创建[自定义认证用户信息]
        //如果登录时输入错误的账号密码报错：Bad credentials ，代表实验4成功
        //登录成功由于我们没有配置成功后的跳转页面  会报404
        //inMemoryAuthentication():在内存中写死主体信息
        //withUser("zhanglifang").password("123456") 创建一个主体，登录时springsecurity会自动使用主体信息和登录信息进行判断
        /*auth.inMemoryAuthentication()
                .withUser("zcc").password("zcc").roles("ZCC")
                .and()
                .withUser("admin").password("admin").authorities("user:add","user:delete");*/


        //根据用户名查询出用户的详细信息  MD5加密
//        auth.userDetailsService(userDetailsService).passwordEncoder(new Md5PasswordEncoder());
        //BCryptPasswordEncoder加密
        auth.userDetailsService(userDetailsService).passwordEncoder(new BCryptPasswordEncoder());


    }
}
