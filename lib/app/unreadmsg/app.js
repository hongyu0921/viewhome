var app=window.app={
};
app.getData=function(args){
	var dataSource=args.dataSource;
	$.hori.invokeClientRequest({
		"type":"post",
		"url":dataSource,
		"data":"",
		"success":function(res){
			app.render(res);
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
	
	hori.setHeaderTitle("未读消息");
	var config=$.hori.getconfig();
	var itcode=localStorage.getItem("itcode");
	if(itcode!=null){

		
		itcode=decrypt(config.encryptKey,itcode);
	}
	var oaServerName=localStorage.getItem("oaServerName");
	var serverUrl=config.appServerHost;
	var dataSource=
	serverUrl+'view/oa/messagelist/Produce/DigiFlowMobile.nsf/agGetMsgViewData?openagent&login&server='+oaServerName+'&dbpath=DFMessage/dfmsg_'+itcode+'.nsf&view=vwMsgUnRdForMobile&thclass=&page=1&count=20';

	app.getData({
		"dataSource":dataSource
	});
});
