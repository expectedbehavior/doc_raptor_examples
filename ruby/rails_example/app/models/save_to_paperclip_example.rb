class SaveToPaperclipExample < ActiveRecord::Base
  TYPES = ["xls", "pdf"]
  
  validates_presence_of :document_content
  validates_presence_of :document_name
  validates_presence_of :document_type
  
  has_attached_file :document
  
  before_save :create_document
  
  def create_document
    DocRaptor.create(:document_content => self.document_content, 
                     :document_type    => self.document_type,
                     :name             => self.document_name,
                     :test             => self.test) do |file, response|
      
      file.extend(ActionController::UploadedFile)
      file.content_type  = response.headers["content-type"]
      name = self.document_name.strip.gsub(/\s/, "_").gsub(/\W/, "").underscore.downcase
      file.original_path = "#{name}.#{self.document_type}"
      
      if response.code == 200
        self.document = file
      else
        e = ActiveResource::Errors.new(self) 
        e.from_xml(response.body)
        e.each do |key, value|
          self.errors.add(key, value)
        end
      end
    end

    self.errors.count == 0  #return false if there were any errors
  end
    
end
