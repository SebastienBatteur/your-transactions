class SwiftValidator < ActiveModel::EachValidator
    def validate_each(record, attribute, value)
        swift = ISO::SWIFT.new(value)
        unless swift.valid?
            record.errors[attribute] << (options[:message] || swift.errors)
        end
    end
end