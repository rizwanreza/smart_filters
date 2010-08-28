require 'rake'
require 'rake/rdoctask'
require 'rake/gempackagetask'

desc 'Generate documentation for the smart_filters plugin.'
Rake::RDocTask.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title    = 'SmartFilters'
  rdoc.options << '--line-numbers' << '--inline-source'
  rdoc.rdoc_files.include('README.md')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

PKG_FILES = FileList[
  '[a-zA-Z]*',
  'app/**/*',
  'lib/**/*',
  'rails/**/*',
  'spec/**/*'
]

spec = Gem::Specification.new do |s|
  s.name = "smart_filters"
  s.version = "0.0.1"
  s.author = "Rizwan Reza"
  s.email = "contact@rizwanreza.com"
  s.homepage = "http://github.com/Monaqasat/smart_filters"
  s.platform = Gem::Platform::RUBY
  s.summary = "Quickly create smart filters for any ActiveRecord model."
  s.files = PKG_FILES.to_a
  s.description = "Smart Filters is an implementation of what you see in the Smart Playlist dialog in iTunes but using ActiveRecord model as the table and columns as the data. It is wise enough to select different criteria based on the column type."
  s.require_path = "lib"
  s.has_rdoc = false
  s.extra_rdoc_files = ["README.md"]
end

desc 'Turn this plugin into a gem.'
Rake::GemPackageTask.new(spec) do |pkg|
  pkg.gem_spec = spec
end