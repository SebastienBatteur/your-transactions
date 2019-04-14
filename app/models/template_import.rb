class TemplateImport < ApplicationRecord
  belongs_to :bank

  has_many :field_imports

  enum type: [:csv, :html, :api]
end
