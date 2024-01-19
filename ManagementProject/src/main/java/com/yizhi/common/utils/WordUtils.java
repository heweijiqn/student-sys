package com.yizhi.common.utils;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.OutputStreamWriter;
import java.io.Writer;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.poifs.filesystem.POIFSFileSystem;
import org.apache.poi.xwpf.usermodel.XWPFDocument;
import org.springframework.core.io.ClassPathResource;
import org.springframework.core.io.Resource;


import freemarker.template.Configuration;
import freemarker.template.Template;
public class WordUtils {
	//配置信息,代码本身写的还是很可读的,就不过多注解了  
    private static Configuration configuration = null;  
    //这里注意的是利用WordUtils的类加载器动态获得模板文件的位置  
   // private static final String templateFolder = WordUtils.class.getClassLoader().getResource("../../").getPath() + "WEB-INF/templetes/";  
    //private static final String templateFolder = "templates";  
    static {  
        configuration = new Configuration();  
        configuration.setDefaultEncoding("utf-8");  
        //configuration.setDirectoryForTemplateLoading(new File(templateFolder));  
		configuration.setClassForTemplateLoading(WordUtils.class, "/templates/ftl/");  
   }  
  
    private WordUtils() {  
        throw new AssertionError();  
    }  
  
    public static void exportMillCertificateWord(HttpServletRequest request, HttpServletResponse response, Map map,String title,String ftlFile) throws IOException {  
        Template freemarkerTemplate = configuration.getTemplate(ftlFile);  
        File file = null;  
        InputStream fin = null;  
        ServletOutputStream out = null;  
        try {  
            // 调用工具类的createDoc方法生成Word文档  
            file = createDoc(map,freemarkerTemplate);  
            fin = new FileInputStream(file);  
  
            response.setCharacterEncoding("utf-8");  
            response.setContentType("application/msword");  
            // 设置浏览器以下载的方式处理该文件名  
            SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
            String fileName = title+format.format(new Date().getTime())+ ".doc";  
            response.setHeader("Content-Disposition", "attachment;filename="  
                    .concat(String.valueOf(URLEncoder.encode(fileName, "UTF-8"))));  
  
            out = response.getOutputStream();  
            byte[] buffer = new byte[512];  // 缓冲区  
            int bytesToRead = -1;  
            // 通过循环将读入的Word文件的内容输出到浏览器中  
            while((bytesToRead = fin.read(buffer)) != -1) {  
                out.write(buffer, 0, bytesToRead);  
            }  
        } finally {  
            if(fin != null) fin.close();  
            if(out != null) out.close();  
            if(file != null) file.delete(); // 删除临时文件  
        }  
    } 
    
    
    /*
     *压缩包方式导出多个word
     *由于一次请求浏览器只能响应一次，想导出多个必须打包，亲测for循环导出只能导一个
     *如果想做到分别单独下载，那就得用插件啦，这里不提供插件的做法
     *思路：生成临时目录-在临时目录生成word-将临时目录打zip包-zip文件下载-删除临时目录和zip包，
     * 回收系统资源
     */
     public static void exportWordBatch(HttpServletRequest request, HttpServletResponse response,List<Map<String, Object>> mapList,List<String> titleList,String ftlFile,String zipFileName) {
     	File file = null;
     	File zipfile=null;
     	File directory=null;
         InputStream fin = null;  
         ServletOutputStream out = null;
         SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
         //HttpServletRequest request=WebUtils.getRequest();
 		//HttpServletResponse response=WebUtils.getResponse();
         String fileName = zipFileName+format.format(new Date().getTime())+ ".zip";  
         try { 
        	 
        	 response.setCharacterEncoding("utf-8");  
             response.setContentType("application/octet-stream");
             response .addHeader("Content-Disposition", "attachment;filename=".concat(String.valueOf(URLEncoder.encode(fileName, "UTF-8"))));
        	 
         	Template freemarkerTemplate = configuration.getTemplate(ftlFile,"UTF-8"); 
         	out = response.getOutputStream();
         	//根据当前时间和用户id创建临时目录
         	String path=request.getRealPath("/resources/word/"+format.format(new Date().getTime())+"_"+new SimpleDateFormat("HHmmssSSS").format(new Date()));
         	directory=new File(path);
         	directory.mkdirs();
         	for(int i=0;i<mapList.size();i++) {
         		Map<String, Object> map=mapList.get(i);
         		String title=titleList.get(i);
         		// 调用工具类的createDoc方法在临时目录下生成Word文档  
                 file = createDoc(map,freemarkerTemplate,directory.getPath()+"/"+title+".doc");
                 /*
                 File pdfFile=new File(directory.getPath()+"/"+title+".pdf");
                 if(!pdfFile.exists()){
                	 pdfFile.createNewFile();
                	 }
                 OutputStream outputStream=new FileOutputStream(pdfFile);
                 InputStream inputStream=new FileInputStream(file);
                 wordConverter2003ToPdf(inputStream, outputStream, null, null);
                 */
         	}
         	//压缩目录
         	ZipUtil.createZip(path, path+".zip");
             //根据路径获取刚生成的zip包文件
         	zipfile=new File(path+".zip");
         	fin=new FileInputStream(zipfile);
 			byte[] buffer = new byte[512]; // 缓冲区
 			int bytesToRead = -1;
 			// 通过循环将读入的Word文件的内容输出到浏览器中
 			while ((bytesToRead = fin.read(buffer)) != -1) {
 				out.write(buffer, 0, bytesToRead);
 			}
      
             
         }catch (Exception e) {
 			e.printStackTrace();
 		}
         finally {  
         	try {
         		if (fin!=null) fin.close();
             	if (out!=null) out.close();
             	if (zipfile!=null) zipfile.delete();
             	if (directory!=null) {
                     //递归删除目录及目录下文件
             		ZipUtil.deleteFile(directory);
             	}
 			} catch (Exception e2) {
 				e2.printStackTrace();
 			}
         	
         }  
     }
  
    private static File createDoc(Map<?, ?> dataMap, Template template) {
        String name =  "sellPlan.doc";  
        File f = new File(name);  
        Template t = template;  
        try {  
            // 这个地方不能使用FileWriter因为需要指定编码类型否则生成的Word文档会因为有无法识别的编码而无法打开  
            Writer w = new OutputStreamWriter(new FileOutputStream(f), "utf-8");  
            t.process(dataMap, w);  
            w.close();  
        } catch (Exception ex) {  
            ex.printStackTrace();  
            throw new RuntimeException(ex);  
        }  
        return f;  
    }
    
  //生成word文档方法
    private static File createDoc(Map<?, ?> dataMap, Template template,String filename) {
          
        File f = new File(filename);  
        Template t = template;  
        Writer w =null;
        FileOutputStream fos=null;
        try {  
            // 这个地方不能使用FileWriter因为需要指定编码类型否则生成的Word文档会因为有无法识别的编码而无法打开 
        	fos=new FileOutputStream(f);
            w = new OutputStreamWriter(fos, "utf-8");
            //不要偷懒写成下面酱紫: 否则无法关闭fos流，打zip包时存取被拒抛异常
            //w = new OutputStreamWriter(new FileOutputStream(f), "utf-8");   
            t.process(dataMap, w);  
        } catch (Exception ex) {  
            ex.printStackTrace();  
            throw new RuntimeException(ex);  
        } finally {
        	try {
        		fos.close();
    			w.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
			
		} 
        return f;  
    }
 
}