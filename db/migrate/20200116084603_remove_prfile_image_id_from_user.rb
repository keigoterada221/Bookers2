class RemovePrfileImageIdFromUser < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :prfile_image_id, :string
  end
end
