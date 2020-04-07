<%--
  Created by IntelliJ IDEA.
  User: ZCC
  Date: 2020/3/9
  Time: 17:24
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

    <%@ include file="/WEB-INF/pages/comman/base_css.jsp"%>
    <style>
        .tree li {
            list-style-type: none;
            cursor:pointer;
        }
        table tbody tr:nth-child(odd){background:#F4F4F4;}
        table tbody td:nth-child(even){color:#C00;}
    </style>
</head>

<body>

<nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
    <div class="container-fluid">
        <div class="navbar-header">
            <div><a class="navbar-brand" style="font-size:32px;" href="#">众筹平台 - 角色维护</a></div>
        </div>
        <%@include file="/WEB-INF/pages/comman/base_loginbar.jsp"%>
    </div>
</nav>

<div class="container-fluid">
    <div class="row">
        <div class="col-sm-3 col-md-2 sidebar">
            <%@include file="/WEB-INF/pages/comman/base_left.jsp"%>
        </div>
        <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <h3 class="panel-title"><i class="glyphicon glyphicon-th"></i> 数据列表</h3>
                </div>
                <div class="panel-body">
                    <form class="form-inline" role="form" style="float:left;">
                        <div class="form-group has-feedback">
                            <div class="input-group">
                                <div class="input-group-addon">查询条件</div>
                                <input id="queryRolesInp" class="form-control has-success" type="text" placeholder="请输入查询条件">
                            </div>
                        </div>
                        <button type="button" id="queryRolesBtn" class="btn btn-warning"><i class="glyphicon glyphicon-search"></i> 查询</button>
                    </form>
                    <button type="button" id="batchDelRolesBtn" class="btn btn-danger" style="float:right;margin-left:10px;"><i class=" glyphicon glyphicon-remove"></i> 删除</button>
                    <button type="button" class="btn btn-primary" style="float:right;" onclick="showAddMoudal();"><i class="glyphicon glyphicon-plus"></i> 新增</button>
                    <br>
                    <hr style="clear:both;">
                    <div class="table-responsive">
                        <table class="table  table-bordered">
                            <thead>
                            <tr >
                                <th width="30">#</th>
                                <th width="30"><input type="checkbox"></th>
                                <th>名称</th>
                                <th width="100">操作</th>
                            </tr>
                            </thead>
                            <tbody>


                            </tbody>
                            <tfoot>
                            <tr >
                                <td colspan="6" align="center">
                                    <ul class="pagination">

                                    </ul>
                                </td>
                            </tr>

                            </tfoot>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>






<%--添加弹出框--%>
<div class="modal fade" id="addRoleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="exampleModalLabel">添加角色</h4>
            </div>
            <div class="modal-body">
                <form>
                    <div class="form-group">
                        <label class="control-label">角色名:</label>
                        <input type="text" class="form-control" name="name">
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button id="addRoleBtn" type="button" class="btn btn-primary">添加</button>
            </div>
        </div>
    </div>
</div>
<%--修改弹出框--%>
<div class="modal fade" id="updateRoleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">修改角色</h4>
            </div>
            <div class="modal-body">
                <form>
                    <input type="hidden" name="id"/>
                    <div class="form-group">
                        <label class="control-label">角色名:</label>
                        <input type="text" class="form-control" name="name">
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                <button id="updateRoleBtn" type="button" class="btn btn-primary">修改</button>
            </div>
        </div>
    </div>
</div>

<%--权限分配模态框--%>
<div class="modal fade" id="assignPermissionModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">修改角色</h4>
            </div>
            <div class="modal-body">
                <%--ztree容器--%>
                <ul class="ztree" id="permissionTree"></ul>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                <button id="assignPermissionBtn" type="button" class="btn btn-primary">修改</button>
            </div>
        </div>
    </div>
</div>

<%@ include file="/WEB-INF/pages/comman/base_js.jsp"%>
<script type="text/javascript">
    //==========================权限分配开始===============
    var rid;
    var $ztreeObj;
    //权限分配模态框的提交按钮
    $("#assignPermissionBtn").click(function () {
        //获取所有被选中的权限对象的id集合
        //使用ztree树对象 可以获取树种已经勾选的 节点对象集合
        var $checkedNodes = $ztreeObj.getCheckedNodes(true);
        console.log($checkedNodes);
        var pidsArr = new Array();
        $.each($checkedNodes,function () {
            pidsArr.push(this.id);
        });
        var pidsStr = pidsArr.join();
        //获取要分配权限的角色id
        //发送异步分配权限的请求
        $.ajax({
            type:"POST",
            url:"${path}/role/assignPermissions",
            data:{"roleid":rid , "permissionids":pidsStr},
            success: function (res) {
                if(res=="ok"){
                    layer.msg("权限分配成功");
                    //关闭模态框
                    $("#assignPermissionModal").modal("hide");
                }
            }
        });
    });



    function assignRole(roleid) {
        rid = roleid;
        var setting = {
            check: {
                enable: true
            },
            data: {
                key: {
                    name: "title"
                },
                simpleData: {
                    enable: true,
                    pIdKey: "pid",
                }
            },
            view: {
                addDiyDom: function (treeId,treeNode) {
                    $("#"+treeNode.tId+"_ico").remove();
                    $("#"+treeNode.tId+"_span").before("<span class='"+treeNode.icon+"'></span>");
                }
            }
        };
        var zNodes;
        $.ajax({
            type: "GET",
            url: "${path}/role/getPermissions",
            success: function (permissions) {
                console.log(permissions);
                //遍历 给每一个权限json对象都添加一个checked=true的属性，显示时会默认勾选
                /*$.each(zNodes , function () {
                    this.checked = true;
                })*/
                //再次请求 ：获取当前角色已经分配的权限列表
                //查询roleid  当前角色已经拥有的权限id集合  设置为默认勾选
                $.ajax({
                    type:"GET",
                    url:"${path}/role/getAssignedPermissionIds",
                    data:{"roleid":roleid},
                    success: function (assignedPermissionIds) {//1,2,3,4
                        //遍历权限集合
                        $.each(permissions , function () {
                            // this代表正在遍历的permissions中的一个元素
                            //this.id;//如果查询到已分配的权限id集合中存在这个id，那么该权限 就是已分配的权限  应该设置默认选中
                            if(assignedPermissionIds.indexOf(this.id)>-1){
                                this.checked = true;
                            };
                        })
                        zNodes = permissions;
                        $ztreeObj = $.fn.zTree.init($("#permissionTree"), setting, zNodes);
                        $ztreeObj.expandAll(true);
                        //显示模态框
                        $("#assignPermissionModal").modal("toggle");
                    }
                });


            }
        });

    }


    //==========================权限分配结束===============


    var pages;


    //批量删除
    //全选全不选的效果
    $("table thead :checkbox").click(function () {
        //设置tbody内所有的子复选框选中状态和自己一致
        $("table tbody :checkbox").prop("checked" , this.checked );
    });
    $("table tbody").delegate(":checkbox" , "click" , function () {
        $("table thead :checkbox").prop("checked",$("table tbody :checkbox").length == $("table tbody :checkbox:checked").length) ;
    })
    $("#batchDelRolesBtn").click(function () {
        //检查页面中选中要删除角色的数量，如果<=0不许提交
        if($("table tbody :checkbox:checked").length==0){
            layer.alert("请选择要删除的角色");
            return;
        }
        //获取批量删除的参数  : ids=1,2,3,4   =>  List<Integer> ids
        var idsArr = new Array();
        $("table tbody :checkbox:checked").each(function(){
            idsArr.push($(this).attr("roleid"));
        });
        //将idsArr转为 ids的字符串  每两个元素使用,连接
        var idsStr = idsArr.join(",");//1,2,3,4
        $.ajax({
            type:"GET",
            url:"${path}/role/batchDelRoles",
            data:{"ids": idsStr},
            success: function (result) {
                if(result=="ok"){
                    layer.msg("批量删除成功");
                    //刷新当前页面
                    var currentPageNum = $("#currentPageNum").text();
                    var condition = $("#queryRolesInp").val();
                    initRoleTable(currentPageNum,condition);
                }
            }
        });
    });







    var pages;
    //删除角色的单击事件
    $("tbody").delegate(".delRoleBtn" , "click" , function () {
        var roleid = $(this).attr("roleid");
        layer.confirm("你确定删除吗?" , {title:"删除确认"} , function () {
            $.ajax({
                type:"get",
                url: "${path}/role/delRole",
                data:{"id":roleid},
                success:function (res) {
                    if(res=="ok"){
                        //关闭layer确认框
                        layer.closeAll();
                        layer.msg("删除成功");
                        //刷新当前页面
                        var currentPageNum = $("#currentPageNum").text();
                        var condition = $("#queryRolesInp").val();
                        initRoleTable(currentPageNum,condition);
                    }else if (res == "403") {
                        layer.msg("您无权删除");
                    }
                }
            })
        })
    });



    //Ajax修改角色
    //更新模态框的提交按钮的单击事件
    $("#updateRoleModal #updateRoleBtn").click(function () {
        $.ajax({
            type: "POST",
            url: "${path}/role/updateRole",
            data: $("#updateRoleModal form").serialize(),
            success: function (res) {
                if(res=="ok"){
                    //关闭更新模态框
                    $("#updateRoleModal").modal("hide");
                    layer.msg("更新成功");
                    //刷新当前页: 显示更新后的结果
                    var currentPageNum = $("#currentPageNum").text();
                    var condition = $("#queryRolesInp").val();
                    initRoleTable(currentPageNum,condition);
                }
            }
        });
    });
    //角色修改查询
    function showUpdateRoleModal(roleid){
        $.ajax({
            type:"GET",
            url:"${path}/role/getRole",
            data:{"id":roleid},
            success: function(role){
                //将角色信息显示到更新模态框中
                $("#updateRoleModal form input[name='id']").val(role.id);
                $("#updateRoleModal form input[name='name']").val(role.name);
                //弹出模态框
                $("#updateRoleModal").modal("show");

            }
        });
    }



    //Ajax添加角色
    function showAddMoudal() {
        $("#addRoleModal").modal('show');
    }
        $("#addRoleModal #addRoleBtn").click(function () {
            $.ajax({
                type:"POST",
                url:"${path}/role/addRole",
                data:$("#addRoleModal form").serialize(),
                success:function(msg) {
                    if (msg=="ok"){
                        $("#addRoleModal").modal('hide');
                        layer.msg("添加成功");
                        initRoleTable(pages+1);
                    }
            }
            });
    });









    //给带条件的分页查询按钮绑定单击事件
    $("#queryRolesBtn").click(function () {
        var condition = $("#queryRolesInp").val();
        initRoleTable(1,condition);
    });



    $(function () {
        $(".list-group-item").click(function(){
            if ( $(this).find("ul") ) {
                $(this).toggleClass("tree-closed");
                if ( $(this).hasClass("tree-closed") ) {
                    $("ul", this).hide("fast");
                } else {
                    $("ul", this).show("fast");
                }
            }
        });
    });

    $("tbody .btn-success").click(function(){
        window.location.href = "assignPermission.html";
    });
    //跳转到权限管理页面，
    // 权限管理父菜单所在的li标签的tree-closed class值，
    $("a:contains(' 角色维护')").parents(".tree-closed").removeClass("tree-closed");

    // 权限管理的子菜单列表 设置显示，;
    $("a:contains(' 角色维护')").parents("ul:hidden").show();

    // 设置user页面对应的菜单名称高亮显示
    $("ul li a:contains(' 角色维护')").css("color","red");



    //当前页面加载完成后，直接发起异步请求或取角色列表集合
    initRoleTable(1);
    //给页面初始化时生成的分页导航栏的  a标签绑定单击事件
    //由于异步请求的结果还没响应成功，ajax 成功处理函数中生成的标签  在此处不能直接使用
    //方案2、性能较差 使用动态委派   祖先元素.delegate("后代元素" ,"绑定事件的类型" , 事件处理函数);
$("tfoot").delegate(".navA","click",function () {
    // alert(this.href);
    var pageNum = $(this).attr("pageNum");
    var condition = $("#queryRolesInp").val();
    initRoleTable(pageNum,condition);
    return false;
});

function initRoleTable(pageNumber,condition) {
    $.ajax({
        type:"GET",
        url:"${path}/role/listRoles",
        data:{"pageNumber":pageNumber,"condition":condition},
        success:function (pageInfo) {
            $("table thead :checkbox").prop("checked",false);
            pages  = pageInfo.pages;
            // console.log(pageInfo);
            //遍历生成的集合，追加到tbody内
            initRolesTbody(pageInfo);
            //遍历生成分页导航栏
            initNavTfoot(pageInfo);


        }
    });
}

    function initNavTfoot(pageInfo) {
        $("tfoot ul").empty();
        // $("tfoot ul").text("");
        //上一页
        if (pageInfo.isFirstPage){
            $('<li class="disabled"><a href="javascript:void(0);">上一页</a></li>').appendTo("tfoot ul");
        } else {
            $('<li><a pageNum="'+(pageInfo.pageNum-1)+'" class="navA" href="${path}/role/listRoles?pageNumber='+(pageInfo.pageNum-1)+'">上一页</a></li>').appendTo("tfoot ul");
        }

        //中间页码
        $.each(pageInfo.navigatepageNums,function () {
            if (this==pageInfo.pageNum){
                $('<li class="active"><a href="javascript:void(0);"><span id="currentPageNum">'+ this +'</span>  <span class="sr-only">(current)</span></a></li>').appendTo("tfoot ul");
            } else {
                $('<li><a pageNum="'+this+'" class="navA" href="${path}/role/listRoles?pageNumber='+this+'">'+this+'</a></li>').appendTo("tfoot ul");
            }
        })

        //下一页
        if (pageInfo.isLastPage){
            $('<li class="disabled"><a href="javascript:void(0);">下一页</a></li>').appendTo("tfoot ul");
        } else {
            $('<li><a pageNum="'+(pageInfo.pageNum+1)+'" class="navA" href="${path}/role/listRoles?pageNumber='+(pageInfo.pageNum+1)+'">下一页</a></li>').appendTo("tfoot ul");
        }
       /* //给页面初始化时生成的分页导航栏的  a标签绑定单击事件
        //由于异步请求的结果还没响应成功，ajax 成功处理函数中生成的标签  在此处不能直接使用
        //解决：方案1、将使用了 异步生成标签的 代码写在 标签生成之后
        $("tfoot .navA").click(function () {
            alert(this.href);
            return false;
        });*/
    }
    
    function initRolesTbody(pageInfo) {
        $("table tbody").empty();
    // $("table tbody").text("");
        $.each(pageInfo.list,function (i) {
            $('<tr>\n' +
                '<td>'+(i+1)+'</td>' +
                '<td><input roleid="'+ this.id +'" type="checkbox"></td>' +
                '<td>'+this.name+'</td>' +
                '<td>' +
                '<button onclick="assignRole('+this.id+');" type="button" class="btn btn-success btn-xs"><i class=" glyphicon glyphicon-check"></i></button>' +
                '<button onclick="showUpdateRoleModal('+this.id+')" type="button" class="btn btn-primary btn-xs"><i class=" glyphicon glyphicon-pencil"></i></button>' +
                '<button roleid="'+this.id+'" type="button" class="btn btn-danger btn-xs delRoleBtn"><i class=" glyphicon glyphicon-remove"></i></button>' +
                '</td>' +
                '</tr>').appendTo("table tbody");
        })
    }
    
    /*
    {pageNum: 1, pageSize: 3, size: 3, startRow: 1, endRow: 3, total: 9, pages: 3,…}
pageNum: 1
pageSize: 3
size: 3
startRow: 1
endRow: 3
total: 9
pages: 3
list: [{id: 1, name: "PM - 项目经理"}, {id: 2, name: "SE - 软件工程师"}, {id: 3, name: "PG - 程序员"}]
prePage: 0
nextPage: 2
isFirstPage: true
isLastPage: false
hasPreviousPage: false
hasNextPage: true
navigatePages: 3
navigatepageNums: [1, 2, 3]
navigateFirstPage: 1
navigateLastPage: 3
lastPage: 3
firstPage: 1
     */
</script>
</body>
</html>

