require 'serverspec'
require 'net/ssh'
require 'yaml'

set :backend, :ssh

if ENV['SPEC_ASK_SUDO_PASSWORD']
  begin
    require 'highline/import'
  rescue LoadError
    fail "highline is not available. Try installing it."
  end
  set :sudo_password, ask("Enter sudo password: ") { |q| q.echo = false }
else
  set :sudo_password, ENV['SPEC_SUDO_PASSWORD']
end

host = ENV['SPEC_HOST']

# SSH options
options = Net::SSH::Config.for(host)

options[:user] = ENV['SPEC_USER'] || 'ec2-user'
options[:keys] = [ENV['SPEC_SSH_KEY']]
options[:verify_host_key] = :never

set :host,        options[:host_name] || host
set :ssh_options, options

# Disable sudo
set :disable_sudo, true

# Set environment variables
set :env, :LANG => 'C', :LC_ALL => 'C'

# Set PATH
set :path, '/sbin:/usr/local/sbin:/usr/local/bin:$PATH'