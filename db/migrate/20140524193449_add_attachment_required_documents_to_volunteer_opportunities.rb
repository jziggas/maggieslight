class AddAttachmentRequiredDocumentsToVolunteerOpportunities < ActiveRecord::Migration
  def self.up
    change_table :volunteer_opportunities do |t|
      t.attachment :required_documents
    end
  end

  def self.down
    drop_attached_file :volunteer_opportunities, :required_documents
  end
end
