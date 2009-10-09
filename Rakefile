# Copyright 2008 Chad Humphries
# All rights reserved
 
# This file may be distributed under an MIT style license.
# See MIT-LICENSE for details.
 
begin
  require 'rubygems'
  require 'rake/gempackagetask'
  require 'rake/testtask'
  require 'spec/rake/spectask'
rescue Exception
  nil
end
 
CURRENT_VERSION = '0.1.0'
$package_version = CURRENT_VERSION
 
PKG_FILES = FileList['[A-Z]*',
'lib/**/*.rb',
'doc/**/*'
]
 
if !defined?(Spec)
  puts "spec and cruise targets require RSpec"
else
  desc "Run all examples with RCov"
  Spec::Rake::SpecTask.new('cruise') do |t|
    t.spec_files = FileList['spec/**/*.rb']
    t.rcov = true
    t.rcov_opts = ['--exclude', 'spec', '--exclude', 'Library']
  end
 
  desc "Run all examples"
  Spec::Rake::SpecTask.new('spec') do |t|
    t.spec_files = FileList['spec/**/*.rb']
    t.rcov = false
    t.spec_opts = ['-cfs']
  end
end
 
task :default => [:spec]
