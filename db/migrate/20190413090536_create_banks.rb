class CreateBanks < ActiveRecord::Migration[5.1]
  def change
    create_table :banks, id: :uuid do |t|
      t.string :name
      t.string :bic
      t.string :country_code

      t.timestamps
    end
    add_index :banks, :bic, unique: true
    add_index :banks, [:name, :country_code], unique: true
  end
end
