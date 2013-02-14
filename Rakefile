path = File.realpath(File.dirname(__FILE__))
npm = "./node_modules/.bin"

requested_files = ARGV.reject {|arg| arg.match(/=/) or !arg.match(/\.(js|coffee)/) }
requested_files = false if requested_files.length == 0

desc 'Build project'
task :build do
  files = (requested_files or FileList["#{path}/**/*.coffee"]).map{ |file| file.gsub path, '.' }.join ' '
  Dir.chdir path do
    sh "#{npm}/coffee -c #{files}"
  end
end

desc 'Run tests'
task :test => :build do
  test_files = (requested_files or FileList["#{path}/**/*.spec.js"]).map{ |file| file.gsub(path, '.').gsub('.coffee', '.js') }.join ' '
  Dir.chdir path do
    sh "#{npm}/mocha #{test_files}"
  end
end
