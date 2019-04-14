class Account < ApplicationRecord
  belongs_to :user
  belongs_to :bank
  belongs_to :category
  belongs_to :address

  has_many :transactions
  has_many :transactions, foreign_key: 'contreparte_id'

  enum type: [:personnal, :buiseneser]
end
