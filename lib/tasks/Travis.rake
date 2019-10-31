desc 'Single task to run on CI'
task :travis do
  ENV['Rails_ENV'] = 'test'
  Rake::Task['db:setup'].invoke
  Rake::Task['test'].invoke
  Rake::Task['rubocop'].invoke
end
