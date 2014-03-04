require 'bundler/setup'
require 'closure-compiler'
task 'test' => ['racc'] do
  sh './test/runner | tapout'
end

task 'default' => ['racc', 'uglify', 'test']

task 'coffee' do
  sh "coffee -m -o js -c coffee"
end

task 'racc' do
  sh 'racc lib/**/*.y'
end

task 'uglify' => ['coffee'] do
  Dir.glob("js/*.js").each do |file|
    puts "Running the Google Closure compiler on: #{file}"
    output = Closure::Compiler.new.compile_file(file)
    File.open("lib/brandaid/public/#{file}", "w") do |fh|
      fh.print output
    end
  end
end
