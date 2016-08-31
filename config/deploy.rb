# config valid only for current version of Capistrano
lock '3.5.0'

set :application, 'nairuby.org'
set :repo_url, 'git@github.com:banta/nairuby.github.io.git'
set :log_level, :debug
set :rvm_ruby_version, '2.3.0@rails'
