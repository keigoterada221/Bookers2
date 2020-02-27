class CreateBooks < ActiveRecord::Migration[5.2]
  def change
    create_table :books do |t|
      t.string :user_id
      t.text :title
      t.text :body

      t.timestamps
    end
  end
end
