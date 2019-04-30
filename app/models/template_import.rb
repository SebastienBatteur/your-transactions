class TemplateImport < ApplicationRecord
  belongs_to :bank

  has_many :field_imports

  enum source: [:csv, :html, :api]

  include ExtractValueModule
end
