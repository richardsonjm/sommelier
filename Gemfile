source 'https://rubygems.org'

ruby '2.2.0'

gem 'rails', '4.2.6'

# Env variables (must be at top)
gem 'dotenv-rails', group: [:development, :test]

# MongoDB adapater
gem 'mongoid', '~> 5.1.0'

# Assets
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.1.0'
gem 'jquery-rails', '~> 4.1.1'
gem 'turbolinks', '~> 2.5.3'
gem 'jquery-datatables-rails', '~> 3.3.0'
gem 'foundation-rails', '~> 6.2.1'

# APIs
gem 'jbuilder', '~> 2.0'
gem 'httparty', '~> 0.13.7'

# Data management
gem 'kaminari'
gem 'money-rails', '~> 1.6.0'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', "~> 8.2.4"
  gem 'rspec-rails', "~> 3.3"
  gem 'mongoid-rspec', '3.0.0'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'
  gem 'spring', '~> 1.7.1'
  gem 'pry-rails', '~> 0.3.3'
  gem 'better_errors', '~> 2.1.1'
  gem 'binding_of_caller', '~> 0.7.2'
end

gem 'rails_12factor', group: :production

# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

# Gems to install outside the Gemfile
# foreman
