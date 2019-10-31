desc 'Set env to test, set up db, run tests, run Rubocop'
task :travis do
  ENV['RAILS_ENV'] = 'test'
  Rake::Task['db:setup'].invoke
  Rake::Task['test'].invoke
  Rake::Task['rubocop'].invoke
end
