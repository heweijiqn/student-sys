(function($) {
    "use strict";

    $.fn.myAjaxTreeTable = function(options, param) {
        // 如果是调用方法
        if (typeof options == 'string') {
            return $.fn.myAjaxTreeTable.methods[options](this, param);
        }

        // 如果是初始化组件
        options = $.extend({}, $.fn.myAjaxTreeTable.defaults, options || {});
        // 是否有radio或checkbox
        var hasSelectItem = false;
        var target = $(this);
        // 在外层包装一下div，样式用的bootstrap-table的
        var _main_div = $("<div class='fixed-table-container'></div>");
        target.before(_main_div);
        _main_div.append(target);
        target.addClass("table table-hover treegrid-table table-bordered");
        if (options.striped) {
            target.addClass('table-striped');
        }
        // 工具条在外层包装一下div，样式用的bootstrap-table的
        if(options.toolbar){
            var _tool_div = $("<div class='fixed-table-toolbar' style='display:none;'></div>");
            var _tool_left_div = $("<div class='bs-bars pull-left'></div>");
            _tool_left_div.append($(options.toolbar));
            _tool_div.append(_tool_left_div);
            _main_div.before(_tool_div);
        }
        // 得到根节点
        target.getRootNodes = function(data) {
            // 指定Root节点值
            var _root = options.rootCodeValue?options.rootCodeValue:null
            var result = [];
            $.each(data, function(index, item) {
                // 这里兼容几种常见Root节点写法
                // 默认的几种判断
                var _defaultRootFlag = item[options.parentCode] == '0'
                    || item[options.parentCode] == 0
                    || item[options.parentCode] == null
                    || item[options.parentCode] == '';
                if (!item[options.parentCode] || (_root?(item[options.parentCode] == options.rootCodeValue):_defaultRootFlag)){
                    result.push(item);
                }
                // 添加一个默认属性，用来判断当前节点有没有被显示
                item.isShow = false;
            });
            return result;
        };
        var j = 0;
        // 递归获取子节点并且设置子节点
        target.getChildNodes = function(data, parentNode, parentIndex, tbody) {
            $.each(data, function(i, item) {
                if (item[options.parentCode] == parentNode[options.code]) {
                	console.log('options.code ===== ' + options.code);
                	console.log('options.code ===== ' + parentNode[options.code]);
                    var tr = $('<tr></tr>');
                    var nowParentIndex = (parentIndex + (j++) + 1);
                    tr.addClass('treegrid-' + nowParentIndex);
                    tr.addClass('treegrid-parent-' + parentIndex);
                    tr.addClass('unknow');
                    target.renderRow(tr,item);
                    item.isShow = true;
                    tbody.append(tr);
                    target.getChildNodes(data, item, nowParentIndex, tbody)
                }
            });
        };
        target.renderChildRows = function(data, parentNode, parentIndex, tbody){
        	$.each(data, function(i, item) {
                var tr = $('<tr></tr>');
                var nowParentIndex = parentIndex;
                tr.addClass('treegrid-' + nowParentIndex+i);
                tr.addClass('treegrid-parent-' + parentIndex);
                tr.addClass('unknow');
                target.renderRow(tr,item);
                item.isShow = true;
                tbody.after(tr);
            });
        };
        // 绘制行
        target.renderRow = function(tr,item){
            $.each(options.columns, function(index, column) {
                // 判断有没有选择列
                if(index==0&&column.field=='selectItem'){
                    hasSelectItem = true;
                    var td = $('<td style="text-align:center;width:36px"></td>');
                    if(column.radio){
                        var _ipt = $('<input name="select_item" type="radio" value="'+item[options.id]+'"></input>');
                        td.append(_ipt);
                    }
                    if(column.checkbox){
                        var _ipt = $('<input name="select_item" type="checkbox" value="'+item[options.id]+'"></input>');
                        td.append(_ipt);
                    }
                    tr.append(td);
                }else{
                    var td = $('<td mainid='+item[options.id]+' style="text-align:'+column.align+';'+((column.width)?('width:'+column.width):'')+'"></td>');
                    // 增加formatter渲染
                    if (column.formatter) {
                        td.html(column.formatter.call(this, item, index));
                    } else {
                        td.text(item[column.field]);
                    }
                    tr.append(td);
                }
            });
        }
        // 加载数据
        target.load = function(parms){
            // 加载数据前先清空
            target.html("");
            // 构造表头
            var thr = $('<tr></tr>');
            $.each(options.columns, function(i, item) {
                var th = null;
                // 判断有没有选择列
                if(i==0&&item.field=='selectItem'){
                    hasSelectItem = true;
                    th = $('<th style="text-align:'+item.valign+';width:36px"></th>');
                }else{
                    th = $('<th style="text-align:'+item.valign+';padding:10px;'+((item.width)?('width:'+item.width):'')+'"></th>');
                }
                th.text(item.title);
                thr.append(th);
            });
            var thead = $('<thead class="treegrid-thead"></thead>');
            thead.append(thr);
            target.append(thead);
            // 构造表体
            var tbody = $('<tbody class="treegrid-tbody"></tbody>');
            target.append(tbody);
            // 添加加载loading
            var _loading = '<tr><td colspan="'+options.columns.length+'"><div style="display: block;text-align: center;">正在努力地加载数据中，请稍候……</div></td></tr>'
            tbody.html(_loading);
            // 默认高度
            if(options.height){
                tbody.css("height",options.height);
            }
            $.ajax({
                type : options.type,
                url : options.url,
                data : parms?parms:options.ajaxParams,
                dataType : "JSON",
                success : function(data, textStatus, jqXHR) {
                    // 加载完数据先清空
                    tbody.html("");
                    if(!data||data.length<=0){
                        var _empty = '<tr><td colspan="'+options.columns.length+'"><div style="display: block;text-align: center;">没有记录</div></td></tr>'
                        tbody.html(_empty);
                        return;
                    }
                    var rootNode = target.getRootNodes(data);
                    $.each(rootNode, function(i, item) {
                        var tr = $('<tr></tr>');
                        tr.addClass('treegrid-' + (j + "_" + i));
                        tr.attr('load','true');
                        tr.addClass('know');
                        target.renderRow(tr,item);
                        item.isShow = true;
                        tbody.append(tr);
                        target.getChildNodes(data, item, (j + "_" + i), tbody);
                    });
                    target.append(tbody);
                    // 初始化treegrid
                    target.treegrid({
                        treeColumn: options.expandColumn?options.expandColumn:(hasSelectItem?1:0),//如果有radio或checkbox默认第二列层级显示，当前是在用户未设置的提前下
                        expanderExpandedClass : options.expanderExpandedClass,
                        expanderCollapsedClass : options.expanderCollapsedClass
                    });
                    if (!options.expandAll) {
                        target.treegrid('collapseAll');
                    }
                    var expanders = target.find("tbody").find(".treegrid-expander");
	                $.each(expanders, function(index, item) {
	                	if ($(item).parent().parent().attr('load')!='true'){
		                 	$(item).click(function(){
		                     	target.loadChilds($(item).parent().parent(),
		                     			{"parentDeptId":$(this).parent().attr('mainid'),
		                     				"parentIndex":$(this).parent().parent().attr('class').split(" ")[0].split("-")[1],
		                     				"nowParentIndex":$(this).parent().parent().attr('class').split(" ")[0].split("-")[0]});
		                 	});
	                 	}
	                });
	                target.repainExpends();
                },
                error:function(xhr,textStatus){
                    var _errorMsg = '<tr><td colspan="'+options.columns.length+'"><div style="display: block;text-align: center;">'+xhr.responseText+'</div></td></tr>'
                    tbody.html(_errorMsg);
                    debugger;
                },
            });
        }
        /***  重新绘制展开图标 ***/
        target.repainExpends = function(){
        	var trExpends = target.find("tr");
        	$.each(trExpends, function(index, item) {
        		if($(item).attr('isLeaf')!='true' && $(item).attr('load') =='true'){
        			$(item).find("span:last-child").addClass('glyphicon-chevron-down').addClass('glyphicon');
        		}else if($(item).hasClass('unknow') && $(item).attr('isLeaf')!='true'){
        			$(item).find("span:last-child").addClass('glyphicon-chevron-right').addClass('glyphicon');
        		}
        			
        	});
        }
        /****** 加载子节点数据 start ***************/
        target.loadChilds = function(parentTR,parms){
        	console.log("~~~~loadChilds~~~~~~");
        	 $.ajax({
                 type : options.type,
                 url : "/system/deptInfo/list",
                 data : parms?parms:options.ajaxParams,
                 dataType : "JSON",
                 success : function(data, textStatus, jqXHR) {
                	 var _tr = target.find(".treegrid-"+parms.parentIndex);
                	 _tr.attr('load','true');
                	 if(data==null || data.length==0){
                		 _tr.attr('isLeaf','true');
                	 }
//                	 else{
                		 target.renderChildRows(data, {"mainId":parms.parentDeptId}, parms.parentIndex, _tr);
                    	 target.treegrid({
                             treeColumn: options.expandColumn?options.expandColumn:(hasSelectItem?1:0),//如果有radio或checkbox默认第二列层级显示，当前是在用户未设置的提前下
                             expanderExpandedClass : options.expanderExpandedClass,
                             expanderCollapsedClass : options.expanderCollapsedClass
                         });
                    	 var expanders = target.find("tbody").find(".treegrid-expander");
    	                 $.each(expanders, function(index, item) {
    	                 	if ($(item).parent().parent().attr('load')!='true'){
    	                 		$(item).click(function(){
    		                     	target.loadChilds(_tr,
    		                     			{"parentDeptId":$(this).parent().attr('mainid'),
    		                     				"parentIndex":$(this).parent().parent().attr('class').split(" ")[0].split("-")[1],
    		                     				"nowParentIndex":$(this).parent().parent().attr('class').split(" ")[0].split("-")[0]});
    		                 	});
    	                 	}
    	                 });
//                	 }
	                 //加载子节点处理回调
	                 parentTR.removeClass('unknow');
	                 parentTR.addClass('know');
	                 target.repainExpends();
                 },
                 error:function(xhr,textStatus){
                     var _errorMsg = '<tr><td colspan="'+options.columns.length+'"><div style="display: block;text-align: center;">'+xhr.responseText+'</div></td></tr>'
                     tbody.html(_errorMsg);
                     debugger;
                 },
             });
        }
        /****** 加载子节点数据 end ***************/
        if (options.url) {
            target.load();
        } else {
            // 也可以通过defaults里面的data属性通过传递一个数据集合进来对组件进行初始化....有兴趣可以自己实现，思路和上述类似
        }

        return target;
    };

    // 组件方法封装........
    $.fn.myAjaxTreeTable.methods = {
        // 返回选中记录的id（返回的id由配置中的id属性指定）
        // 为了兼容bootstrap-table的写法，统一返回数组，这里只返回了指定的id
        getSelections : function(target, data) {
            // 所有被选中的记录input
            var _ipt = target.find("tbody").find("tr").find("input[name='select_item']:checked");
            var chk_value =[];
            // 如果是radio
            if(_ipt.attr("type")=="radio"){
                chk_value.push({id:_ipt.val()});
            }else{
                _ipt.each(function(_i,_item){
                    chk_value.push({id:$(_item).val()});
                });
            }
            return chk_value;
        },
        // 刷新记录
        refresh : function(target, parms) {
        	console.log("~~~~refresh~~~~~");
            if(parms){
                target.load(parms);
            }else{
                target.load();
            }
        },
        // 重置表格视图
        resetHeight : function(target, height) {
        	target.find("tbody").css("height", height + 'px');
        }
        // 组件的其他方法也可以进行类似封装........
    };

    $.fn.myAjaxTreeTable.defaults = {
        id : 'menuId',// 选取记录返回的值
        code : 'menuId',// 用于设置父子关系
        parentCode : 'parentId',// 用于设置父子关系
        rootCodeValue: null,//设置根节点code值----可指定根节点，默认为null,"",0,"0"
        data : [], // 构造table的数据集合
        type : "GET", // 请求数据的ajax类型
        url : null, // 请求数据的ajax的url
        ajaxParams : {}, // 请求数据的ajax的data属性
        expandColumn : null,// 在哪一列上面显示展开按钮
        expandAll : true, // 是否全部展开
        striped : false, // 是否各行渐变色
        columns : [],
        toolbar: null,//顶部工具条
        height: 0,
        expanderExpandedClass : 'glyphicon glyphicon-chevron-down',// 展开的按钮的图标
        expanderCollapsedClass : 'glyphicon glyphicon-chevron-right'// 缩起的按钮的图标
    };
})(jQuery);