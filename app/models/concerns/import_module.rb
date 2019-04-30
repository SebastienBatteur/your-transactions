module ImportModule
    extend ActiveSupport::Concern 
    require 'csv'
    included do
        def self.import(user, account, template, file)
            if account.bank != template.bank
                raise "This model is not associated with this account"
            end
            if template.source == "csv"
                self.import_csv(user, account, template, file)
            end
        end
        def self.import_csv(user, account, template, file)
            rule = template.rule
            csv_txt = File.read(file , encoding: rule["encoding"])
            csv_txt = template.extract_value(csv_txt)
            error = []
            number_update = 0
            number_import = 0
            i = 0
            CSV.parse(csv_txt, encoding: rule["encoding"], col_sep: rule["col_sep"], row_sep: rule["row_sep"], quote_char: rule["quote_char"], headers: rule["headers"]) do |row|
                data = {}
                template.field_imports.each do |f|
                    data[f.field.attr] = f.extract_value(row)
                    # sf = b.template_imports.first.field_imports.first
                end
                update_ref = 0
                import_ref = 0
                p extract: data.inspect
                p row: row.inspect
                if !data['reference'].blank?
                    transaction = Transaction.where(user: user, account: account, reference: data['reference'] )
                    if transaction.blank?
                        transaction = Transaction.new(user: user, account: account, reference: data['reference'] )
                        import_ref = 1
                    else
                        transaction = transaction.first
                        update_ref = 1
                    end
                    transaction.amount = data['amount']
                    transaction.currency = data['currency']
                    transaction.value_date = data['value_date']
                    transaction.execution_date = data['execution_date']
                    transaction.comment = data['comment']
                    transaction.payment_option = data['payment_option']
                    transaction.contreparte_name = data['contreparte_name']
                    unless data['contreparte.iban'].blank?
                        data['contreparte.iban'] = Ibandit::IBAN.new(data['contreparte.iban']).to_s(:formatted)
                        contreparte_account = Account.find_by_iban( data['contreparte.iban'])
                        if contreparte_account.blank?
                            contreparte_account = Account.find_with_name_address(name: transaction.contreparte_name)
                        end
                    else
                        contreparte_account = Account.find_with_name_address(name: transaction.contreparte_name)
                    end
                    if contreparte_account.blank?
                        contreparte_account = Account.new(name: transaction.contreparte_name, iban: data['contreparte.iban'])
                        unless data['contreparte.iban'].blank? || data['contreparte.bank.bic'].blank?
                            data['contreparte.bank.bic'] = data['contreparte.bank.bic'].delete("\n\r\t -").upcase
                            contreparte_bank = Bank.find_by_bic( data['contreparte.bank.bic'])
                            if contreparte_bank.blank?
                                contreparte_bank = Bank.new(swift: data['contreparte.bank.bic'])
                            end
                            contreparte_account.bank = contreparte_bank
                        end
                    end
                    transaction.contreparte = contreparte_account
                    # ToDo
                    # import contrepart address

                            
                        
                else
                    error << "don't find the reference of the transaction ling"
                end
                i += 1
                option = gets
                puts option
            end
        end

    end
end