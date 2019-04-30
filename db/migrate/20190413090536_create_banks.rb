class CreateBanks < ActiveRecord::Migration[5.1]
  def change
    create_table :banks, id: :uuid do |t|
      t.string :name
      t.string :bic

      t.timestamps
    end
    add_index :banks, :bic, unique: true
  end
end
