#
# Cookbook Name:: uw-wordpress
# Recipe:: default
#
# Copyright (C) 2014 YOUR_NAME
#
# All rights reserved - Do Not Redistribute
#

grunt_cookbook_npm default['uw-wordpress']['doc_root'] do
  action :install
end

grunt_cookbook_grunt default['uw-wordpress']['doc_root'] do
  action :task
  task "copy"
end