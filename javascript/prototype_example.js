// this function is based on code found:
// http://www.filamentgroup.com/lab/jquery_plugin_for_requesting_ajax_like_file_downloads/
// to easily make a form and POST it
var download = function(url, data, method){
	//url and data options required
	if( url && data ){ 
		//data can be string of parameters or array/object
		data = typeof data == 'string' ? data : $H(data).toQueryString();
		//split params into form inputs
		var inputs = '';
		data.split('&').each(function(s){ 
			var pair = s.split('=');
      var name = pair.shift();
      var value = pair.join("=");
			inputs+='<textarea name="'+ name +'">'+ value +'</textarea>'; 
		});
		//send request
		$$('body')[0].insert('<form id="DocRaptor-example" style="display: none" action="'+ url +'" method="'+ (method||'post') +'">'+inputs+'</form>');
		$('DocRaptor-example').submit();
		$('DocRaptor-example').remove();
	};
};

// setup the string represeting the table we want to submit
var content = '<table name="foo"><tr><td>word up</td></tr></table>';

// this drops a form on the page and submits, which will result in a download dialog popping up
download("http://docraptor.com/docs.xls", "doc[document_content]=" + content + "&doc[name]=adoc&user_credentials=<YOUR_API_KEY_HERE>");
