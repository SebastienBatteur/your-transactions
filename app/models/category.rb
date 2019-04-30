class Category < ApplicationRecord
    has_many :accounts
    has_many :transactions
end
