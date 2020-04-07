<%--
  Created by IntelliJ IDEA.
  User: ZCC
  Date: 2020/3/7
  Time: 19:59
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="tree">
    <ul style="padding-left:0px;" class="list-group">
        <c:choose>
            <c:when test="${empty pmenus}">
                <li class="list-group-item tree-closed" >
                    查询菜单失败
                </li>
            </c:when>
            <c:otherwise>
                <%--遍历显示父子菜单集合--%>
                <c:forEach items="${pmenus}" var="pmenu" >
                    <c:choose>
                        <c:when test="${empty pmenu.children}">
                            <li class="list-group-item tree-closed" >
                                <a href="${path}/${pmenu.url}"><i class="${pmenu.icon}"></i> ${pmenu.name}</a>
                            </li>
                        </c:when>
                        <c:otherwise>
                            <%--有子菜单集合--%>
                            <sec:authorize access="hasAnyRole('PM - 项目经理') or hasAnyRole('SE - 软件工程师')">
                            <li class="list-group-item tree-closed">
                                <span><i class="${pmenu.icon}"></i> ${pmenu.name} <span class="badge" style="float:right">${pmenu.children.size()}</span></span>
                                <ul style="margin-top:10px;display:none;">
                                    <c:forEach items="${pmenu.children}" var="child" >
                                        <li style="height:30px;">
                                            <a href="${path}/${child.url}"><i class="${child.icon}"></i> ${child.name}</a>
                                        </li>
                                    </c:forEach>
                                </ul>
                            </li>
                            </sec:authorize>
                        </c:otherwise>
                    </c:choose>
                </c:forEach>
            </c:otherwise>
        </c:choose>



    </ul>
</div>

<%--
<%@include file="/WEB-INF/pages/comman/base_left.jsp"%>
--%>