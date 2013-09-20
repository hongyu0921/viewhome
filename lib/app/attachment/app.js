var app=window.app={
};
var currentPage = 1;
var total =0;
var path = "";

app.getData=function(args){
	var dataSource=args.dataSource;
	$.hori.ajax({
		"type":"post",
		"url":dataSource,
		"data":"",
		"success":function(res){
			
			var jsonObj=JSON.parse(res);
			if(jsonObj.needLogin){
				var redirectUrl=document.location.href;
				$.hori.jumpToLogin({"redirecUrl":redirectUrl});
				return ;
			}
			app.render(jsonObj);
			

			$("#divDataLoading").hide();

		},
		"error":function(res){
			alert(res);
			$.hori.hideLoading();

			$("#divDataLoading").hide();

		}
	});
	
};

app.render=function(jsonObj){
	
	var hori=$.hori;
	total=jsonObj.total;
	path=jsonObj.path;
	hori.registerEvent("previousButton", "touchUp", function(oper) {
		prewpage();
	});
	
	hori.registerEvent("nextButton", "touchUp", function(oper) {
		nextpage();
	});
	
	
	hori.setHeaderTitle("第"+currentPage+"页/共" + total + "页");
	$("#imgtitle").html("第"+currentPage+"页/共" + total + "页");
		
	
		var path = "<%=path %>";
		if(path.indexOf("?")!=-1){
			path = path + "&data-random=" + Math.random();
		}else{
			path = path + "?data-random=" + Math.random();
		}
		if($("#imgcontent")){
			$("#imgcontent").attr("src", path);
			$("#imgcontent").attr("width", initwidth);
		}
		showHideButtons();
};
$(document).ready(function(){
	var hori=$.hori;
	
	var attachUrl=localStorage.getItem("attachmentUrl");
	var config=$.hori.getconfig();
	
	var serverUrl=config.appServerHost;
	var dataSource=serverUrl+attachUrl;
	app.getData({
		"dataSource":dataSource
	});
	
	
	
});
function showHideButtons() {
	// alert("showHideButtons run ")
	if (currentPage > 1) {
		showButton("previousButton");
	} else {
		hideButton("previousButton");
	}
	if (currentPage < total) {
		

		showButton("nextButton");
	} else {
		hideButton("nextButton");
	}
}


function changeimg(){
	try{

		$("#imgcontent").attr("width", initwidth);
		$.hori.showLoading();
		loaded = false;
		
		$.hori.setHeaderTitle("第"+currentPage+"页/共" + total + "页");
		var config=$.hori.getconfig();
		
		var serverUrl=config.appServerHost;
		path=serverUrl+path;
		showHideButtons();
		var random = parseInt(Math.random()*1000+1)
		if(path.indexOf('?')==-1){
			$("#imgcontent").attr("src", path + "?data-page=" + currentPage+"&data-cache=false&data-random=" + random).one('load',function(){
			$.hori.hideLoading();loaded=true;});
		}else{
			$("#imgcontent").attr("src", path + "&data-page=" + currentPage+"&data-cache=false&data-random=" + random).one('load',function(){$.hori.hideLoading();loaded=true;});
		}
	}catch(e){
		alert(e.message);
	}
}
function prewpage(){
	if(currentPage > 1 && loaded==true){
		currentPage = currentPage - 1;
		changeimg();
	}
}
function nextpage(){
	if(currentPage < total && loaded==true){
		currentPage = currentPage + 1;
		changeimg();
	}
}
function hideButton(xmlButtonName){
	// alert("hide --"+xmlButtonName);
	new cherry.NativeOperation(xmlButtonName,"setProperty",["hidden","1"]).dispatch();
	cherry.flushOperations();
}
function showButton(xmlButtonName){
	new cherry.bridge.NativeOperation(xmlButtonName,"setProperty",["hidden","0"]).dispatch();
	cherry.bridge.flushOperations();
}