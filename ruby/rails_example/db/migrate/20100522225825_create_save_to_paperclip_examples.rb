class CreateSaveToPaperclipExamples < ActiveRecord::Migration
  def self.up
    create_table :save_to_paperclip_examples do |t|
      t.string   :document_content
      t.string   :document_name
      t.string   :document_type
      t.boolean  :test, :default => false, :allow_nil => false
      
      t.string   :document_file_name
      t.string   :document_content_type
      t.integer  :document_file_size
      t.datetime :document_updated_at
      
      t.timestamps
    end
  end

  def self.down
    drop_table :save_to_paperclip_examples
  end
end
