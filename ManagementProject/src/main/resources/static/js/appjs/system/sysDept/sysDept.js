
var prefix = "/system/sysDept"
$(function() {
	load();
});

function load() {
	$('#exampleTable')
		.bootstrapTreeTable(
			{
				id : 'deptId',
				code : 'deptId',
                parentCode : 'parentId',
				type : "GET", // 请求数据的ajax类型
				url : prefix + '/list', // 请求数据的ajax的url
				ajaxParams : {
					name:$('#searchName').val(),
					sort:'order_num'
				}, // 请求数据的ajax的data属性
				expandColumn : '1', // 在哪一列上面显示展开按钮
				striped : true, // 是否各行渐变色
				bordered : true, // 是否显示边框
				expandAll : true, // 是否全部展开
				// toolbar : '#exampleToolbar',
				columns : [
					{
						title : '编号',
						field : 'deptId',
						visible : false,
						align : 'center',
						valign : 'middle',
						width : '50px'
					},
					{
						field : 'name',
						title : '部门名称'
					},
					{
						field : 'areaName',
						title : '所属校区'
					},
					{
						field : 'userName',
						title : '负责人'
					},
					{
						field : 'note',
						title : '备注'
					},
					{
						field : 'orderNum',
						title : '排序'
					},
					{
						field : 'delFlag',
						title : '状态',
						align : 'center',
						formatter : function(item, index) {
							if (item.delFlag == '0') {
								return '<span class="label label-danger">禁用</span>';
							} else if (item.delFlag == '1') {
								return '<span class="label label-primary">正常</span>';
							}
						}
					},
					{
						title : '操作',
						field : 'id',
						align : 'center',
						formatter : function(item, index) {
							var e = '<a class="btn btn-primary btn-sm ' + s_edit_h + '" href="#" mce_href="#" title="编辑" onclick="edit(\''
								+ item.deptId
								+ '\')"><i class="fa fa-edit"></i></a> ';
							var a = '<a class="btn btn-primary btn-sm ' + s_add_h + '" href="#" title="增加下級"  mce_href="#" onclick="add(\''
								+ item.deptId
								+ '\')"><i class="fa fa-plus"></i></a> ';
							var d = '<a class="btn btn-warning btn-sm ' + s_remove_h + '" href="#" title="删除"  mce_href="#" onclick="removeone(\''
								+ item.deptId
								+ '\')"><i class="fa fa-remove"></i></a> ';
							var f = '<a class="btn btn-success btn-sm＂ href="#" title="备用"  mce_href="#" onclick="resetPwd(\''
								+ item.deptId
								+ '\')"><i class="fa fa-key"></i></a> ';
							return e + a + d;
						}
					} ]
			});
}
function reLoad() {
	load();
}
function add(pId) {
	layer.open({
		type : 2,
		title : '增加',
		maxmin : true,
		shadeClose : false, // 点击遮罩关闭层
		auto:true,
		area : [ '800px', '520px' ],
		content : prefix + '/add/' + pId
	});
}
function edit(id) {
	layer.open({
		type : 2,
		title : '编辑',
		maxmin : true,
		shadeClose : false, // 点击遮罩关闭层
		auto:true,
		area : [ '800px', '520px' ],
		content : prefix + '/edit/' + id // iframe的url
	});
}
function removeone(id) {
	layer.confirm('确定要删除选中的记录？', {
		btn : [ '确定', '取消' ]
	}, function() {
		$.ajax({
			url : prefix + "/remove",
			type : "post",
			data : {
				'deptId' : id
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

function resetPwd(id) {
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
			ids[i] = row['deptId'];
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

function loadArea(){
	var html = "";
	$.ajax({
		url : '/common/sysDict/list/area',
		success : function(data) {
			//加载数据
			//data=data.rows;
			for (var i = 0; i < data.length; i++) {
				html += '<option value="' + data[i].value + '">' + data[i].name + '</option>'
			}
			$("#area").append(html);
			$("#area").chosen({
				//maxHeight : 200
				 allow_single_deselect: true,width:"100%"
			});
			
			$("#area").val($("#tarea").val());
			$("#area").trigger("chosen:updated");
			// 点击事件
			$('#area').on('change', function(e, params) {
				
			});
			
		}
	});
}

var openUser = function(){
	layer.open({
		type:2,
		title:"选择人员",
		area : [ '360px', '450px' ],
		content:"/sys/user/treeViewrc"
	})
}

function loadUser(userIds,userNames){
	$("#userId").val(userIds);
	$("#userName").val(userNames);
}

function validateRule() {
	$.validator.setDefaults({ ignore: ":hidden:not(select)" });
	var icon = "<i class='fa fa-times-circle'></i> ";
	$("#signupForm").validate({
		errorPlacement: function(error, element) {
	        if (element.hasClass("chosen-select")){ 
	        	error.insertAfter($("#"+element.attr("id")+"_chosen"));
	        }else {
	            error.insertAfter(element);
	        }
	    },
		rules : {
			name : {
				required : true
			}
			/*,area : {
				required : true
			}*/
		},
		messages : {
			name : {
				required : icon + "请输入部门名称"
			}
			/*,area : {
				required : icon + "请选择所属校区"
			}*/
		}
	})
}

