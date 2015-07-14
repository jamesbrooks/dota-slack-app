class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users, id: :uuid do |t|
      t.string :steam_id, null: false, index: true

      t.string :name
      t.string :avatar_url

      t.timestamps null: false
    end
  end
end
