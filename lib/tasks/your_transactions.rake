namespace :your_transactions do
  desc "TODO"
  task import_csv_belfius: :environment do
    file = "../data/BE70 0639 7966 0225 2019-04-05 15-38-06 1.csv"
    bank = Bank.find_by_name("Belfius")
    template = bank.template_imports.find_by_source('csv')
    csv_txt = File.read(file , encoding: template.rule["encoding"])
    
    csv_content = csv_txt.sub /.*\r\n;\r\n/m, ''
    CSV.parse(csv_content, encoding:template.rule["encoding"], col_sep: template.rule["col_sep"], row_sep: template.rule["row_sep"], quote_char: template.rule["quote_char"], headers: template.rule["headers"]) do |row|
      sf = b.template_imports.first.field_imports.first
    end
  end

  desc "TODO"
  task import_csv_fortis: :environment do
  end

end
