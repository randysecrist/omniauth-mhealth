# -*- encoding: utf-8 -*-
require File.expand_path('../lib/omniauth-mhealth/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Bryce Kerley", "Randy Secrist"]
  gem.email         = ["bkerley@brycekerley.net", "randy.secrist@gmail.com"]
  gem.description   = %q{OmniAuth plugin for AT&T mHealth}
  gem.summary       = %q{OmniAuth plugin for AT&T mHealth}
  gem.homepage      = "https://mhealth.att.com/hack"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "omniauth-mhealth"
  gem.require_paths = ["lib"]
  gem.version       = Omniauth::Mhealth::VERSION

  gem.add_dependency 'omniauth', '~> 1.0'
  gem.add_dependency 'omniauth-oauth2', '~> 1.1'
  gem.add_development_dependency 'rspec', '~> 2.7'
  gem.add_development_dependency 'rack-test'
  gem.add_development_dependency 'simplecov'
  gem.add_development_dependency 'webmock'
end
