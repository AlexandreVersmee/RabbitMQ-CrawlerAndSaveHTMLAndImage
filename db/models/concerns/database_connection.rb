#!/usr/bin/env ruby
# encoding: utf-8
require 'yaml'
require 'active_record'

@environment = ENV['RACK_ENV'] || 'development'
@dbconfig = YAML.load(File.read('db/config.yml'))

ActiveRecord::Base.establish_connection @dbconfig[@environment]
