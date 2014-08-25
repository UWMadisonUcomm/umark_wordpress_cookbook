#
# Cookbook Name:: uw_wordpress
# Recipe:: test_env
#
# Copyright (C) 2014 Nick Weaver
#
#

include_recipe "subversion"
include_recipe "database::mysql"
include_recipe "composer"
include_recipe "nodejs"
include_recipe "grunt_cookbook::install_grunt_cli"

mysql_connection = {
  :host     => 'localhost',
  :username => 'root',
  :password => node['mysql']['server_root_password']
}

mysql_database node['uw_wordpress']['wp_dev_db'] do
  connection mysql_connection
  action :create
end

mysql_database node['uw_wordpress']['wp_test_db'] do
  connection mysql_connection
  action :create
end

# svn checkout http://develop.svn.wordpress.org/trunk/ /var/www/tests/wordpress-develop
subversion "Wordpress develop" do
  user "vagrant"
  group "vagrant"
  repository "http://develop.svn.wordpress.org/tags/#{node['uw_wordpress']['wp_version']}"
  destination node['uw_wordpress']['wp_dev_root']
  action :sync
end

template "#{node['uw_wordpress']['wp_dev_root']}/src/wp-config.php" do
  source "wp-config.php.erb"
  owner "vagrant"
  group "vagrant"
  variables({
     :wp_dev_db => node['uw_wordpress']['wp_dev_db'],
     :db_user => 'root',
     :db_password => node['mysql']['server_root_password']
  })
  action :create
end

template "#{node['uw_wordpress']['wp_dev_root']}/wp-tests-config.php" do
  source "wp-tests-config.php.erb"
  owner "vagrant"
  group "vagrant"
  variables({
     :wp_test_db => node['uw_wordpress']['wp_test_db'],
     :db_user => 'root',
     :db_password => node['mysql']['server_root_password']
  })
  action :create
end

link node['uw_wordpress']['theme_path'] do
  to "#{default['uw_wordpress']['wp_dev_db']}/src/wp-content/themes/test-theme"
  not_if { File.exist?("#{default['uw_wordpress']['theme_path']}") }
end

grunt_cookbook_npm node['uw_wordpress']['wp_dev_root'] do
  action :install
end

grunt_cookbook_grunt node['uw_wordpress']['wp_dev_root'] do
  action :task
  task "default"
  not_if { File.exist?("#{node['uw_wordpress']['wp_dev_root']}/build") }
end

magic_shell_environment 'WP_TESTS_DIR' do
  value "#{node["uw_wordpress"]["wp_dev_root"]}/tests/phpunit"
end

execute "Install Wordpress development instance" do
  command "wp core install --path=#{node["uw_wordpress"]["wp_dev_root"]}/src --url=wordpress.test --quiet --title='WordPress Develop' --admin_name=admin --admin_email='admin@wordpress.test' --admin_password='password'"
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

execute "Composer global config bin" do
  command "composer global config  -d /home/vagrant/.composer bin-dir /usr/local/bin"
end

execute "Run composer global update" do
  command "composer update -d /home/vagrant/.composer"
end