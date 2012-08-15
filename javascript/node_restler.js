var sys  = require("util"),
    fs   = require("fs"),
    rest = require("restler"),
    p    = console.log;

rest.postJson("https://docraptor.com/docs", {
  user_credentials: "YOUR_API_KEY_HERE",
  doc: {
    document_content: "<!DOCTYPE html><html><head><title>Javascript PDF Sample</title></head><body>Hello from Javascript!</body></html>",
    name:             "doc_raptor_sample.pdf",
    document_type:    "pdf",
    test:             true
  }
}).on("success", function(data, response) {
  fs.writeFile("javascript_sample.pdf", response.raw, "binary", function(err){if(err) throw err;});
  p("Success Creating Document");
  p("Check out \"javascript_sample.pdf\" in this directory");
}).on("fail", function(data, response) {
  p("Failure Creating Document");
  p(data);
}).on("error", function(err, response) {
  p("Error Creating Document");
  p(err);
});
