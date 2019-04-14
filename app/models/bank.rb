class Bank < ApplicationRecord
    has_many :accounts
    has_many :template_imports
end
