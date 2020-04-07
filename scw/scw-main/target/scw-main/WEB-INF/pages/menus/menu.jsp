<%--
  Created by IntelliJ IDEA.
  User: xugang2
  Date: 2020/3/10
  Time: 14:10
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

    <%@ include file="/WEB-INF/pages/comman/base_css.jsp" %>

    <style>
        .tree li {
            list-style-type: none;
            cursor:pointer;
        }
    </style>
</head>

<body>

<nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
    <div class="container-fluid">
        <div class="navbar-header">
            <div><a class="navbar-brand" style="font-size:32px;" href="#">众筹平台 - 许可维护</a></div>
        </div>
        <%@ include file="/WEB-INF/pages/comman/base_loginbar.jsp" %>

    </div>
</nav>

<div class="container-fluid">
    <div class="row">
        <div class="col-sm-3 col-md-2 sidebar">
            <%@ include file="/WEB-INF/pages/comman/base_left.jsp" %>

        </div>
        <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">

            <div class="panel panel-default">
                <div class="panel-heading"><i class="glyphicon glyphicon-th-list"></i> 权限菜单列表 <div
                        style="float:right;cursor:pointer;" data-toggle="modal" data-target="#myModal"><i class="glyphicon
        glyphicon-question-sign"></i></div></div>
                <div class="panel-body">
                    <ul id="treeDemo" class="ztree"></ul>
                </div>
            </div>
        </div>
    </div>
</div>
<%--添加模态框--%>
<div class="modal fade" id="addMenuModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="exampleModalLabel">添加菜单</h4>
            </div>
            <div class="modal-body">
                <form>
                    <input type="hidden" name="pid">
                    <div class="form-group">
                        <label class="control-label">菜单名称</label>
                        <input type="text" class="form-control" name="name">
                    </div>
                    <div class="form-group">
                        <label class="control-label">菜单图标</label>
                        <input type="text" class="form-control" name="icon">
                    </div>
                    <div class="form-group">
                        <label class="control-label">菜单地址</label>
                        <input type="text" class="form-control" name="url">
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button id="addMenuBtn" type="button" class="btn btn-primary">添加</button>
            </div>
        </div>
    </div>
</div>
<%--修改模态框--%>
<div class="modal fade" id="updateMenuModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">修改菜单</h4>
            </div>
            <div class="modal-body">
                <form>
                    <input type="hidden" name="id">
                    <div class="form-group">
                        <label class="control-label">菜单名称</label>
                        <input type="text" class="form-control" name="name">
                    </div>
                    <div class="form-group">
                        <label class="control-label">菜单图标</label>
                        <input type="text" class="form-control" name="icon">
                    </div>
                    <div class="form-group">
                        <label class="control-label">菜单地址</label>
                        <input type="text" class="form-control" name="url">
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button id="updateMenuBtn" type="button" class="btn btn-primary">修改</button>
            </div>
        </div>
    </div>
