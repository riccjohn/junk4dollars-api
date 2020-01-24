desc 'Set env to test, set up db, run tests, run Rubocop'
task :travis do
  ENV['RAILS_ENV'] = 'test'
  Rake::Task['db:create'].invoke
  Rake::Task['db:schema:load'].invoke
  Rake::Task['test'].invoke
end
