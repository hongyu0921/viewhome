<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
    <%@ page language="java" import="cc.movein.mda.system.control.Query"%>
<%@ page language="java" import="org.json.*"%>


<%@ page language="java" import="org.dom4j.Document"%>
<%@ page language="java" import="org.dom4j.DocumentException"%>
<%@ page language="java" import="org.dom4j.Element"%>
<%@ page language="java" import="org.dom4j.Node"%>
<%@ page language="java" import="org.dom4j.DocumentHelper"%>
<%@ page language="java" import="java.util.List"%>
<%@ page language="java" import="java.util.Iterator"%>
<%@ page language="java" import="org.apache.commons.lang.StringEscapeUtils"%>

				<%
				JSONArray taskArray=new JSONArray();
				JSONObject taskJson=new JSONObject();	
				Query q = Query.getInstance(request);
				String responseXml = q.getContent();
				System.out.println(responseXml);
				Document   doc = DocumentHelper.parseText(responseXml);
				int todsNumber=doc.selectNodes("//viewentries/viewentry").size()-1;
				List newlist=doc.selectNodes("//viewentry");
				
				for(int i=1; i<newlist.size();i++){
					Element todoInfo=(Element)newlist.get(i);
					JSONObject json=new JSONObject();
					Node idate=todoInfo.selectSingleNode("./entrydata[2]/text");		//发布日期
					Node title=todoInfo.selectSingleNode("./entrydata[5]/text");			//标题
					
					
					/*
						cdata q.getContent() 前面的<被转义为&lg;,反解义
					*/
					String idateString=DocumentHelper.parseText(StringEscapeUtils.unescapeXml(idate.asXML())).getRootElement().getStringValue();
					String titleString=DocumentHelper.parseText(StringEscapeUtils.unescapeXml(title.asXML())).getRootElement().getStringValue();
	
					String unid=todoInfo.attributeValue("unid");
					
					String href="";
					json.put("title",titleString);
					json.put("date",idateString);
					json.put("unid",unid);
					
					json.put("href",unid);
					taskArray.put(json);
					
				}
				taskJson.put("newsCount", todsNumber);		
				taskJson.put("newslist",taskArray);
			
				out.clear();

				out.print(taskJson);

				System.out.println(taskJson);
				
				%>
				