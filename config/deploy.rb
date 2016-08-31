# config valid only for current version of Capistrano
lock '3.5.0'

set :application, 'ug.nairuby.org'
set :repo_url, 'git@github.com:nairuby/ug.nairuby.org.git'
set :log_level, :debug
set :rvm_ruby_version, '2.3.0@rails'
