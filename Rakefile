require 'bundler'
Bundler::GemHelper.install_tasks

namespace :box do
  desc 'Downloads and adds vagrant box for testing.'
  task :add do
    sh 'bundle exec vagrant box add ubuntu/trusty64'
  end

  desc 'Removes testing vagrant box.'
  task :remove do
    sh 'bundle exec vagrant box remove --force ubuntu/trusty64'
  end
end
