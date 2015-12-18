require 'bundler'
require 'bundler/gem_tasks'
Bundler.require(:default, :development)
require 'rspec/core/rake_task'

desc "Removed generated artefacts"
task :clobber do
  %w{ coverage pkg }.each { |dir| rm_rf dir }
  rm Dir.glob("**/coverage.data"), force: true
  puts "Clobbered"
end

desc "Complexity analysis"
task :metrics do
  print `metric_fu --no-open`
end

desc "Exercises specifications"
::RSpec::Core::RakeTask.new(:spec)

desc "Exercises specifications with coverage analysis"
task :coverage => "coverage:generate"

namespace :coverage do

  desc "Generates specification coverage results"
  task :generate do
    ENV["coverage"] = "enabled"
    Rake::Task[:spec].invoke
  end

  desc "Shows specification coverage results in browser"
  task :show do
    begin
      Rake::Task[:coverage].invoke
    ensure
      `open coverage/index.html`
    end
  end

end

task :default => %w{ clobber metrics coverage }

task :pre_commit => %w{ clobber metrics coverage:show validate }
