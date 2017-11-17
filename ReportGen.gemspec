
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ReportGen/version'

Gem::Specification.new do |spec|
  spec.name          = 'ReportGen'
  spec.version       = ReportGen::VERSION
  spec.authors       = ['Tassu']
  spec.email         = ['git@tassu.me']

  spec.summary       = 'ReportGen generates HTML documents using Report from Markdown.'
  spec.description   = 'ReportGen generates HTML documents using Report from Markdown.'
  spec.homepage      = 'http://tassu.me/report-theme'
  spec.license       = 'MIT'

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'colorize'
  spec.add_runtime_dependency 'redcarpet'

  spec.add_development_dependency 'bundler', '~> 1.16'
  spec.add_development_dependency 'minitest', '~> 5.0'
  spec.add_development_dependency 'rake', '~> 10.0'
end
