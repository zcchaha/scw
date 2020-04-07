<%--
  Created by IntelliJ IDEA.
  User: ZCC
  Date: 2020/3/7
  Time: 19:59
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<div id="navbar" class="navbar-collapse collapse">
    <ul class="nav navbar-nav navbar-right">
        <li style="padding-top:8px;">
            <div class="btn-group">
                <button type="button" class="btn btn-default btn-success dropdown-toggle"
                        data-toggle="dropdown">
                    <i class="glyphicon glyphicon-user"></i><sec:authentication property="name"></sec:authentication><span class="caret"></span>
                </button>
                <ul class="dropdown-menu" role="menu">
                    <li><a href="#"><i class="glyphicon glyphicon-cog"></i> 个人设置</a></li>
                    <li><a href="#"><i class="glyphicon glyphicon-comment"></i> 消息</a></li>
                    <li class="divider"></li>
                    <li><a id="logoutA" href="#"><i class="glyphicon glyphicon-off"></i> 退出系统</a></li>
                </ul>
            </div>
        </li>
        <li style="margin-left:10px;padding-top:8px;">
            <sec:authorize access="hasAnyRole('PM - 项目经理')">
            <button type="button" class="btn btn-default btn-danger">
                <span class="glyphicon glyphicon-question-sign"></span> 项目经理帮助
            </button>
            </sec:authorize>
            <sec:authorize access="hasAnyAuthority('ROLE_PG - 程序员')">
            <button type="button" class="btn btn-default btn-danger">
                <span class="glyphicon glyphicon-question-sign"></span> 程序猿帮助
            </button>
            </sec:authorize>
            <sec:authorize access="hasAnyRole('SE - 软件工程师')">
            <button type="button" class="btn btn-default btn-danger">
                <span class="glyphicon glyphicon-question-sign"></span> 软件工程师帮助
            </button>
            </sec:authorize>
            <sec:authorize access="hasAnyRole('CMO / CMS - 配置管理')">
            <button type="button" class="btn btn-default btn-danger">
                <span class="glyphicon glyphicon-question-sign"></span> 配置管理帮助
            </button>
            </sec:authorize>
        </li>
    </ul>
    <form class="navbar-form navbar-right">
        <input type="text" class="form-control" placeholder="查询">
    </form>
</div>

<%--
<%@include file="/WEB-INF/pages/comman/base_loginbar.jsp"%>
--%>
