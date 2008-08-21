PKG_FILES = ["MIT-LICENSE", "Rakefile", "README.textile", "lib/the_inspector.rb", "lib/version.rb", "doc/jamis.rb"]

Gem::Specification.new do |s|
  s.name = 'the_inspector'
  s.version = "0.1.0"
  s.summary = 'The Inspector'
  s.description = " "
  s.files = PKG_FILES
  s.require_path = 'lib'
  s.has_rdoc = true
  s.extra_rdoc_files = ['README.textile', 'MIT-LICENSE', 'TODO', 'CHANGELOG']
  s.rdoc_options = ['--line-numbers', '--inline-source', '--main', 'README.textile', '--title', 'The Inspector']
  s.author = 'Chad Humphries'
  s.email = 'chad@thinkrelevance.com'
  s.homepage = 'http://github.com/spicycode/the-inspector'
  
end