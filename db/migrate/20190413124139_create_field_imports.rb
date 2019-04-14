class CreateFieldImports < ActiveRecord::Migration[5.1]
  def change
    create_table :field_imports, id: :uuid do |t|
      t.belongs_to :template_import, foreign_key: true, type: :uuid
      t.belongs_to :field, foreign_key: true, type: :uuid
      t.jsonb :rule

      t.timestamps
    end
    add_index :field_imports, [:template_import_id, :field_id], unique: true
  end
end
