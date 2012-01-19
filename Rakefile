begin
  require 'bundler/setup'
rescue
end

$:.unshift File.expand_path("../lib", __FILE__)

require 'rake/clean'
CLEAN << 'lib/schedule.rb' << 'schedule.xml'

require 'schedule_data'
include JRubyConf::ScheduleData

file 'lib/schedule.rb' do |t|
  write_schedule_rb(t.name)
end

file 'schedule.xml' do |t|
  write_schedule_xml(t.name)
end

desc "Builds the schedule from GCal"
task :schedule => ['schedule.xml', 'lib/schedule.rb'] do
  if Rake.application.options.trace
    schedule_entries.sort_by {|e| e['Start'] }.each {|e| p e }
  end
end

desc "Generate the news posts using Jekyll"
task :generate do
  ruby "-S bundle exec jekyll"
  FileList['_site/**/*'].each do |f|
    cp_r f, f.sub('_site', 'public')
  end
end

desc "Runs a development server"
task :server do
  sh 'rackup'
end

desc "Runs all pre-deployment tasks"
task :deploy => [:schedule, :generate]
