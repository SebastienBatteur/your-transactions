class Account < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :bank, optional: true
  belongs_to :category, optional: true
  belongs_to :address, optional: true

  has_many :transactions
  has_many :transactions, foreign_key: 'contreparte_id'

  enum status: [:personnal, :professional]

  validates :name, uniqueness: { scope: :iban }, :allow_nil => true, :allow_blank => true
  validates :iban, uniqueness: true, :allow_nil => true, :allow_blank => true
  validates :iban, iban: true, unless -> { iban.blank? } 
  validates :name, presence: {message: "The name or iban must be present"}, if: -> { iban.blank? }
  validates :iban, presence: {message: "The name or iban must be present"}, if: -> { name.blank? }

  before_save :format_iban

  def iban_obj
    Ibandit::IBAN.new(iban)
  end

  def self.find_with_name_address()

  end

  private
    def format_iban
      unless self.iban.blank?
        self.iban = Ibandit::IBAN.new(self.iban).to_s(:formatted)
      end
    end
  
 
end
