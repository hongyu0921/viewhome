$(document).ready(function(){
	
	var config=$.hori.getconfig();
	var itcode=localStorage.getItem("itcode");

	var oaServerName=localStorage.getItem("oaServerName");
	var serverUrl=$.hori.getconfig().appServerHost+"view/oamobile/contentmobile";
	
	var dataSource=localStorage.getItem("oaDataSource");
	var localServer=$.hori.getconfig().serverBaseUrl;
	serverUrl=serverUrl+dataSource;
	
	
		$.hori.ajax({
			"type":"post",
			"url":serverUrl,
			"data":"",
			"success":function(htmlStr){
				$("body").html(htmlStr);
				var jqscript=document.createElement("script");
				jqscript.src="../lib/jquery-mobile/jquery.mobile.min.js";
				$("head").after(jqscript);
			},
			"error":function(res){
				alert(res);
			}
			});
});

