# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)
 
require 'pager_duty_rest_client/version'
 
Gem::Specification.new do |s|
  s.name        = "pager_duty_rest_client"
  s.version     = PagerDutyRestClient::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Lucas Parry"]
  s.email       = ["lparry@gmail.com"]
  s.homepage    = "http://github.com/lparry/pager_duty_rest_client"
  s.summary     = "Quick and Dirty interface to the PagerDuty REST api"
  s.description = "Quick and Dirty interface to the PagerDuty REST api!"
 
  s.required_rubygems_version = ">= 1.3.6"
 
  s.add_development_dependency "rspec"
 
  s.files        = Dir.glob("{bin,lib}/**/*") + %w(LICENSE.txt README.md)
  s.require_path = 'lib'
end
