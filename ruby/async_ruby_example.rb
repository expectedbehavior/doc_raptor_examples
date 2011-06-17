require 'rubygems'
require 'doc_raptor'

DocRaptor.api_key "YOUR_API_KEY_HERE"

pdf_html = '<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"><html lang="en"><body><a href="http://google.com">google</a></body></html>'

status_id = DocRaptor.create(:document_content => pdf_html,
                             :name             => "docraptor_sample.pdf",
                             :document_type    => "pdf",
                             :test             => false,
                             :async            => true)

status = { }

status['status'] = 'queued'
while (status['status'] == 'queued' || status['status'] == 'working')
  sleep(10)
  status = DocRaptor.status
end

if status['status'] == 'completed'
  File.open("docraptor_sample.pdf", "w+") do |f| 
    f.write DocRaptor.download
  end
else
  puts "There was an error generating the document:\n#{status['message']}\n"
  puts "#{status['validation_errors']}\n" if status['validation_errors']
end
