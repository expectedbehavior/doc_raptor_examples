class SaveToPaperclipExample < ActiveRecord::Base
  
  validates_presence_of :document_content
  validates_presence_of :document_name
  validates_presence_of :document_type
  validates_presence_of :test
  
  before_save :create_document
  
  def create_document
    Doc.create(:document_content => self.document_content, 
               :document_type    => self.document_type,
               :name             => self.document_name,
               :test             => self.test) do |file|
      self.document = file
    end
  end
    
end
