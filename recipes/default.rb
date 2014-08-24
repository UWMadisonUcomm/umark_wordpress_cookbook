#
# Cookbook Name:: uw_wordpress
# Recipe:: default
#
# Copyright (C) 2014 YOUR_NAME
#
# All rights reserved - Do Not Redistribute
#

# execute "install php-dom" do
#   command "yum -y install php-dom"
# end

composer_project node['uw_wordpress']['project_root'] do
  action :install
  dev true
end

execute "Install PHPunit" do
  command "COMPOSER_HOME=/home/vagrant/.composer composer global require --no-update phpunit/phpunit:4.0.*"
end

execute "Install PHP invoker" do
  command "COMPOSER_HOME=/home/vagrant/.composer composer global require --no-update phpunit/php-invoker:1.1.*"
end

execute "Install Mockery" do
  command "COMPOSER_HOME=/home/vagrant/.composer composer global require --no-update mockery/mockery:0.8.*"
end

execute "Install WP-CLI" do
  command "COMPOSER_HOME=/home/vagrant/.composer composer global require --no-update wp-cli/wp-cli:0.16.*"
end

execute "Global config bin" do
  command "composer global config  -d /home/vagrant/.composer bin-dir /usr/local/bin"
end

execute "Run composer global update" do
  command "composer update -d /home/vagrant/.composer"
end

# execute "Add global vendor to path" do
#   command "export PATH=/root//vendor/bin:$PATH"
# end

# link "/usr/local/bin/wp" do
#   to "#{node['uw_wordpress']['project_root']}vendor/bin/wp"
# end
# link "/usr/local/bin/phpunit" do
#   to "#{node['uw_wordpress']['project_root']}vendor/bin/phpunit"
# end

grunt_cookbook_npm "/" do
  action :install
  package "grunt-cli bower"
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
