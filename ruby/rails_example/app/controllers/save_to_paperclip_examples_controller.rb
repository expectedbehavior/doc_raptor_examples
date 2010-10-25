class SaveToPaperclipExamplesController < ApplicationController

  def index
    @save_to_paperclip_examples = SaveToPaperclipExample.all
    
    # Don't forget to reigster the xls/pdf mime types in config/initializers/mime_types.rb
    respond_to do |format|
      format.html
      format.xls { doc_raptor_send }
      format.pdf { doc_raptor_send }
    end
  end
  
  def new
    @save_to_paperclip_example = SaveToPaperclipExample.new
  end

  def create
    @save_to_paperclip_example = SaveToPaperclipExample.new(params[:save_to_paperclip_example])

    if @save_to_paperclip_example.save
      flash[:notice] = 'Example was successfully created.'
      redirect_to save_to_paperclip_examples_url
    else
      render :action => "new"
    end
  end

  def destroy
    @save_to_paperclip_example = SaveToPaperclipExample.find(params[:id])
    @save_to_paperclip_example.destroy
  
    redirect_to save_to_paperclip_examples_url
  end
  
  def doc_raptor_send(options = { })
    default_options = { 
      :name             => controller_name,
      :document_type    => request.format.to_sym,
      :test             => ! Rails.env.production?,
    }
    options = default_options.merge(options)
    options[:document_content] ||= render_to_string
    ext = options[:document_type].to_sym
    
    response = DocRaptor.create(options)
    if response.code == 200
      send_data response, :filename => "#{options[:name]}.#{ext}", :type => ext
    else
      render :inline => response.body, :status => response.code
    end
  end

end
