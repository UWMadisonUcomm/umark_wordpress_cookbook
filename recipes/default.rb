#
# Cookbook Name:: uw_wordpress
# Recipe:: default
#
# Copyright (C) 2014 Nick Weaver
#
#

include_recipe "git"
include_recipe "composer"
include_recipe "nodejs"
include_recipe "grunt_cookbook::install_grunt_cli"

composer_project node['uw_wordpress']['project_root'] do
  action :install
  dev true
end

grunt_cookbook_npm "/var/" do
  action :install
  package "bower"
  flags "--global"
end

grunt_cookbook_npm node['uw_wordpress']['project_root'] do
  action :install
end

uw_wordpress_bower node['uw_wordpress']['project_root'] do
  action :install
end

grunt_cookbook_grunt node['uw_wordpress']['project_root'] do
  action :task
  task "copy build"
end