</div>
<%@ include file="/WEB-INF/pages/comman/base_js.jsp" %>
<script type="text/javascript">
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

    //在当前页面中使用ZTREE显示 ztree树步骤
    //1、在页面中引入ztree的样式和js文件
    //2、在页面中准备ztree显示ztree树的容器[ul标签，为了让标签有ztree的样式 必须指定标签的class值为 ztree]
    //3、指定ztree生成的配置
    var settings = {
        data: {
            simpleData: {
                enable: true,
                pIdKey: "pid",
            },
            key: {
                url: "dsfsdfsdfxUrl"
            }
        },
        view: {
            addDiyDom: function(treeId , treeNode){//ztree每遍历生成一个 li节点时会调用此方法
                //treeid:当前调用方法的节点所在的容器的id
                //treeNode: 调用此方法的节点对象
                //console.log(treeNode);//treeNode是根据 异步查询到的菜单集合生成的，又多了ztree添加的属性：tId: "treeDemo_2"
                $("#" + treeNode.tId + "_a").prop("target","");
                var tid = treeNode.tId;//获取当前li节点的id
                $("#"+tid+"_ico").remove();//获取当前节点显示图标的span标签移除
                $("#"+tid+"_span").before("<span class='"+treeNode.icon+"'></span>");//在显示标签名的左边添加显示  菜单自己的图标的标签
            },
            addHoverDom: function(treeId, treeNode){
                var aObj = $("#" + treeNode.tId + "_a"); // tId = permissionTree_1, ==> $("#permissionTree_1_a")
                if (treeNode.editNameFlag || $("#btnGroup"+treeNode.tId).length>0) return;
                var s = '<span id="btnGroup'+treeNode.tId+'">';
                if ( treeNode.level == 0 ) {
                    //根节点  只能添加
                    s += '<a onclick="addMenu('+treeNode.id+');" class="btn btn-info dropdown-toggle btn-xs" style="margin-left:10px;padding-top:0px;" href="javascript:;" >&nbsp;&nbsp;<i class="fa fa-fw fa-plus rbg "></i></a>';
                } else if ( treeNode.level == 1 ) {
                    //枝节点   修改 和 添加
                    //修改
                    s += '<a onclick="updateMenu('+treeNode.id+');" class="btn btn-info dropdown-toggle btn-xs" style="margin-left:10px;padding-top:0px;"  href="javascript:;" title="修改权限信息">&nbsp;&nbsp;<i class="fa fa-fw fa-edit rbg "></i></a>';
                    if (treeNode.children.length == 0) {
                        //枝节点没有子节点  可以删除
                        s += '<a onclick="delMenu('+treeNode.id+')" class="btn btn-info dropdown-toggle btn-xs" style="margin-left:10px;padding-top:0px;" href="javascript:;" >&nbsp;&nbsp;<i class="fa fa-fw fa-times rbg "></i></a>';
                    }
                    //添加
                    s += '<a onclick="addMenu('+treeNode.id+');"  class="btn btn-info dropdown-toggle btn-xs" style="margin-left:10px;padding-top:0px;" href="javascript:;" >&nbsp;&nbsp;<i class="fa fa-fw fa-plus rbg "></i></a>';
                } else if ( treeNode.level == 2 ) {//叶子节点
                    //修改
                    s += '<a onclick="updateMenu('+treeNode.id+');" class="btn btn-info dropdown-toggle btn-xs" style="margin-left:10px;padding-top:0px;"  href="javascript:;" title="修改权限信息">&nbsp;&nbsp;<i class="fa fa-fw fa-edit rbg "></i></a>';
                    //删除
                    s += '<a onclick="delMenu('+treeNode.id+')" class="btn btn-info dropdown-toggle btn-xs" style="margin-left:10px;padding-top:0px;" href="javascript:;">&nbsp;&nbsp;<i class="fa fa-fw fa-times rbg "></i></a>';
                }

                s += '</span>';
                aObj.after(s);
            },
            removeHoverDom:function(treeId , treeNode) {
                //当鼠标离开时 删除悬停时创建的按钮组
                $("#btnGroup"+treeNode.tId).remove();
            }
        }

    };
    //修改查询菜单
    function updateMenu(id) {
        $.get("${path}/menu/getMenu",{"id":id},function (menu) {
            $("#updateMenuModal form [name='id']").val(menu.id);
            $("#updateMenuModal form [name='name']").val(menu.name);
            $("#updateMenuModal form [name='icon']").val(menu.icon);
            $("#updateMenuModal form [name='url']").val(menu.url);
            $("#updateMenuModal").modal("show");
        });
    }
    //修改菜单
    $("#updateMenuBtn").click(function () {
        $.ajax({
            type:"POST",
            url:"${path}/menu/updateMenu",
            data:$("#updateMenuModal form").serialize(),
            success:function (result) {
                if (result=="ok"){
                    $("#updateMenuModal").modal("hide");
                    layer.msg("修改成功");
                    initMenuTree();
                }
            }
        });
    });


    //添加菜单
    function addMenu(id) {
        $("#addMenuModal form [name='pid']").val(id);
        $("#addMenuModal").modal("show");

    };
    //添加
    $("#addMenuBtn").click(function () {
        $.post("${path}/menu/addMenu",$("#addMenuModal form").serialize(),function (result) {
            if (result=="ok"){
                layer.msg("添加成功");
                $("#addMenuModal").modal("hide");
                initMenuTree();
                $("#addMenuModal form :text").val("");

            }
        });
    });


    //删除菜单的函数
    function delMenu(menuid) {
        $.ajax({
            type:"get",
            url:"${path}/menu/delMenu",
            data:{id:menuid},
            success: function(result) {
                if(result=="ok"){
                    layer.msg("删除成功");
                    //重新加载ztree树
                    initMenuTree();
                }
            }
        });
    }

    //4、异步请求获取要显示的数据集合
    var zNodes;
    initMenuTree();
    function initMenuTree(){
        $.ajax({
            type:"GET",
            url:"${path}/menu/getMenus",
            success: function(pMenus) {
                zNodes = pMenus;
                zNodes.push({"id":0,"name":"系统权限菜单" ,"icon":"glyphicon glyphicon-send"});
                //zNodes = [ {name:"系统权限菜单" , "children": pMenus} ];
                console.log(zNodes);
                //5、让ztree插件 按照settings配置 解析znodes数据 生成ztree树显示到 ztree容器中
                var $ztreeObj = $.fn.zTree.init($("#treeDemo"), settings, zNodes);
                //调用ztree树对象的方法 展开所有的节点
                $ztreeObj.expandAll(true);
            }
        });
    }







    // 权限管理父菜单所在的li标签的tree-closed class值，
    $("a:contains(' 菜单维护')").parents(".tree-closed").removeClass("tree-closed");
    // 权限管理的子菜单列表 设置显示，
    $("a:contains(' 菜单维护')").parents("ul:hidden").show();
    // 设置user页面对应的菜单名称高亮显示
    $("ul li a:contains(' 菜单维护')").css("color","red");
</script>
</body>
</html>

