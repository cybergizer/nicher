class AddAttachmentsToItems < ActiveRecord::Migration[5.2]
  def change
    add_column :items, :attachments, :json
  end
end
