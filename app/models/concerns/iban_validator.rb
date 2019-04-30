class IbanValidator < ActiveModel::EachValidator
    def validate_each(record, attribute, value)
        iban = Ibandit::IBAN.new(value)
        unless iban.valid?
            record.errors[attribute] << (options[:message] || iban.errors)
        end
    end
end