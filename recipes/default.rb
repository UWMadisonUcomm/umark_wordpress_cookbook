#
# Cookbook Name:: uw_wordpress
# Recipe:: default
#
# Copyright (C) 2014 YOUR_NAME
#
# All rights reserved - Do Not Redistribute
#

composer_project node['uw_wordpress']['doc_root'] do
  action :install
  dev true
end

grunt_cookbook_npm "/" do
  action :install
  package "grunt-cli"
  flags "--global"
end

grunt_cookbook_npm node['uw_wordpress']['doc_root'] do
  action :install
end

grunt_cookbook_npm "/" do
  action :install
  package "bower"
  flags "--global"
end

uw_wordpress_bower node['uw_wordpress']['doc_root'] do
  action :install
end

grunt_cookbook_grunt node['uw_wordpress']['doc_root'] do
  action :task
  task "copy"
end

grunt_cookbook_grunt node['uw_wordpress']['doc_root'] do
  action :task
  task "build"
end
