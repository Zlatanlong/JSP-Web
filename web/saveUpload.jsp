<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"> 
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="ljh.util.*"%>
<%
      String newFilename=DateUtil.getRandom();
      FileUploadBean upload=new FileUploadBean();
      String path = request.getRealPath("");
      path=path.substring(0,path.lastIndexOf("/",path.lastIndexOf("/")-1))+"/img";
      <%-- path=path.substring(0,path.lastIndexOf("\\"))+"\\img"; --%>
      <%-- windows --%>
      upload.setSavePath(path);
      upload.saveAs(newFilename);
      upload.doUpload(request);
      session.setAttribute("dishimgurl",upload.getFilename());
%>
<script LANGUAGE="JavaScript">
alert("图片上传完成，点击提交即可！");
</script>

