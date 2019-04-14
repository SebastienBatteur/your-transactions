class CreateTemplateImports < ActiveRecord::Migration[5.1]
  def change
    create_table :template_imports, id: :uuid do |t|
      t.string :name
      t.belongs_to :bank, foreign_key: true, type: :uuid
      t.integer :type
      t.jsonb :global_rule

      t.timestamps
    end
  end
end
