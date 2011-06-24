require 'rubygems'
require 'doc_raptor'

DocRaptor.api_key "YOUR_API_KEY_HERE"

xls_html = "<table name='My First Sheet'><tr><td>Cell 1</td><td>Cell 2</td></tr></table>"
File.open("docraptor_sample.xls", "w+b") do |f|
  f.write DocRaptor.create(:document_content => xls_html,
                           :name             => "doc_raptor_sample.xls",
                           :document_type    => "xls",
                           :test             => true)
end

pdf_html = '<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"><html lang="en"><body><a href="http://google.com">google</a></body></html>'
File.open("docraptor_sample.pdf", "w+b") do |f|
  f.write DocRaptor.create(:document_content => pdf_html,
                           :name             => "doc_raptor_sample.pdf",
                           :document_type    => "pdf",
                           :test             => true)
end
