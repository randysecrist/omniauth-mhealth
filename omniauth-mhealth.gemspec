# -*- encoding: utf-8 -*-
require File.expand_path('../lib/omniauth-mhealth/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Bryce Kerley"]
  gem.email         = ["bkerley@brycekerley.net"]
  gem.description   = %q{OmniAuth plugin for AT&T mHealth}
  gem.summary       = %q{OmniAuth plugin for AT&T mHealth}
  gem.homepage      = "https://mhealth.att.com/hack"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "omniauth-mhealth"
  gem.require_paths = ["lib"]
  gem.version       = Omniauth::Mhealth::VERSION
end
