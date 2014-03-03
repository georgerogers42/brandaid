require 'bundler/setup'
require 'coffee-script'
task 'test' do
  sh './test/runner | tapout'
end

task 'default' => ['test', 'uglify']

task 'coffee' do
  sh "coffee -m -o js -c coffee"
end

task 'uglify' => ['coffee'] do
  sh "uglifyjs  js/*.js -o public/js/app.js"
end
