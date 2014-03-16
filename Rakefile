require 'bundler/setup'
require 'fileutils'
task 'test' => ['racc', 'uglify'] do
  sh 'prove'
end

task 'build' => ['test']

task 'coffee' do
  Dir.glob "coffee/*.js" do |file|
    FileUtils.cp file, "js/src"
  end
  sh "coffee -o js/src -c coffee"
end

task 'racc' do
  sh 'racc lib/**/*.y'
end

task 'uglify' => ['coffee'] do
  files = nil
  Dir.chdir "js" do
   files = Dir.glob("src/*.js").map(&File.method(:expand_path))
  end
  files.each do |file|
    sh "uglifyjs -o js/#{File.basename file}.min.js js/src/#{File.basename(file)}"
    FileUtils.cp "js/#{File.basename file}.min.js", "lib/brandaid/public/js"
    FileUtils.cp "js/#{File.basename file}.map", "lib/brandaid/public/js/js"
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
