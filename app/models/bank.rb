class Bank < ApplicationRecord
    has_many :accounts
    has_many :template_imports

    validates :bic, uniqueness: true
    validates :name, presence: true
    validates :bic, presence: true


    def swift
        bic
    end

    def swift=(value)
        bic = ISO::SWIFT.new(value)
        if bic.valid?
            self.bic = bic.formatted
            if self.name.blank?
                if _bic.bank_name.blank?
                    self.name = self.bic
                else
                    self.name = bic.bank_name
                end
            end
        end
    end

    def more
        ISO::SWIFT.new(bic)
    end
  
end
