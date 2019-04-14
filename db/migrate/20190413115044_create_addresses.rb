class CreateAddresses < ActiveRecord::Migration[5.1]
  def change
    create_table :addresses, id: :uuid do |t|
      t.belongs_to :user, foreign_key: true, type: :uuid
      t.string :name
      t.string :street
      t.string :zip
      t.string :location
      t.string :country_code

      t.timestamps
    end
  end
end
