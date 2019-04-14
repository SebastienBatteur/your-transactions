class Transaction < ApplicationRecord
  belongs_to :user
  belongs_to :account
  belongs_to :contreparte, class_name: 'Account'
end
