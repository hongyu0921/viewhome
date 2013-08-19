(function(app){
app.viewModel=function(data){
	var jsonData=JSON.parse(data);
	var mapping={};
	var viewModel=ko.mapping.fromJS(jsonData);
	return viewModel;


}
})(app)
