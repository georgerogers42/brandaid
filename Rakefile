require 'bundler/setup'
require 'coffee-script'
task 'test' do
  sh './test/runner | tapout'
end

task 'default' => ['test', 'coffee']

task 'coffee' do
  sh "coffee -o js -c coffee"
end
