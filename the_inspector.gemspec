PKG_FILES = ["MIT-LICENSE", "Rakefile", "README.textile", "lib/bad_mysql.rb", "lib/version.rb", "doc/jamis.rb"]

Gem::Specification.new do |s|
  s.name = 'bad_mysql'
  s.version = "0.1.0"
  s.summary = 'Low rent transactional ddl for MySQL'
  s.description = "This is for all of you out there on mysql who envy postgresql's transactional ddl"
  s.files = PKG_FILES
  s.require_path = 'lib'
  s.has_rdoc = true
  s.extra_rdoc_files = ['README.textile', 'MIT-LICENSE', 'TODO', 'CHANGELOG']
  s.rdoc_options = ['--line-numbers', '--inline-source', '--main', 'README.textile', '--title', 'BadMySQL']
  s.author = 'Chad Humphries'
  s.email = 'chad@thinkrelevance.com'
  s.homepage = 'http://github.com/relevance/bad-mysql'
  
  s.add_runtime_dependency 'activerecord'
  s.add_development_dependency 'rspec'
end