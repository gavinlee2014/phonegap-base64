// window.plugins.Base64

function Base64() {
}


Base64.prototype.encodeFile = function(filePath, sucess, failure) {
	var args = {};
	args.filePath = filePath;
	cordova.exec(sucess, failure, "Base64", "encodeFile", [args]);
}

Base64.prototype.encodeString = function(content, sucess, failure) {
	var args = {};
	args.content = content;
	cordova.exec(sucess, failure, "Base64", "encodeString", [args]);
}

cordova.addConstructor(function()  {
	if(!window.plugins)
	{
		window.plugins = {};
	}
	
   // shim to work in 1.5 and 1.6
   if (!window.Cordova) {
   	window.Cordova = cordova;
   };
   
   window.plugins.Base64 = new Base64();
});