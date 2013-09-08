var app=window.app={
};
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
			
			app.render(res);
			$.hori.hideLoading();
			$("#divDataLoading").hide();
		},
		"error":function(res){
			alert(res);
			$.hori.hideLoading();
			$("#divDataLoading").hide();
		}
	});
	
};
app.openDoc=function(src){
	var oaurl=src.name;
	localStorage.setItem("oaDataSource",oaurl);
	var targetURL= $.hori.getconfig().serverBaseUrl+"viewhome/html/unreadShowForm.html";
	targetURL=encodeURI(targetURL);
	
	$.hori.loadPage(targetURL);
};
app.render=function(jsonData){
	var viewModel=app.viewModel(jsonData);
	
	ko.applyBindings(viewModel);
};
$(document).ready(function(){
	var hori=$.hori;
	$.hori.showLoading();
	hori.setHeaderTitle("未读消息");
	var config=$.hori.getconfig();
	var itcode=localStorage.getItem("itcode");

	var oaMsgServer=config.oaMsgServer;
	var serverUrl=config.appServerHost;
	var dataSource=
	serverUrl+'view/oamobile/messagelist/Produce/DigiFlowMobile.nsf/agGetMsgViewData?openagent&login&server='+oaMsgServer+'&dbpath=DFMessage/dfmsg_'+itcode+'.nsf&view=vwMsgUnRdForMobile&thclass=&page=1&count=20';

	app.getData({
		"dataSource":dataSource
	});
});
