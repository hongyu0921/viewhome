var app=window.app={
}
app.searchContact=function(){
	var username = $("#phonenumber").val();
	if($.trim(username)==""){
		alert('请输入关键字 ');
		return ;
	}
	
	var config=$.hori.getconfig();
	var oaServerName=localStorage.getItem("oaServerName");
	var serverUrl=config.appServerHost;
	var dataSource=
	serverUrl+ "view/oa/phonenumberrequest/Produce/WeboaConfig.nsf/telSearchForm?openform&svrName="+oaServerName+"&queryStr="+username+"&dbFile=Produce/DigiFlowOrgPsnMng.nsf&showField=UserDeptPhone";
	
	
	$.hori.invokeClientRequest({
		
		url:dataSource,
		success:function(res){
			app.render(res);
		},
		dataType:"text"
	});
};

app.render=function(jsonData){
	var viewModel=app.viewModel(jsonData);

	ko.applyBindings(viewModel);
};

$(document).ready(function(){
	$.hori.registerEvent("case", "navButtonTouchUp", function(oper) {
		app.searchContact();
	});
	
});
