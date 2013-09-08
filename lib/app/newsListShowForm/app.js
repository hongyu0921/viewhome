$(document).ready(function(){
	$.hori.showLoading();
	$.hori.setHeaderTitle("企业新闻");
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
				$.hori.hideLoading();
			},
			"error":function(res){
				alert(res);
				$.hori.hideLoading();
			}
			});
});
function viewfile(url){
	
	$.hori.loadPage(url, $.hori.getconfig().serverBaseUrl+"viewhome/xml/AttachView.xml");
}