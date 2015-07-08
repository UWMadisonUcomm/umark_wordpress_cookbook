# Author:: Nick Weaver (<jnweaver@wisc.edu>)
# Cookbook Name:: umark_wordpress
# Attribute:: default

default['umark_wordpress']['project_root'] = '/var/www/'
default['umark_wordpress']['wp_dev_root'] = '/var/www/tests/wordpress-develop'
default['umark_wordpress']['wp_test_db'] = 'wordpress_test'
default['umark_wordpress']['wp_dev_db'] = 'wordpress_develop'
default['umark_wordpress']['wp_version'] = '4.2.2'
default['umark_wordpress']['theme_path'] = '/var/www/public/content/themes/twentyfourteen'
