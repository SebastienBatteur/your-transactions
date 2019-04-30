source 'https://rubygems.org'
git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end
ruby '2.4.0'
gem 'rails', '~> 5.1.7'
gem 'puma', '~> 3.7'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.2'
gem 'jbuilder', '~> 2.5'
group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'capybara', '>= 2.15'
  gem 'selenium-webdriver'
end
group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
gem 'administrate'
gem 'bootstrap', '~> 4.3.1'
gem 'bourbon'
gem 'devise'
gem 'high_voltage'
gem 'jquery-rails'
gem 'slim-rails'
group :development do
  gem 'better_errors'
  gem 'hub', :require=>nil
  gem 'rails_layout'
end
group :development, :test do
  gem 'pry-rails'
  gem 'pry-rescue'
  gem 'rubocop'
  gem 'pg'
  gem 'table_print', '~> 1.5', '>= 1.5.6'
end
group :production do
  gem 'pg'
end
gem 'to_regexp'

# validation and more information bic-code or swift code
gem 'iso-swift', git: 'https://github.com/rwehresmann/iso-swift.git'
gem 'countries'
gem 'ibandit', '~> 0.11.27'


gem 'simple_form', '~> 4.1'
gem 'country_select', '~> 4.0'
# gem 'simple_form_language_input'