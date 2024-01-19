/**

 @Name：layuiAdmin 视图模块
 @Author：贤心
 @Site：http://www.layui.com/admin/
 @License：LPPL

 */

layui.define(['laytpl', 'layer','form','upload', 'table'], function(exports){
  var $ = layui.jquery
  ,laytpl = layui.laytpl
  ,layer = layui.layer
  ,form = layui.form
  ,setter = layui.setter
  ,upload = layui.upload
  ,laytable = layui.table
  ,device = layui.device()
  ,hint = layui.hint()

  //对外接口
  ,view = function(id){
    return new Class(id);
  }

  ,SHOW = 'layui-show', LAY_BODY = 'LAY_app_body'

  //构造器
  ,Class = function(id){
    this.id = id;
    this.container = $('#'+(id || LAY_BODY));
  }
  ,Annex = function(data, options){
    var times = new Date().getTime();
    this.layFilter = 'my-annex-table' + times;
    this.toolbar   = 'my-annex-table-toolbar' + times;
    this.tableId   = "my-uploads-annex" + times;
    this.data = data.data;
    this.dir  = data.dir;
    this.title = options.annexTitle || '附件';
    this.onAnnexAdd = options.onAnnexAdd;
    this.onAnnexDel = options.onAnnexDel;
    delete options.onAnnexAdd;
    delete options.onAnnexDel;
    delete options.annexTitle;
    this.config = options; 
    this.renderAnnex();
    this.annexEvent();
  };
  Annex.prototype.renderAnnex = function(){
    var _this = this;
    var images = [];
    _this.data.forEach(function(item, index){
      var obj = {
        name: item,
        title: '附件' + (index + 1)
      }
      images.push(obj)
    })
    options = _this.config || {};
    var columns = options.cols ? options.cols : [[
      { 
        field:'title', 
        title: '文件名', 
        minWidth:200, 
        templet: function(d){
          return '<i class="layui-icon ' + view.getFileIcon(d.name) + '" style="margin-right:5px;"></i>' + d.title;
        } 
      },
      { 
        fixed: 'right', 
        title:'操作', 
        toolbar: '#' + _this.toolbar, 
        width:150, 
        unresize: true
      }
    ]];
    delete options.cols;
    _this.options = $.extend(options, {
      elem: '#' + _this.layFilter
      , id: _this.tableId
      , data: images
      , page: false
      , cols: columns
    })
    var panel = ['<div class="my-uploads-annex">',
                  '<div class="layui-row layui-col-space15" style="padding: 0 15px;">',
                    '<div class="layui-col-md12">',
                      '<div class="layui-card">',
                        '<div class="layui-card-header">' + _this.title + '</div>',
                          '<div class="layui-card-body">',
                            '<table id="' + _this.layFilter + '" lay-filter="' + _this.layFilter + '"></table>',
                          '</div>',
                        '</div>',
                      '</div>',
                    '</div>',
                  '</div>'].join('');
    var toolbar = [
      '<script type="text/html" id="' + _this.toolbar + '">',
        '<a class="layui-btn layui-btn-normal layui-btn-xs" lay-event="my_annex_table_edit"><i class="layui-icon layui-icon-edit"></i>下载</a>',
        '<a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="my_annex_table_del"><i class="layui-icon layui-icon-delete"></i>删除</a>',
      '</script>',
    ].join('');
    _this.panel = $(panel);
    $('body').append(_this.panel);
    if(_this.data.length == 0){
      _this.hide()
    }
    $('body').append(toolbar);
    this.tableInstance = laytable.render(_this.options);
  }
  Annex.prototype.show = function(){
    this.panel.show();
  }
  Annex.prototype.hide = function(){
    this.panel.hide();
  }
  Annex.prototype.annexEvent = function(){
    var _this = this;
    laytable.on('tool(' + _this.layFilter + ')', function(obj){
      var field = obj.data; //获得当前行数据
      var layEvent = obj.event;
      if(layEvent === 'my_annex_table_edit'){
        view.downloadFile('/public/uploads/' + field.name, '')
      }else if(layEvent === 'my_annex_table_del'){
        _this.data = _this.data.filter(function(item){
          return item != field.name
        });
        obj.del();
        if(_this.data.length == 0){
          _this.hide()
        }
        typeof _this.onAnnexDel === 'function' && _this.onAnnexDel(_this.data, field);
      }
    })
  }
  Annex.prototype.reload = function(){
    var _this = this;
    var images = [];
    _this.data.forEach(function(item, index){
      var obj = {
        name: item,
        title: '附件' + (index + 1)
      }
      images.push(obj)
    })
    _this.options.data = images;
    // console.log( _this.options)
    laytable.reload(_this.tableId, _this.options);
  }
  Annex.prototype.addAnnex = function(fileArr){
    var _this = this;
    _this.data = _this.data.concat(fileArr);
    _this.reload();
    _this.show();
    typeof _this.onAnnexAdd === 'function' && _this.onAnnexAdd(_this.data);
  }
  //加载中
  view.loading = function(elem){
    elem.append(
      this.elemLoad = $('<i class="layui-anim layui-anim-rotate layui-anim-loop layui-icon layui-icon-loading layadmin-loading"></i>')
    );
  };

  //移除加载
  view.removeLoad = function(){
    this.elemLoad && this.elemLoad.remove();
  };

  view.getFileIcon = function(file){
    var suffix = file.slice(file.lastIndexOf(".") + 1).toLowerCase();
    var imglist = ['png', 'jpg', 'jpeg', 'bmp', 'gif'];
    result = imglist.some(function (item) {
      return item == suffix;
    });
    if(result) return 'layui-icon-picture';
    var txtlist = ['txt'];
    result = txtlist.some(function (item) {
      return item == suffix;
    });
    if(result) return 'layui-icon-file';
    var excelist = ['xls', 'xlsx'];
    result = excelist.some(function (item) {
      return item == suffix;
    });
    if(result) return 'layui-icon-table';
    // 匹配 word
    var wordlist = ['doc', 'docx'];
    result = wordlist.some(function (item) {
      return item == suffix;
    });
    if(result) return 'layui-icon-list';
    // 匹配 pdf
    var pdflist = ['pdf'];
    result = pdflist.some(function (item) {
      return item == suffix;
    });
    if(result) return 'layui-icon-tabs';
    // 匹配 ppt
    var pptlist = ['ppt'];
    result = pptlist.some(function (item) {
      return item == suffix;
    });
    if (result) return 'layui-icon-chart-screen';
    // 匹配 视频
    var videolist = ['mp4', 'm2v', 'mkv'];
    result = videolist.some(function (item) {
      return item == suffix;
    });
    if(result) return 'layui-icon-video';
    // 匹配 音频
    var radiolist = ['mp3', 'wav', 'wmv'];
    result = radiolist.some(function (item) {
      return item == suffix;
    });
    if(result) return 'layui-icon-headset';
    return 'layui-icon-file'
  }

  //清除 token，并跳转到登入页
  view.exit = function(callback){
	  layui.data(setter.tableName, null);
    //跳转到登入页
//    location.href = '/views/login.html';
    callback && callback();
  };

 
  view.req = function(options){
    var that = this
    ,success = options.success
    ,error = options.error
    ,request = setter.request
    ,response = setter.response
    ,debug = function(){
      return setter.debug
        ? '<br><b>URL：</b>' + options.url
      : '';
    };

    options.data = options.data || {};
    options.headers = options.headers || {};

    if(request.tokenName){
      var access_token = layui.data(setter.tableName)[request.tokenName];
	  if(!access_token){
		  view.exit(function(){
			  location.href = '/views/login.html';
		  });
		  return;
	  }
      //自动给 Request Headers 传入 token
      options.headers[request.tokenName] = request.tokenName in options.headers
        ?  options.headers[request.tokenName]
      : 'Bearer ' + access_token['access_token'];
    }
    var _options = options;
    delete options.success;
    delete options.error;

    return $.ajax($.extend({
                    type: 'get'
                    , dataType: 'json'
                    , success: function(res){
                        var statusCode = response.statusCode;
                        //只有 response 的 code 一切正常才执行 done
                        if(res[response.statusName] == statusCode.ok) {
                          typeof options.done === 'function' && options.done(res);
                        }else if(res[response.statusName] == statusCode.logout){   //登录状态失效，清除本地 access_token，并强制跳转到登入页
                          view.exit(function(){
                            location.href = '/views/login.html';
                          });
                        }
                        typeof success === 'function' && success(res);
                    }
                    , error: function(e, code, jxq){
                        if(e.status == 401){
                          view.refreshToken(function(){
                            view.req(_options);
                          });
                        }else{
                          // console.log('*************')
                          // console.log(this)
                          // console.log('*************')

                          var error = [
                            '<b>' + code.toUpperCase() + '：</b> ' + e.status + ' '+ e.statusText
                            
                            ,debug()+'<br>'
                            ,'<b>Method：</b> ' + this.type 
                            ,'<br><b>Params：</b> ' + view.dataFormat(options.data) 
                            ,'<br><b>Response：</b> <pre>' + e.responseText + '</pre>'
                            
                            ,'<br><b>ResponseHeaders：</b><pre style="margin-left:10px;">' + e.getAllResponseHeaders() + '</pre>'
                          ].join('');
                          //view.error(error);
                        }
                        typeof error === 'function' && error(e);
                    }
            }, options));
  };
  view.requestFiles = function(options){
    var url = options.url,
        init_url = options.url,
        type = options.type || 'get',
        request = setter.request,
        success = options.success,
        error = options.error,
        data = options.data || {},
        dataType = options.dataType || "blob",
        filename = options.filename,
        fullname = options.fullname,
        format = options.format,
        headers = options.headers || {},
        xhr = new XMLHttpRequest(),
        token = '',
        postData = null;
        
        if(request.tokenName){
          var access_token = layui.data(setter.tableName)[request.tokenName];
          // console.log(access_token)
          if(!access_token){
            view.exit(function(){
              location.href = '/views/login.html';
            });
            return;
          }
          //自动给 Request Headers 传入 token
          token = request.tokenName in headers
                ? headers[request.tokenName]
                : 'Bearer ' + access_token['access_token'];
        }
        if(type.toLowerCase() == 'get'){
          var ind = 0;
          Object.keys(data).forEach(function(key){
            if (ind != 0) {
                url += '&' + key + '=' + data[key];
            } else {
                url += '?' + key + '=' + data[key];
            }
            ind++;
          });
        }else{
          postData = data;
        }
        

        xhr.open(type, url, true);
        xhr.responseType = dataType;
        Object.keys(headers).forEach(function(key){
          xhr.setRequestHeader(key, headers[key]);
        });
        xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
        xhr.setRequestHeader('Authorization', token);
        xhr.onload = function () {
          var blob = this.response;
          var reader = new FileReader();
          reader.readAsDataURL(blob); // 转换为base64，可以直接放入a标签href
          reader.onload = function (f) {
            let a = document.createElement('a'); // 转换完成，创建一个a标签用于下载
            a.download = fullname ? fullname : filename + '.' + format;
            a.href = f.target.result;
            a.click();
          };
          typeof success == 'function' && success();
        };
        xhr.onerror = function () {
          var _error = [
            '<b>Error：</b> ' + xhr.status + ' '+ xhr.statusText
            
            ,'<br><b>URL：</b>' + init_url
            ,'<br><b>Method：</b> ' + type.toUpperCase() 
            ,'<br><b>Params：</b> ' + view.dataFormat(data)
            ,'<br><b>Response：</b> <pre>' + xhr.responseText + '</pre>'
            ,'<br><b>ResponseHeaders：</b><pre style="margin-left:10px;">' + xhr.getAllResponseHeaders() + '</pre>'
          ].join('');
          view.error(_error);
          typeof error == 'function' && error();
        };
        xhr.send(postData);
  };
  view.uploadFiles = function(options) {
    var initFiles = options.initFiles;
    var onAnnexAdd = options.onAnnexAdd;
    var onAnnexDel = options.onAnnexDel;
    var doneFile = options.done;
    var annexTitle = options.annexTitle;
    delete options.initFiles;
    delete options.onAnnexAdd;
    delete options.onAnnexDel;
    delete options.annexTitle;
    delete options.done;
    options.url = options.url ? options.url : setter.domain + 'Api/v1/Upload/Index';
    var request = setter.request;
    options.headers = options.headers ? options.headers : {};
    if(request.tokenName){
      var access_token = layui.data(setter.tableName)[request.tokenName];
      if(!access_token){
        view.exit(function(){
          location.href = '/views/login.html';
        });
        return;
      }
      //自动给 Request Headers 传入 token
      options.headers[request.tokenName] = request.tokenName in options.headers
        ?  options.headers[request.tokenName]
      : 'Bearer ' + access_token['access_token'];
    }
    var errorF = options.error;
    delete options.error;
    options.error = function(index, up, error){
      // console.log('***************Error****************')
      // console.log(this)
      // console.log('***************Error****************')
      var errorInfo = [
        '<b>' + error.text.toUpperCase() + '：</b> ' + error.e.status + ' ' + error.error
        ,'<br><b>URL：</b>' + options.url
        ,'<br><b>Method：</b> ' + this.method.toUpperCase()
        ,'<br><b>Params：</b> ' + view.dataFormat(error.e.params)
        ,'<br><b>Response：</b> <pre>' + error.e.responseText + '</pre>'
        ,'<br><b>ResponseHeaders：</b><pre style="margin-left:10px;">' + error.e.getAllResponseHeaders() + '</pre>'
      ].join('');
      view.error(errorInfo, {}, 2);
      typeof errorF === 'function' && errorF(index, up, error)
    }
    
    if(initFiles){
      if(!(initFiles instanceof Array)) initFiles = []; 
      var uploadAnnex = new Annex({ dir: options.data.dir, data: initFiles }, { annexTitle: annexTitle, onAnnexAdd: onAnnexAdd, onAnnexDel: onAnnexDel });
    }
    options.done = function(res, index, up){
      if(initFiles){
        var newFiles = [];
        newFiles.push(res.data);
        uploadAnnex.addAnnex(newFiles);
      }
      typeof doneFile === 'function' && doneFile(res, index, up)
    }
    return upload.render(options);
  };
  
  view.downloadFile = function(url, filename) {
    // 创建隐藏的可下载链接
    var eleLink = document.createElement('a');
    eleLink.download = filename;
    eleLink.style.display = 'none';
    eleLink.href = url;
    // 触发点击
    document.body.appendChild(eleLink);
    eleLink.click();
    document.body.removeChild(eleLink);
};
  // view.getRemoteFileSize = function(url){
  //   var xhr = new XMLHttpRequest();
  //   var size = 0;
  //   xhr.open('HEAD', url, true);
  //   xhr.onreadystatechange = function(){  
  //     if ( xhr.readyState == 4 ) {    
  //       if ( xhr.status == 200 ) {
  //         size = xhr.getResponseHeader('Content-Length');
  //       }
  //     }
  //   };
  //   xhr.send(null);
  // }
  view.refreshToken= function(callback){
	  	var request = setter.request;
	    var refresh_token = layui.data(setter.tableName)[request.tokenName]['refresh_token'];
		if(!refresh_token){
			view.exit(function(){
			  parent.location.href = '/views/login.html';
		  });
			return;
		}
		$.ajax({
			url: setter.domain + 'api/v2/auth/oauth/token' //实际使用请改成服务端真实接口
			,data: {"grant_type":'refresh_token',"refresh_token":refresh_token}
			,type: 'POST'
			,dataType: 'json'
			,headers:{
				'Authorization':"Basic YXBwOmFwcA=="
			}
			,success: function(res){
			  var tokenData = res;
			  //请求成功后，写入 access_token
			  layui.data(setter.tableName, {
				key: setter.request.tokenName
				,value: tokenData
			  });
			  typeof callback == 'function' ? callback() : '';
			}
			,error:function(e){
				view.exit(function(){
				  parent.location.href = '/views/login.html';
				});
			}
	   });
  };
	//封装下拉框
  view.selectRender= function(options){
	  var request = setter.request,
	  elem = options.elem,
    data = options.data || {},
	  dataKey = options.dataKey || 'data',
    idKey = options.idKey || 'id',
	  nameKey = options.nameKey || 'name',
	  url = options.url,
	  type = options.type || 'get',
	  headers = options.headers || {},
	  dataType = options.dataType || 'json',
	  ASYNC = options.async || true,
	  beforeRender = options.beforeRender,
	  success = options.success,
	  user_error = options.error,
	  onChange = options.onChange,
	  value = options.value || '',
	  placeholder = options.placeholder || '',
	  transdata = options.transdata,
	  debug = function(){
		  return setter.debug ? '<br><b>URL：</b>' + url : '';
	  };
	  if(request.tokenName){
        var access_token = layui.data(setter.tableName)[request.tokenName]['access_token'];
        if(!access_token){
          view.exit(function(){
            location.href = '/views/login.html';
          });
          return;
        }
        //自动给 Request Headers 传入 token
        headers[request.tokenName] = request.tokenName in headers
        ?  headers[request.tokenName]
        : ('Bearer ' + access_token || '');
     }
	   return $.ajax({
		   url:url,
		   type:type,
		   data:data,
		   dataType:dataType,
		   headers:headers,
		   async:ASYNC,
		   success:function(res){
			   typeof beforeRender == 'function' ? beforeRender(res) : '';
			   var list = typeof transdata == 'function' ? transdata(res) : res[dataKey];
			   var str = placeholder == '' ? placeholder : '<option value="">'+placeholder+'</option>';
			   $.each(list,function(i,v){
				   var selected = value == v[idKey] ? 'selected':'';
				   str += '<option data-name="'+v[nameKey]+'" value="'+v[idKey]+'" '+selected+'>'+v[nameKey]+'</option>';
			   })
			   $(elem).html(str);
			   form.render('select');
			   var filter = $(elem).attr('lay-filter');
			   form.on('select('+filter+')', function(re){
				  typeof onChange == 'function' ? onChange(re) : '';
			   });
			   typeof success == 'function' ? success(res,value) : '';
		   },
		   error:function(e, code, jxq){
			   if(e.status == 401){
            view.refreshToken(function(){
              view.selectRender(options);
            });
          }else{
            var error = [
              '<b>' + code.toUpperCase() + '：</b> ' + e.status + ' '+ e.statusText
              ,debug()+'<br>'
              ,'<b>Method：</b> ' + this.type 
              ,'<br><b>Params：</b> ' + view.dataFormat(this.data)
              ,'<br><b>Response：</b> <pre>' + e.responseText + '</pre>'
              ,'<br><b>ResponseHeaders：</b><pre style="margin-left:10px;">' + e.getAllResponseHeaders() + '</pre>'
            ].join('');
            view.error(error);
          }
			   	typeof user_error === 'function' && user_error(e);
		   }
		});
  };
  view.dataFormat = function(data){
    if(!data) return '{}';
    if (JSON.stringify(data) === '{}') return '{}';
    data = typeof data == 'string' 
                  ? JSON.parse(data) 
                  : data; 
    var ht = '<br><span style="padding-left:10px;">{</span><br><p style="padding-left:20px;">';
    var keys = Object.keys(data);
    keys.forEach(function(key,index){
      var after = keys.length == (index + 1) ? '' : ',<br>';
      var value = data[key] 
                ? typeof data[key] == 'string'
                  ? '"' + data[key] + '"'
                  : (data[key] instanceof Array)
                    ? '[Array] ' + JSON.stringify(data[key])
                    : view.isNumber(data[key]) 
                      ? data[key]
                      : typeof data[key] == 'object'
                        ? '[Object] ' + JSON.stringify(data[key])
                        : '[Unkown] ' + JSON.stringify(data[key])
                : '""' ;
      ht += key + ': ' + value + after;
    })
    ht += '</p><span style="padding-left:10px;">}</span>';
    return ht;
  };
  view.isNumber = function(nubmer) { 
  　　var re = /^[0-9]+.?[0-9]*/;//判断字符串是否为数字//判断正整数/[1−9]+[0−9]∗]∗/ 
  　　if (!re.test(nubmer)) { 
  　　　　return false;
  　　} 
      return true;
  }
  //弹窗
  view.popup = function(options){
    var success = options.success
    ,skin = options.skin;

    delete options.success;
    delete options.skin;

    return layer.open($.extend({
      type: 1
      ,title: '提示'
      ,content: ''
      // ,area: ['600px', '100%']
      ,id: 'LAY-system-view-popup'
      ,skin: 'layui-layer-admin' + (skin ? ' ' + skin : '')
      ,shadeClose: true
      ,closeBtn: false
      ,success: function(layero, index){
        var elemClose = $('<i class="layui-icon" close>ဆ</i>');
        layero.append(elemClose);
        elemClose.on('click', function(){
          layer.close(index);
        });
        typeof success === 'function' && success.apply(this, arguments);
      }
    }, options))
  };
  view.getRandomStr = function(n){
    var chars = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z'];
    var res = "";
    for(var i = 0; i < n; i++) {
        var id = Math.ceil(Math.random() * 35);
        res += chars[id];
    }
    return res;
  }
  //异常提示
  view.error = function(content, options, type){
    type = type ? type : 1;
    var timpstamp = new Date().getTime();
    // console.log(content)
    content = content.replace(/<style>/g, '<style scoped>');
    var init_o = $.extend({
      type: 1
      ,title: false //不显示标题栏
      ,closeBtn: false
      ,area: '500px;'
      // ,shade: 0.8
      ,id: 'LAY_layuipro_' + timpstamp + '_' + view.getRandomStr(5) //设定一个id，防止重复弹出
      ,btn: ['确定']
      ,offset: 't'
      ,anim: 6
      ,btnAlign: 'c'
      ,moveType: 1 //拖拽模式，0或者1
      ,moveOut: true
      ,content: '<div style="padding: 20px; line-height: 22px; background-color: #393D49; color: #fff; font-weight: 300;">'+ content +'</div>'
      // ,success: function(layero, index){
      //   var elemClose = $('<i class="layui-icon" close>ဆ</i>');
      //   layero.append(elemClose);
      //   elemClose.on('click', function(){
      //     layer.close(index);
      //   });
        // typeof success === 'function' && success.apply(this, arguments);
      // }
    }, options);
    // var success = options.success
    // ,skin = options.skin;

    // delete options.success;
    // delete options.skin;
    if(type == 1){
      return layer.open(init_o)
    }else{
      return parent.layer.open(init_o)
    }
    // return view.popup($.extend({
    //   content: content
    //   ,maxWidth: 400
    //   //,shade: 0.01
    //   ,offset: 't'
    //   ,anim: 6
    //   ,id: 'LAY_adminError'
    // }, options))
  };


  //请求模板文件渲染
  Class.prototype.render = function(views, params){
    var that = this, router = layui.router();
    views = setter.views + views + setter.engine;

    $('#'+ LAY_BODY).children('.layadmin-loading').remove();
    view.loading(that.container); //loading

    //请求模板
    $.ajax({
      url: views
      ,type: 'get'
      ,dataType: 'html'
      ,data: {
        v: layui.cache.version
      }
      ,success: function(html){
        html = '<div>' + html + '</div>';

        var elemTitle = $(html).find('title')
        ,title = elemTitle.text() || (html.match(/\<title\>([\s\S]*)\<\/title>/)||[])[1];

        var res = {
          title: title
          ,body: html
        };

        elemTitle.remove();
        that.params = params || {}; //获取参数

        if(that.then){
          that.then(res);
          delete that.then;
        }

        that.parse(html);
        view.removeLoad();

        if(that.done){
          that.done(res);
          delete that.done;
        }

      }
      ,error: function(e){
        view.removeLoad();

        if(that.render.isError){
          return view.error('请求视图文件异常，状态：'+ e.status);
        };

        if(e.status === 404){
          that.render('template/tips/404');
        } else {
          that.render('template/tips/error');
        }

        that.render.isError = true;
      }
    });
    return that;
  };

  //解析模板
  Class.prototype.parse = function(html, refresh, callback){
    var that = this
    ,isScriptTpl = typeof html === 'object' //是否模板元素
    ,elem = isScriptTpl ? html : $(html)
    ,elemTemp = isScriptTpl ? html : elem.find('*[template]')
    ,fn = function(options){
      var tpl = laytpl(options.dataElem.html());

      options.dataElem.after(tpl.render($.extend({
        params: router.params
      }, options.res)));

      typeof callback === 'function' && callback();

      try {
        options.done && new Function('d', options.done)(options.res);
      } catch(e){
        console.error(options.dataElem[0], '\n存在错误回调脚本\n\n', e)
      }
    }
    ,router = layui.router();

    elem.find('title').remove();
    that.container[refresh ? 'after' : 'html'](elem.children());

    router.params = that.params || {};

    //遍历模板区块
    for(var i = elemTemp.length; i > 0; i--){
      (function(){
        var dataElem = elemTemp.eq(i - 1)
        ,layDone = dataElem.attr('lay-done') || dataElem.attr('lay-then') //获取回调
        ,url = laytpl(dataElem.attr('lay-url')|| '').render(router) //接口 url
        ,data = laytpl(dataElem.attr('lay-data')|| '').render(router) //接口参数
        ,headers = laytpl(dataElem.attr('lay-headers')|| '').render(router); //接口请求的头信息

        try {
          data = new Function('return '+ data + ';')();
        } catch(e) {
          hint.error('lay-data: ' + e.message);
          data = {};
        };

        try {
          headers = new Function('return '+ headers + ';')();
        } catch(e) {
          hint.error('lay-headers: ' + e.message);
          headers = headers || {}
        };

        if(url){
          view.req({
            type: dataElem.attr('lay-type') || 'get'
            ,url: url
            ,data: data
            ,dataType: 'json'
            ,headers: headers
            ,success: function(res){
              fn({
                dataElem: dataElem
                ,res: res
                ,done: layDone
              });
            }
          });
        } else {
          fn({
            dataElem: dataElem
            ,done: layDone
          });
        }
      }());
    }

    return that;
  };

  //自动渲染数据模板
  Class.prototype.autoRender = function(id, callback){
    var that = this;
    $(id || 'body').find('*[template]').each(function(index, item){
      var othis = $(this);
      that.container = othis;
      that.parse(othis, 'refresh');
    });
  };

  //直接渲染字符
  Class.prototype.send = function(views, data){
    var tpl = laytpl(views || this.container.html()).render(data || {});
    this.container.html(tpl);
    return this;
  };

  //局部刷新模板
  Class.prototype.refresh = function(callback){
    var that = this
    ,next = that.container.next()
    ,templateid = next.attr('lay-templateid');

    if(that.id != templateid) return that;

    that.parse(that.container, 'refresh', function(){
      that.container.siblings('[lay-templateid="'+ that.id +'"]:last').remove();
      typeof callback === 'function' && callback();
    });

    return that;
  };

  //视图请求成功后的回调
  Class.prototype.then = function(callback){
    this.then = callback;
    return this;
  };

  //视图渲染完毕后的回调
  Class.prototype.done = function(callback){
    this.done = callback;
    return this;
  };

  //对外接口
  exports('view', view);
});
