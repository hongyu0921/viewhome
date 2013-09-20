(function(app){
app.viewModel=function(data){
	var jsonData=JSON.parse(data);
	
	var mapping={"href":{
		update:function(options){
			var config=$.hori.getconfig();
			var targetURL= config.appServerHost;
			
			
			var docunid=options.data;
			var oaMsgUrl=targetURL+"view/oa/newscontent/Application/DigiFlowInfoPublish.nsf/InfoByDateView_2/"+docunid+"?OpenDocument&login";
			return oaMsgUrl;
		}
	}};
	var viewModel=ko.mapping.fromJS(jsonData,mapping);
	
	return viewModel;


}
})(app)
