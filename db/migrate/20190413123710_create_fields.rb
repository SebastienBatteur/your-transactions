class CreateFields < ActiveRecord::Migration[5.1]
  def change
    create_table :fields, id: :uuid do |t|
      t.string :name
      t.string :attr
      t.string :model

      t.timestamps
    end
    add_index :fields, :name, unique: true
    add_index :fields, [:attr, :model], unique: true
  end
end
