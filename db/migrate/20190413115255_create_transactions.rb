class CreateTransactions < ActiveRecord::Migration[5.1]
  def change
    create_table :transactions, id: :uuid do |t|
      t.belongs_to :user, foreign_key: true, type: :uuid
      t.belongs_to :account, foreign_key: true, type: :uuid
      t.belongs_to :contreparte, foreign_key: {to_table: "accounts"}, type: :uuid
      t.string :reference
      t.decimal :amount, precision: 10, scale: 2
      t.string :currency
      t.timestamp :value_date
      t.timestamp :execution_date
      t.string :type
      t.string :communication
      t.jsonb :raw

      t.timestamps
    end
    add_index :transactions, [:user_id, :reference], unique: true
  end
end
