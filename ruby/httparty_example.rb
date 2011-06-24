class Doc
  API_KEY = "YOUR_API_KEY_HERE"
  require 'rubygems'
  require 'httparty'
  include HTTParty
  base_uri "https://docraptor.com"

  # returns a string that is the document data
  def self.create(document_information)
    post("/docs", :body => {:doc => document_information}, :basic_auth => {:username => API_KEY})
  end
end

xls_xml = "<table name='My First Sheet'><tr><td>Cell 1</td><td>Cell 2</td></tr></table>"
File.open("docraptor_sample.xls", "wb") do |f|
  f.write Doc.create(:document_content => xls_xml,
                     :name             => "doc_raptor_sample.xls",
                     :document_type    => "xls",
                     :test             => true)
end

pdf_html = '<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"><html lang="en"><body><a href="http://google.com">google</a></body></html>'
File.open("docraptor_sample.pdf", "wb") do |f|
  f.write Doc.create(:document_content => pdf_html,
                     :name             => "doc_raptor_sample.pdf",
                     :document_type    => "pdf",
                     :test             => true)
end
