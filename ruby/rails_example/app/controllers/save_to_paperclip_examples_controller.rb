class SaveToPaperclipExamplesController < ApplicationController

  def index
    @save_to_paperclip_examples = SaveToPaperclipExample.all
    
    # Don't forget to reigster the xls/pdf mime types in config/initializers/mime_types.rb
    respond_to do |format|
      format.html
      format.xls { send_data Doc.create(:name => "example_xls", :document_content => render_to_string, :document_type => "xls") }
      format.pdf { send_data Doc.create(:name => "example_pdf", :document_content => render_to_string, :document_type => "pdf") }
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
  
end
