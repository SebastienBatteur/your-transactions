# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
#user = CreateAdminService.new.call
#puts 'CREATED ADMIN USER: ' << user.email

field_list = [
    [ 'Reference', 'reference', 'transaction'],
    [ 'Amount', 'amount', 'transaction'],
    [ 'Currency', 'currency', 'transaction'],
    [ 'Action date', 'value_date', 'transaction'],
    [ 'Execution date', 'execution_date', 'transaction'],
    [ 'Type', 'type', 'transaction'],
    [ 'Comment', 'comment', 'transaction'],
    [ 'Account', 'account.iban', 'transaction'],
    [ 'Contreparte account', 'contreparte.iban', 'transaction'],
    [ 'Contreparte name', 'contreparte.name', 'transaction'],
    [ 'Contreparte bic', 'contreparte.bank.bic', 'transaction'],
    [ 'Country code of contreoarte bank', 'contreparte.bank.country_code', 'transaction'],
    [ 'contreparte address name', 'contreparte.address.name', 'transaction'],
    [ 'contreparte address street', 'contreparte.address.street', 'transaction'],
    [ 'contreparte zip code address', 'contreparte.address.zip', 'transaction'],
    [ 'contreparte location', 'contreparte.address.location', 'transaction'],
    [ 'contreparte country code', 'contreparte.address.country_code', 'transaction']
]
field_list.each do | name, attr, model|
    Field.create( name: name, attr: attr, model: model)
  end
