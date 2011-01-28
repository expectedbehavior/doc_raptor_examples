// this function is based on code found:
// http://www.filamentgroup.com/lab/jquery_plugin_for_requesting_ajax_like_file_downloads/
// to easily make a form and POST it
var download = function(url, data, method){
  //url and data options required
  if( url && data ){ 
    jQuery('<form style="display: none" id="dr_submission" action="' + url
           + '" method="' + (method||'post') + '">'
           + '</form>').appendTo('body');
    //credentials
    jQuery('form#dr_submission').append('<textarea name="user_credentials"></textarea>');
    jQuery('form#dr_submission textarea[name=user_credentials]').val(data.user_credentials);
    
    //doc values
    for(var key in data.doc) {
      jQuery('form#dr_submission').append('<textarea name="doc['+key+']"></textarea>');
      jQuery('form#dr_submission textarea[name="doc['+key+']"]').val(data.doc[key]);
    }

    //submit the form
    if(confirm("press ok")) {jQuery('form#dr_submission').submit().remove(); }
  };
};

// setup the string represeting the html we want to submit
var content = '<table name="foo"><tr><td>word up</td></tr></table><textarea>Foo&nbsp;&nbsp;&trade;&nbsp;&nbsp;Bar</textarea><p>What happens to +\'s?</p>';

var data = {
  doc: {
    test: true,
    document_type: 'pdf',
    name: 'adoc',
    document_content: content,
    strict: 'none'
  },
  user_credentials: "YOUR_API_KEY"
};

// this drops a form on the page and submits, which will result in a download dialog popping up
download("http://docraptor.com/docs.xls", data);