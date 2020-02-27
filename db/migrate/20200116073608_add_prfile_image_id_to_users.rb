class AddPrfileImageIdToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :prfile_image_id, :string
  end
end
