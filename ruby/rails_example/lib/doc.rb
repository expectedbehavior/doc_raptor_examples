class Doc
  include HTTParty
  base_uri "https://docraptor.com"
  API_KEY = "YOUR_API_KEY_HERE"
  
  #when given a block, hands the block a TempFile of the resulting document
  #otherwise, just returns the response
  def self.create(options = { })
    raise "must supply :document_content" if options[:document_content].blank?
    
    default_options = { 
      :name             => "default",
      :document_type    => "xls",
      :test             => false,
    }
    options = options.dup
    options.reverse_merge!(default_options)
    
    response = post("/docs", :body => {:doc => params}, :basic_auth => {:username => API_KEY})
    
    if block_given?
      Tempfile.open("docraptor") do |f|
        #for Paperclip, to get name and content correct
        f.extend(ActionController::UploadedFile)
        f.content_type  = response.headers["content-type"]
        f.original_path = params[:name]
      
        f.sync = true
        f.write(response.body)
        f.rewind

        yield f
      end
    else
      response
    end
  end
  
end
