require 'bundler/setup'
require 'closure-compiler'
task 'test' => ['racc', 'uglify'] do
  sh 'prove'
end

task 'default' => ['test']

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
    # output = File.read(file)
    File.open("lib/brandaid/public/#{file}", "w") do |fh|
      fh.print output
    end
  end
end
