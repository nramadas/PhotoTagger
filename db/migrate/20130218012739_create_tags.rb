class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.integer :image_id
      t.integer :user_id
      t.string  :xpos
      t.string  :ypos

      t.timestamps
    end
  end
end
