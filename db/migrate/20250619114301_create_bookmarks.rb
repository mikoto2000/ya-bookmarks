class CreateBookmarks < ActiveRecord::Migration[8.0]
  def change
    create_table :bookmarks, id: :uuid do |t|
      t.references :account, null: false, foreign_key: true, type: :uuid
      t.references :page, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
