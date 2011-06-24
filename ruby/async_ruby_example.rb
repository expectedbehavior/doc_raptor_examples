require 'rubygems'
require 'doc_raptor'

TEN_SECONDS = 10
FIVE_MINUTES = 300

DocRaptor.api_key "YOUR_API_KEY_HERE"

pdf_html = '<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"><html lang="en"><body><a href="http://google.com">google</a></body></html>'

def pretty_time; Time.now.strftime("%I:%M:%S %p"); end
def print_status(status = {}); puts "#{pretty_time} - Status: #{status['status']}";end

status_id = DocRaptor.create(:document_content => pdf_html,
                             :name             => "doc_raptor_sample.pdf",
                             :document_type    => "pdf",
                             :test             => true,
                             :async            => true)

# This timeout is 5 minutes.
# If there is no load on the background processors, this test should take (far) less than 20s. It's possible production will be backed up with real jobs, hence the timeout.
timeout_time = Time.now + FIVE_MINUTES

status = {'status' => 'queued'}

print_status(status)
while !(['completed','failed'].include? status['status']) && Time.now <= timeout_time
  sleep TEN_SECONDS
  status = DocRaptor.status(status_id)
  print_status(status)
end

if status['status'] == 'completed'
  file = DocRaptor.download(status['download_key'])
  File.open("doc_raptor_sample.pdf", "w+b") do |f|
    f.write file.response.body
  end
  puts "#{pretty_time} - File downloaded to doc_raptor_sample.pdf"
end
