class CreateAccounts < ActiveRecord::Migration[5.1]
  def change
    create_table :accounts, id: :uuid do |t|
      t.string :name
      t.string :iban
      t.belongs_to :user, foreign_key: true, type: :uuid
      t.belongs_to :bank, foreign_key: true, type: :uuid
      t.jsonb :carte_number
      t.integer :type
      t.belongs_to :category, foreign_key: true, type: :uuid
      t.belongs_to :address, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
