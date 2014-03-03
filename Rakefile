require 'bundler/setup'
require 'closure-compiler'
task 'test' do
  sh './test/runner | tapout'
end

task 'default' => ['test', 'uglify']

task 'coffee' do
  sh "coffee -m -o js -c coffee"
end

task 'uglify' => ['coffee'] do
  Dir.glob("js/*.js").each do |file|
    output = Closure::Compiler.new.compile_file(file)
    File.open("public/#{file}", "w") do |fh|
      fh.print output
    end
  end
end
