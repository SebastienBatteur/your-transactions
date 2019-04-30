module ExtractValueModule
    extend ActiveSupport::Concern 
    included do
        def extract_value(data)
            # puts data.inspect
            # puts self.rule.inspect
            # puts data.kind_of?(CSV::Row)
            # puts "1"
            # puts data.kind_of?(Hash)
            # puts "2"
            # puts data.kind_of?(Array)
            # puts "3"
            if self.rule.key?("field") 
                if ( data.kind_of?(Hash) or data.kind_of?(Array) or data.kind_of?(CSV::Row) )
                    if data.key?(self.rule["field"])
                        value = data[self.rule["field"]]
                        @header = data.to_a.map {|row| row[0]}
                    else
                        raise "didn't find field " + self.rule["field"] + "in data"
                    end
                end
            else
                value = data
                @header = []
            end
            if value.nil?
                return nil
            end
            if self.rule.key?("transform")
                transform = Marshal.load( Marshal.dump(self.rule["transform"]) )
                transform.each do |trans|
                    if trans.key?('condition')
                        conditionnal = function(trans["condition"], value, data)
                        if conditionnal
                            if trans.key?('true')
                                value = eval_value(trans['true'] , @header) ? eval(trans['true']) : trans['true']
                            end
                        else
                            if trans.key?('false')
                                value = eval_value(trans['false'] , @header) ? eval(trans['false']) : trans['false']
                            end
                        end
                    elsif trans.key?('function')
                        value = function(trans, value, data)
                    end
                end
            end
            return value
        end
        def function(transform, value, data)
            if transform.key?('arguments')
                transform['arguments'].collect! { |argu|
                    eval_value(argu , @header) ? eval(argu, get_binding(data)) : argu
                }
            else
                transform['arguments'] = []
            end
            return value.my_send(function: transform['function'],arguments: transform['arguments'])
            # @todo
            # return value.my_send(**rule) don't work
        end
        def get_binding(data)
            return binding
        end
        def eval_value(conditional_value, data_key)
            if conditional_value == 'value'
                return true
            end
            result = conditional_value.match(/^data\[ *((['"”](.+)['"”])|(\d+)) *\]$/)
            if result
                if result[3] &&  data_key.include?(result[3])
                    return true
                end
                if result[4] && result[4] < data_key.size && result[4] > 0
                    return true
                end
                return false
            end
            return false
        end
    end
end