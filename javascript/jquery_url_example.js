// this function is based on code found:
// http://www.filamentgroup.com/lab/jquery_plugin_for_requesting_ajax_like_file_downloads/
// to easily make a form and POST it
var download = function(url, data, method){
  //url and data options required
  if(url && data){
    //data can be string of parameters or array/object
    data = jQuery.param(data);

    // make the entire request against a url instead of as form params
    url += '?' + data

    //send request
    jQuery('<form style="display: none" action="' + url
           + '" method="' + (method||'post') + '">'
           + '</form>').appendTo('body').submit().remove();
  }
};

// setup the string represeting the html we want to submit
var content = '<table name="foo"><tr><td>word up</td></tr></table><textarea>Foo&nbsp;&nbsp;&trade;&nbsp;&nbsp;Bar</textarea>';

var data = {
  doc: {
    test: true,
    document_type: 'pdf',
    name: 'adoc',
    document_content: content,
    strict: 'none'
  },
  user_credentials: 'YOUR_API_KEY_HERE'
};

// this drops a form on the page and submits, which will result in a download dialog popping up
download("http://docraptor.com/docs", data);