class Address < ApplicationRecord
  belongs_to :user
  has_many :accounts
  has_many :transactions
end
