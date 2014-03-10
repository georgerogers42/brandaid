require 'bundler/setup'
require 'fileutils'
require 'closure-compiler'
task 'test' => ['racc', 'uglify'] do
  sh 'prove'
end

task 'default' => ['test']

task 'coffee' do
  sh "coffee -o js -c coffee"
end

task 'racc' do
  sh 'racc lib/**/*.y'
end

task 'uglify' => ['coffee'] do
  files = nil
  Dir.chdir "js" do
   files = Dir.glob("*.js").map(&File.method(:expand_path))
  end
  files.each do |file|
    system "uglifyjs --source-map js/#{File.basename file}.map -o js/#{File.basename file}.min.js js/#{File.basename(file)}"
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
