#!/usr/bin/env ruby

require 'optparse'
require 'mongo'
require 'aws'
require 'ruby-progressbar'

def backup(options)
  client = Mongo::MongoClient.new(options[:host], options[:port])
  client.lock!

  ec2 = AWS.ec2
  volume = ec2.volumes[options[:volume]]
  snapshot = volume.create_snapshot("Backup #{options[:host]} #{Time.now}")
  progressbar = ProgressBar.create
  until [:completed, :error].include?(snapshot.status) do
    progressbar.progress = snapshot.progress if snapshot.progress
    sleep 1
  end

  if snapshot.status == :completed
    print "Created snapshot: #{snapshot.id}"
  else
    fail 'Error during snapshot creation'
  end

ensure
  client.unlock! if client
end

options = {}

opt_parser = OptionParser.new do |opt|
  opt.banner = 'Usage: ems COMMAND [OPTIONS]'
  opt.separator  ''
  opt.separator  'Commands'
  opt.separator  '     backup: create snapshot for mongodb volume'
  opt.separator  ''
  opt.separator  'Options'

  opt.on('-v', '--volume EBS_VOLUME', 'volume to backup') do |vol|
    options[:volume] = vol
  end
  opt.on('-h', '--host [MONGODB_HOST]', 'hostname for MongoDb server') do |host|
    options[:host] = host
  end
  opt.on('-p', '--port [MONGODB_PORT]', 'port for MongoDb server') do |port|
    options[:port] = port
  end

  opt.on('--help', 'help') do
    puts opt_parser
  end
end

opt_parser.parse!

case ARGV[0]
when 'backup'
  backup(options)
else
  puts opt_parser
end
