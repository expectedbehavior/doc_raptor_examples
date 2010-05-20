/*
 * Doc Raptor simple PHP example
 * requires pecl_http extension
 *
 * This is a simple example of creating an excel file and saving it
 * using Doc Raptor
 *
 * For other usage and examples, visit:
 * http://docraptor.com/examples
 *
 * Doc Raptor        http://docraptor.com
 * Expected Behavior http://www.expectedbehavior.com
 */

<?php

$api_key = "YOUR_API_KEY_HERE";
$url = "https://docraptor.com/docs?user_credentials=$api_key";

$document_content = "<table><tr><td>Cell</td></tr></table>";

$request = new HTTPRequest($url, HTTP_METH_POST);
$request->setPostFields(array('doc[document_content]' => $document_content, 
                              'doc[document_type]'    => 'xls',
                              'doc[name]'             => 'my_doc.xls',
                              'doc[test]'             => 'true'));
$request->send();

$file = fopen ("my_excel_doc.xls", "w"); 
fwrite($file, $request->getResponseBody()); 
fclose ($file);

?>

 
