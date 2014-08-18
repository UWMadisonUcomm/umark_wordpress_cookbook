#
# Cookbook: uw_wordpress
# uw_wordpress_bower
#

action :install do
  # Import
  dir = @new_resource.dir
  package = @new_resource.package
  flags = @new_resource.flags

  # Check
  unless dir then
    raise "No directory supplied, should be defined using the name parameter."
  end

  unless ::File.directory?(dir) then
    raise "Directory '#{dir}' to run bower action from was not found"
  end

  # Prepare NPM command
  bower_command = "bower install"

  unless package.nil? or package.empty?
    bower_command += " #{package}"
  end

  unless flags.nil? or flags.empty?
      bower_command += " #{flags}"
  end

  # allow command to be run as root
  bower_command += " --allow-root"

  execute bower_command do
    cwd dir
  end

end
