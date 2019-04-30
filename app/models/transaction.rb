class Transaction < ApplicationRecord
  belongs_to :user
  belongs_to :account
  belongs_to :contreparte, class_name: 'Account'
  belongs_to :contreparte_address, class_name: 'Address'
  belongs_to :category

  enum payment_option: [
    :unknown,
    :payment, 
    :bancontact_payment, 
    :onlyne_payment, 
    :maestro_payment, 
    :visa_payment, 
    :bank_fees, 
    :cash_withdrawal,
    :transfer,
    :online_transfer,
    :mobile_transfer,
    :registered_office 
  ]

  include ImportModule

end
