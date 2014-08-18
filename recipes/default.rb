#
# Cookbook Name:: uw-wordpress
# Recipe:: default
#
# Copyright (C) 2014 YOUR_NAME
#
# All rights reserved - Do Not Redistribute
#

composer_project node['uw-wordpress']['doc_root'] do
  action :install
end

grunt_cookbook_npm node['uw-wordpress']['doc_root'] do
  action :install
end

grunt_cookbook_grunt node['uw-wordpress']['doc_root'] do
  action :task
  task "copy"
end

