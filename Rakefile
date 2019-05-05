require 'rake/testtask'

spec = Gem::Specification.load('highwayhash.gemspec')

Rake::TestTask.new(:test) do |t|
  t.description = "Run unit tests"
  t.libs << "test"
  t.test_files = FileList['test/unit/*.rb']
  t.verbose = true
end

desc "Run benchmarks"
task :benchmark do
  require_relative "./benchmark/bench"
end

task :default => ["test"]

