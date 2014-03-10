require 'bundler/setup'
require 'fileutils'
require 'closure-compiler'
task 'test' => ['racc'] do
  sh 'prove'
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
    sh "uglifyjs -o lib/brandaid/public/#{file} --source-map lib/brandaid/public/#{file}.map #{file}"
    end
end

task 'closure' => ['coffee'] do
  Dir.glob("js/*.js").each do |file|
    puts "Running the Google Closure compiler on: #{file}"
    output = Closure::Compiler.new.compile_file(file)
    map = "js/#{File.basename(file, ".js")}.map"
    FileUtils.cp(map, "#{file}.map")
    # output = File.read(file)
    File.open("lib/brandaid/public/#{file}", "w") do |fh|
      fh.print output
    end
  end
end
