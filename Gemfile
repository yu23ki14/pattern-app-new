source 'https://rubygems.org'


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '5.2.1'
# Use sqlite3 as the database for Active Record
#gem 'sqlite3'
gem 'pg', '0.21.0'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0.6'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
# Use slim for markup
gem 'slim-rails', '3.1.1'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails', '4.3.3'
gem 'jquery-turbolinks', '2.1.0'
# Use reactjs as the JavaScript library
gem 'react-rails', '~> 2.2.0'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks', '5.2.0'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

#Use devise as login
gem 'devise', '4.5.0'

#use by_star as picking record by date
gem 'by_star', :git => "git://github.com/radar/by_star"

#use gon as sender of valiables
gem 'gon', '6.2.1'

#use seed-fu as db seed
gem 'seed-fu', '2.3.9'

#use ransack as serch
gem 'ransack', '2.0.1'

gem 'google-analytics-rails', '1.1.1'

#use newrelic as service surveillance
gem 'newrelic_rpm', '5.4.0.347'

#use wicked pdf as pdf export
gem 'wkhtmltopdf-binary', '0.12.4'
gem 'wicked_pdf', '1.1.0'

#use dotenv as secret valiables
gem 'dotenv-rails', '2.5.0'

#use whenever as crond
gem 'whenever', '0.10.0'

#use kaminari for pagenation
gem "kaminari", '1.1.1'

#use minimagick for image processing
gem 'mini_magick', '~> 4.8'
gem 'image_processing', '~> 1.2'

#use alexa
#gem 'alexa_rubykit'

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Unicorn as the app server

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'
end

group :production do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'unicorn-rails', '2.2.1'
  gem "aws-sdk-s3", require: false
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'
  gem 'bullet'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  #gem 'spring'
end

