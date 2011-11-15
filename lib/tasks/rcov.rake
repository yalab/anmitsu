require 'rcov/rcovtask'

Rcov::RcovTask.new do |t|
  t.libs << "test"
  t.test_files = FileList['test/**/*_test.rb']
  t.verbose = true
  t.rcov_opts = %w{--rails --exclude gems,ext}
end
