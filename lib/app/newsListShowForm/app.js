$(document).ready(function(){
	
	
	var dataSource=localStorage.getItem("oaDataSource");
	
	serverUrl=dataSource;
	
	
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
function viewfile(url){
	
	$.hori.loadPage(url, $.hori.getconfig().serverBaseUrl+"viewhome/xml/Resources/AttachView.xml");
}