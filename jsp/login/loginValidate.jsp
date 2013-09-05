<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
    <%@ page language="java" import="cc.movein.mda.system.control.Query"%>
<%@ page language="java" import="org.json.*"%>
<%@ page language="java" import="org.dom4j.io.SAXReader"%>;

<%@ page language="java" import="org.dom4j.Document"%>;
<%@ page language="java" import="org.dom4j.DocumentException"%>;
<%@ page language="java" import="org.dom4j.Element"%>;
<%@ page language="java" import="org.dom4j.Node"%>;
<%@ page language="java" import="org.dom4j.DocumentHelper"%>;


				<%
				JSONObject json=new JSONObject();			
				Query q = Query.getInstance(request);
			
				String responseXml = q.getContent();
				System.out.println(responseXml);
				Document   doc = DocumentHelper.parseText(responseXml);
				
				String formAction=doc.selectSingleNode("//form//@action").getStringValue();
				
				
				if(formAction.contains("names.nsf")){
					json.put("success", false);
					json.put("msg","用户名和密码错误！");
				}else{
				String itcode=doc.selectSingleNode("//param[@name=\"Username\"]/@value").getStringValue();
					json.put("success", true);
					json.put("itcode",itcode);
				}
				
				String type = q.getContentType();
				System.out.println(type);
				out.clear();
				out.println(json);
				System.out.println(json);
				
				%>
				