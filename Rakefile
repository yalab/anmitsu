require File.expand_path('../config/application', __FILE__)

Anmitsu::Application.load_tasks

desc "Calculate code coverage"
task :coverage => ["test:all"]

namespace :test do
  TestTaskWithoutDescription.new(:all => "test:prepare") do |t|
    t.libs << "test"
    t.pattern = 'test/{unit,functional,integration}/*_test.rb'
  end
end
