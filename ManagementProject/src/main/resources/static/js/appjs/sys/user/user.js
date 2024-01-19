var prefix = "/sys/user"
var deptId = '';
$(function() {
	getTreeData();
	load();
	//$('#exampleTable').bootstrapTable('resetView',{height:$(window).height()-80});
});

function load() {
	$('#exampleTable')
		.bootstrapTable(
			{
				method : 'get', // 服务器数据的请求方式 get or post
				url : prefix + "/list", // 服务器数据的加载地址
				 //showRefresh : true,
				 //showToggle : true,
				//showColumns : true, 
				iconSize : 'outline',
				toolbar : '#exampleToolbar',
				striped : true, // 设置为true会有隔行变色效果
				dataType : "json", // 服务器返回的数据类型
				pagination : true, // 设置为true会在底部显示分页条
				// queryParamsType : "limit",
				// //设置为limit则会发送符合RESTFull格式的参数
				singleSelect : false, // 设置为true将禁止多选
				// contentType : "application/x-www-form-urlencoded",
				// //发送到服务器的数据编码类型
				pageSize : 10, // 如果设置了分页，每页数据条数
				pageNumber : 1, // 如果设置了分布，首页页码
				pageList: [10, 25, 50, 100],
				// search : true, // 是否显示搜索框
				showColumns : false, // 是否显示内容下拉框（选择显示的列）
				showRefresh : false,//刷新按钮
				showToggle : false,//切换列模式
				//sortable: true, //是否启用排序
				//sortOrder: "asc",
				sidePagination : "server", // 设置在哪里进行分页，可选值为"client" 或者
				// "server"
				queryParams : function(params) {
					//params.sort=(params.sort=='deptDO' ? 'deptId':params.sort);
					console.log(params);
					return {
						// 说明：传入后台的参数包括offset开始索引，limit步长，sort排序列，order：desc或者,以及所有列的键值对
						limit : params.limit,
						offset : params.offset,
						name : $('#searchName').val(),
						mobile:$('#mobile').val(),
						deptId : deptId,
						digui:$("#digui").val(),
						isvaild: 1,
						roleId:$("#roleId").val(),
						sort: params.sort,      //排序列名  
                        order: params.order //排位命令（desc，asc） 
					};
				},
				// //请求服务器数据时，你可以通过重写参数的方式添加一些额外的参数，例如 toolbar 中的参数 如果
				// queryParamsType = 'limit' ,返回参数必须包含
				// limit, offset, search, sort, order 否则, 需要包含:
				// pageSize, pageNumber, searchText, sortName,
				// sortOrder.
				// 返回false将会终止请求
				columns : [
					{
						checkbox : true
					},
					{
						field : 'userId', // 列字段名
						title : '序号', // 列标题
						 formatter: function (value, row, index) {
					            var pageSize = $('#exampleTable').bootstrapTable('getOptions').pageSize;     //通过table的#id 得到每页多少条
					            var pageNumber = $('#exampleTable').bootstrapTable('getOptions').pageNumber; //通过table的#id 得到当前第几页
					            return pageSize * (pageNumber - 1) + index + 1;    // 返回每条的序号： 每页条数 *（当前页 - 1 ）+ 序号
					        }
					},
					{
						field : 'name',
						title : '姓名(施工单位)',
						align : 'center',
						sortable: true
					},
					{
						field : 'username',
						title : '用户名',
						align : 'center',
						sortable: true
					},
					{
						field : 'mobile',
						title : '手机号',
						align : 'center'
					},
					{
						field : 'roles',
						title : '角色',
						align : 'center',
						//sortable: true,
						formatter : function(value, row, index) {
							if(value.length>0){
								var rolename="";
								for(var i=0;i<value.length;i++){
									rolename+=value[i].roleName+";";
								}
								return rolename.substring(0, rolename.lastIndexOf(';'));
							}
							
						}
					},
					{
						field : 'jobName',
						title : '职务',
						align : 'center'
					},{
						field : 'receiveMsg',
						title : '接收消息',
						align : 'center',
						sortable: true,
						formatter : function(value, row, index) {
							if (value == '0') {
								return '<span class="label label-danger">否</span>';
							} else if (value == '1') {
								return '<span class="label label-primary">是</span>';
							}
						}
					},
					{
						field : 'status',
						title : '状态',
						sortable: true,
						align : 'center',
						formatter : function(value, row, index) {
							if (value == '0') {
								return '<span class="label label-danger">禁用</span>';
							} else if (value == '1') {
								return '<span class="label label-primary">正常</span>';
							}
						}
					},
					{
						field : 'openid',
						title : '绑定',
						sortable: true,
						align : 'center',
						formatter : function(value, row, index) {
							var str='';
							if (value) {
								str+= '<i class="fa fa-tablet" title="小程序"></i>';
							}
							if (row.gzhOpenid) {
								str+= '<i class="fa fa-weixin" title="公众号" style="margin-left:10px;"></i>';
							}
							return str;
						}
					},
					{
						title : '操作',
						field : 'id',
						align : 'center',
						formatter : function(value, row, index) {
							var e = '<a  class="btn btn-primary btn-sm ' + s_edit_h + '" href="# '+row.userId+'" mce_href="#" title="编辑" onclick="edit(\''
								+ row.userId
								+ '\')"><i class="fa fa-edit "></i></a> ';
							var d = '<a class="btn btn-warning btn-sm ' + s_remove_h + '" href="#" title="删除"  mce_href="#" onclick="remove(\''
								+ row.userId
								+ '\')"><i class="fa fa-remove"></i></a> ';
							var f = '<a class="btn btn-success btn-sm ' + s_resetPwd_h + '" href="#" title="重置密码"  mce_href="#" onclick="resetPwd(\''
								+ row.userId
								+ '\')"><i class="fa fa-key"></i></a> ';
							return e + d + f;
						}
					} ]
			});
}
function reLoad(f) {
	if(f){
		$("#exampleTable").bootstrapTable('selectPage',1);
	}else{
		$('#exampleTable').bootstrapTable('refresh');
	}
}
function add() {
	//jp.openDialog('增加用户', prefix + '/add','800px', '600px',null);
	// iframe层
	
	layer.open({
		type : 2,
		title : '增加用户',
		maxmin : true,
		shadeClose : false, // 点击遮罩关闭层
		auto:true,
		area : [ '800px', '590px' ],
		content : prefix + '/add'
	});
}
function remove(id) {
	layer.confirm('确定要删除选中的记录？', {
		btn : [ '确定', '取消' ]
	}, function() {
		$.ajax({
			url : "/sys/user/remove",
			type : "post",
			data : {
				'id' : id
			},
			success : function(r) {
				if (r.code == 0) {
					layer.msg(r.msg);
					reLoad();
				} else {
					layer.msg(r.msg);
				}
			}
		});
	})
}
function edit(id) {
	//jp.openDialog('用户修改', prefix + '/edit/' + id,'800px', '600px',$('#exampleTable'));
	
	layer.open({
		type : 2,
		title : '用户修改',
		maxmin : true,
		shadeClose : false,
		auto:true,
		area : [ '800px', '590px' ],
		content : prefix + '/edit/' + id // iframe的url
	});
}
function resetPwd(id) {
	layer.open({
		type : 2,
		title : '重置密码',
		maxmin : true,
		shadeClose : false, // 点击遮罩关闭层
		auto:true,
		area : [ '400px', '260px' ],
		content : prefix + '/resetPwd/' + id // iframe的url
	});
}
function batchRemove() {
	var rows = $('#exampleTable').bootstrapTable('getSelections'); // 返回所有选择的行，当没有选择的记录时，返回一个空数组
	if (rows.length == 0) {
		layer.msg("请选择要删除的数据");
		return;
	}
	layer.confirm("确认要删除选中的'" + rows.length + "'条数据吗?", {
		btn : [ '确定', '取消' ]
	// 按钮
	}, function() {
		var ids = new Array();
		// 遍历所有选择的行数据，取每条数据对应的ID
		$.each(rows, function(i, row) {
			ids[i] = row['userId'];
		});
		$.ajax({
			type : 'POST',
			data : {
				"ids" : ids
			},
			url : prefix + '/batchRemove',
			success : function(r) {
				if (r.code == 0) {
					layer.msg(r.msg);
					reLoad();
				} else {
					layer.msg(r.msg);
				}
			}
		});
	}, function() {});
}
function getTreeData() {
	$.ajax({
		type : "GET",
		url : "/system/sysDept/tree?sort=order_num",
		success : function(tree) {
			loadTree(tree);
		}
	});
}
function loadTree(tree) {
	$('#jstree').jstree({
		'core' : {
			'data' : tree
		},
		"plugins" : [ "search" ]
	});
	$('#jstree').jstree().open_all();
}
$('#jstree').on("changed.jstree", function(e, data) {
	if (data.selected == -1) {
		var opt = {
			query : {
				deptId : '',
			}
		}
		deptId='';
		//$('#exampleTable').bootstrapTable('refresh', opt);
		reLoad(1);
	} else {
		var opt = {
			query : {
				deptId : data.selected[0]
			}
		}
		deptId=data.selected[0];
		//$('#exampleTable').bootstrapTable('refresh',opt);
		reLoad(1);
	}

});

function getall(){
	 $("#jstree").jstree("deselect_all",true);
	deptId='';
	$('#searchName').val('');
	$('#mobile').val('');
	reLoad(1);
}


//导出Excel type导出的类型
//type 1 导出当页数据 2 导出全部数据 3 导出符合条件全部数据
function exportExcel(type) {
    //获取table的分页参数值
    var limit = $('#exampleTable').bootstrapTable('getOptions').pageSize;
    var offset = $('#exampleTable').bootstrapTable('getOptions').pageNumber * limit-limit;
    data = 'offset='+offset+'&limit='+limit;
    //后端导出的方法
    document.location.href = prefix + "/exportExcel?type="+type+"&"+ data;
}