
var prefix = ctx + "student/college";//ctx由页面处定义

layui.config({
	    base: ctx +'layui/' //静态资源所在路径
	  }).extend({
	    index: 'lib/index' //主入口模块
	  }).use(['index','form','element','table', 'admin'], function(){
	    var table = layui.table
	    ,admin = layui.admin
	    ,form = layui.form;
	    var $ = layui.jquery;
	    
	    /*
	    admin.selectRender({
	        elem: '#type',
	        url: '/common/sysDict/type',
	        idKey: 'type',
	        nameKey: 'description',
	        value: '',
	        placeholder: '选择类型',
	        transdata: function(res) {
	          return res
	        }
	      })
		*/
	    
	    var cols=[
	    	{type: 'checkbox',fixed: 'left'},
	    	{field: 'id', title: '序号', width:80, fixed: 'left', align:'center',type: 'numbers'},//templet: '#indexTpl'
	    	{field : 'collegeNum', title : '学院编号'},
	    	{field : 'collegeName', title : '学院名称'},
	    	{field : 'singleName', title : '简称'},
	    	{field : 'introduce', title : '学院介绍'},
	    	
	    	{fixed: 'right',title: '操作',align: 'center',toolbar: '#table-content-list'}
	
	    ];
	    
	    table.render({
		    elem: '#LAY-app-content-list'
		    ,height: 'full-180'
		    ,cellMinWidth: 120
		    ,limit: 10
		    //,totalRow: true//统计行
		    //,toolbar: 'true'//工具栏打印导出...
		    ,url: prefix + '/list' //数据接口
	    	,where: {
	    		//ssort: "type,sort"
	    	  }
	    	,parseData: function(res){ //res 即为原始返回的数据
	    	    return {
	    	      "code": res.code, //解析接口状态
	    	      "msg": res.msg, //解析提示文本
	    	      "count": res.total, //解析数据长度
	    	      "data": res.rows //解析数据列表
	    	    };
	    	  }
		    ,page: true //开启分页
		    ,request: {
		        pageName: 'currPage', //页码的参数名称，默认：page
		        limitName: 'pageSize' //每页数据量的参数名，默认：limit
		      }
		    ,cols: [cols]
		    ,done:function(){
		    	layer.closeAll('loading');
		    }
		  });
	    
	    
	    //监听搜索
	    form.on('submit(LAY-app-contlist-search)', function(data){
	      var field = data.field;
	      //执行重载
	      table.reload('LAY-app-content-list', {
	        where: field,
	        page: {
	            curr: 1 //重新从第 1 页开始
	          }
	      });
	    });
	    
	    var active = {
	    
	      batchdel: function(){
	        var checkStatus = table.checkStatus('LAY-app-content-list')
	        ,checkData = checkStatus.data; //得到选中的数据
	
	        if(checkData.length === 0){
	          return layer.msg('请选择数据');
	        }
	      	
	        layer.confirm('确定要删除选中的记录？', function(index) {
	          //执行 Ajax 后重载
	          var ids = new Array();
			// 遍历所有选择的行数据，取每条数据对应的ID
			$.each(checkData, function(i, row) {
				ids[i] = checkData[i]['id'];
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
	        
	        });
	      },
	      add: function(){
		   	  layer.open({
		   			type : 2,
		   			title : '增加',
		   			maxmin : true,
		   			shadeClose : false, // 点击遮罩关闭层
		   			auto:true,
		   			area : [ '800px', '520px' ],
		   			content : prefix + '/add' // iframe的url
		   		})
		   }
	    };
	    
	  //监听行工具事件
	    table.on('tool(LAY-app-content-list)', function(obj) {
	      var data = obj.data
	      var layEvent = obj.event
	
	      switch (obj.event) {
	        case 'edit':
	          edit(data['id'])
	          break
	        case 'del':
	        	remove(data['id'])
	          break
	      }
	
	    })
	    
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
	  
	    function remove(id) {
	    	layer.confirm('确定要删除选中的记录？', {
	    		btn : [ '确定', '取消' ]
	    	}, function() {
	    		$.ajax({
	    			url : prefix + "/remove",
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
	    
	
	    $('.layui-btn.layuiadmin-btn-list').on('click', function(){
	      var type = $(this).data('type');
	      active[type] ? active[type].call(this) : '';
	    });
	    
	    var reLoad=function(flag){
	    	if(flag){
	   		 table.reload('LAY-app-content-list', {
	   	            page: {
	   	                curr: 1 //重新从第 1 页开始
	   	            }
	   	        });
	    	}else{
	    		table.reload('LAY-app-content-list');
	    	}
	    };
	    
	    window.reLoad=reLoad;
	
	  });

