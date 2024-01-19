项目部署说明:
1.项目基于  Maven 进行依赖管理
2.数据库    MySql5.7(8.0)  项目文件中有数据库结构yizhi_db.sql文件,创建库后导入即可
3.缓存模块  Redis 6.x
4.JDK 1.8  SpringBoot2.0

配置文件说明:
1.项目启动 默认加载 application-dev.yml
2.MySql Redis 连接配置修改

程序访问入口:
http://localhost:8080/index
平台登录帐号: admin 密码: 111111

模块:  学生管理模块
需要操作的类:   com.yizhi.student.controller.StudentInfoController
需要完成的功能:  学生信息的,list查询接口,save保存接口,update修改接口,删除接口

mybatis映射文件: 完善 mybits/student/StudentInfoMapper.xml
