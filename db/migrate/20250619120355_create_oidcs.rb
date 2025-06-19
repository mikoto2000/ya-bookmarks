class CreateOidcs < ActiveRecord::Migration[8.0]
  def change
    create_table :oidcs, id: :uuid do |t|
      t.string :issuer
      t.string :sub
      t.references :account, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
