class CreateTemplateImports < ActiveRecord::Migration[5.1]
  def change
    create_table :template_imports, id: :uuid do |t|
      t.string :name
      t.belongs_to :bank, foreign_key: true, type: :uuid
      t.string :language_code
      t.integer :source
      t.jsonb :rule

      t.timestamps
    end
  end
end
