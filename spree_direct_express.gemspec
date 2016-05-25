# encoding: UTF-8
$:.push File.expand_path("../lib", __FILE__)
require 'spree_direct_express/version'

Gem::Specification.new do |s|
  s.platform    = Gem::Platform::RUBY
  s.name        = 'spree_direct_express'
  s.version     = SpreeDirectExpress::VERSION
  s.summary     = 'Gem for spree and Direct Express Carrier'
  s.description = 'Gem for spree and Direct Express Carrier'
  s.required_ruby_version = '>= 1.9'

   s.author    = 'Denis Tierno, Fabio Esposito'
   s.email     = 'contato@locomotiva.pro'
   s.homepage  = 'http://locomotiva.pro'

  s.files       = `git ls-files`.split("\n")
  s.test_files  = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.require_path = 'lib'
  s.requirements << 'none'

  #s.add_dependency 'spree_core', '~> 3.2.0.alpha'
  s.add_dependency 'savon'

  s.add_development_dependency 'capybara', '1.0.1'
  s.add_development_dependency 'factory_girl', '~> 2.6.4'
  s.add_development_dependency 'ffaker'
  s.add_development_dependency 'rspec-rails',  '~> 2.9'
  s.add_development_dependency 'pg'
end
