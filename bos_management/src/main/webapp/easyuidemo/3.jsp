<%@page contentType="text/html" %>
<%@page pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>树形菜单</title>
    <script type="text/javascript" src="../js/jquery-1.8.3.js"></script>
    <script type="text/javascript" src="../js/easyui/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="../js/easyui/locale/easyui-lang-zh_CN.js"></script>
    <link rel="stylesheet" href="../js/easyui/themes/default/easyui.css"/>
    <link rel="stylesheet" href="../js/easyui/themes/icon.css"/>
    <!-- 引入ztree -->
    <script src="../js/ztree/jquery.ztree.all.js" type="text/javascript" charset="utf-8"></script>
    <link rel="stylesheet" type="text/css" href="../js/ztree/zTreeStyle.css"/>
    <script type="text/javascript">
        // 页面加载后执行
        $(function () {
            // 1、 进行ztree菜单设置
            var setting = {
                data: {
                    simpleData: {
                        enable: true // 支持简单json数据格式
                    }
                },
                callback: {
                    onClick: function (event, treeId, treeNode, clickFlag) {
                        var content = '<div style="width:100%;height:100%;overflow:hidden;">'
                            + '<iframe src="'
                            + treeNode.page
                            + '" scrolling="auto" style="width:100%;height:100%;border:0;" ></iframe></div>';

                        //没有树形菜单,不打开选项卡
                        if (treeNode.page != undefined && treeNode.page != "") {
                            // 如果选项卡已经打开，选中
                            if ($("#mytabs").tabs('exists', treeNode.name)) {
                                // 选中选项卡
                                $("#mytabs").tabs('select', treeNode.name);
                            } else {
                                // 如果没有打开，添加选项卡
                                $("#mytabs").tabs('add', {
                                    title: treeNode.name,
                                    content: content,
                                    closable: true
                                });
                            }
                        }
                    }
                }
            };

            // 2、提供ztree树形菜单数据
            var zNodes = [
                {id: 1, pId: 0, name: "父节点一"},
                {id: 2, pId: 0, name: "父节点二"},
                {id: 11, pId: 1, name: "子节点一"},
                {id: 12, pId: 1, name: "子节点二"},
                {id: 13, pId: 2, name: "360", page: "http://www.360.com"},
                {id: 14, pId: 2, name: "百度", page: "http://www.baidu.com"}
            ];

            // 3、生成菜单
            $.fn.zTree.init($("#baseMenu"), setting, zNodes);

            //对选项卡注册 右键点击事件
            $("#mytabs").tabs({
                onContextMenu: function (e, title, index) {
                    // 阻止默认菜单显示
                    e.preventDefault();
                    // 显示自定义右键菜单
                    $("#mm").menu('show', {
                        left: e.pageX,
                        top: e.pageY
                    });
                }
            });
        });
    </script>
</head>
<body class="easyui-layout">
<div data-options="region:'north',title:''" style="height: 100px;">北部区域</div>
<div data-options="region:'west',title:'菜单导航'" style="width: 250px;">
    <!--折叠面板 -->
    <div class="easyui-accordion" data-options="fit:true">
        <div data-options="title:'基础菜单'">
            <!-- 通过ztree 插件，制作树菜单 -->
            <ul id="baseMenu" class="ztree"></ul>
        </div>
        <div data-options="title:'系统菜单'">面板二</div>
    </div>
</div>
<div data-options="region:'center'">
    <!-- 选项卡面板-->
    <div id="mytabs" class="easyui-tabs" data-options="fit:true">
        <div data-options="title:'选项卡面板一',closable:true">选项卡面板一</div>
        <div data-options="title:'选项卡面板二'">选项卡面板二</div>
    </div>
</div>
<div data-options="region:'east'" style="width: 200px;">东部区域</div>
<div data-options="region:'south'" style="height: 80px;">南部区域</div>

<!--右键点击的菜单-->
<div id="mm" class="easyui-menu" style="width: 150px;">
    <div>关闭窗口</div>
    <div>关闭其他窗口</div>
    <!--分割线-->
    <div class="menu-sep"></div>
    <div data-options="iconCls:'icon-cancel'">关闭全部窗口</div>
</div>
</body>
</html>