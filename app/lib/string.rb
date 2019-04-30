class String
    def my_send(function:, arguments:[])
        case function
        when "gsub", "sub"
            return self.send(function, arguments[0].to_regexp, arguments[1])
        when "match"
            result = self.send(function, arguments[0].to_regexp)[1]
            return result[1] ? result : ""
        when "Date.strptime"
            return Date.strptime(self, arguments[0])
        else
            return self.send(function, *arguments)
        end
    end
end