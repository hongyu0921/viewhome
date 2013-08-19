var app=window.app={
}
app.getData=function(args){
	var dataSource=args.dataSource;
	//调用ajax 获取远程数据
	$.ajax({
		//url 正常是args.dataSource 测试临时改为取当前目录的json数据
		url:"../lib/app/contact/contact.json",
		success:function(res){
			app.render(res);
		},
		dataType:"text"
	})
}
var vw=ko.observableArray([{"title":"sss","url":"http://www.baidu.com"}]);
app.render=function(jsonData){
	var viewModel=app.viewModel(jsonData);
	//ko.applyBingds(vw);
			ko.applyBindings(viewModel);
}
$(document).ready(function(){

	var config=$.hori.getconfig();
	var itcode=localStorage.getItem("itcode");
	if(itcode!=null){

		alert(itcode)
		itcode=decrypt(config.encryptKey,itcode);
	}
	var oaServerName=localStorage.getItem("oaServerName");
	var serverUrl=localStorage.getItem("appServerUrl");
	var dataSource=
	serverUrl+'/view/oa/todosmobile/Produce/DigiFlowMobile.nsf/agGetMsgViewData?openagent&login&server='+oaServerName+'&dbpath=DFMessage/dfmsg_'+itcode+'.nsf&view=vwTaskUnDoneForMobile&thclass=&page=1&count=20';

	app.getData({
		"dataSource":dataSource
	})
})
