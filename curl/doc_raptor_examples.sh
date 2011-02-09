#This example will create a sample excel document with the authentication information as part of the POST data
curl -H "Content-Type:application/json" -d'{"user_credentials":"YOUR_API_KEY_HERE", "doc":{"name":"docraptor_sample.xls", "document_type":"xls", "test":"true", "document_content":"<table name=\"My First Sheet\"><tr><td>Cell 1</td><td>Cell 2</td></tr></table>"}}' http://docraptor.com/docs > docraptor_sample.xls

#This example will create a sample excel document with the authentication information as part of the URL
curl -H "Content-Type:application/json" -d'{"doc":{"name":"docraptor_sample.xls", "document_type":"xls", "test":"true", "document_content":"<table name=\"My First Sheet\"><tr><td>Cell 1</td><td>Cell 2</td></tr></table>"}}' http://docraptor.com/docs?user_credentials=YOUR_API_KEY_HERE > docraptor_sample.xls

#This example will create a sample pdf document with the authentication information as part of the POST data
curl -H "Content-Type:application/json" -d'{"user_credentials":"YOUR_API_KEY_HERE", "doc":{"name":"docraptor_sample.pdf", "document_type":"pdf", "test":"true", "document_content":"<html><body>Text in a PDF</body></html>"}}' http://docraptor.com/docs > docraptor_sample.pdf

#This example will create a sample pdf document with the authentication information as part of the URL
curl -H "Content-Type:application/json" -d'{"doc":{"name":"docraptor_sample.pdf", "document_type":"pdf", "test":"true", "document_content":"<html><body>Text in a PDF</body></html>"}}' http://docraptor.com/docs?user_credentials=YOUR_API_KEY_HERE > docraptor_sample.pdf
