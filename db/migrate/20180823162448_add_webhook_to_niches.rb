class AddWebhookToNiches < ActiveRecord::Migration[5.2]
  def change
    add_column :niches, :url, :string
  end
end
