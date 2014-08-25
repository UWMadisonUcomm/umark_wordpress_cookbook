# Author:: Nick Weaver (<jnweaver@wisc.edu>)
# Cookbook Name:: uw_wordpress
# Attribute:: default

default['uw_wordpress']['project_root'] = '/var/www/'
default['uw_wordpress']['wp_dev_root'] = '/var/www/tests/wordpress-develop'
default['uw_wordpress']['wp_test_db'] = 'wordpress_test'
default['uw_wordpress']['wp_dev_db'] = 'wordpress_develop'
default['uw_wordpress']['wp_version'] = '3.9.2'
default['uw_wordpress']['theme_path'] = default['uw_wordpress']['project_root'] + 'public/content/themes/twentyfourteen'