#
# Cookbook Name:: yoshiso-pyenv
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

# Install python dependent libraries
Array(node['pyenv']['install_pkgs']).each do |pkg|
  package pkg do
    action :install
  end
end

# Install Setting
template '/etc/profile.d/pyenv.sh' do
  source  'pyenv.sh'
  owner   'root'
  mode    0755
  not_if { ::File.exists?("/etc/profile.d/pyenv.sh") }
end

# Install pyenv
home = File.expand_path("~#{node['pyenv']['user']}")
bin  = "#{home}/.pyenv/bin"
git "#{home}/.pyenv" do
  repository node['pyenv']['git_url']
  user node['pyenv']['user']
  group node['pyenv']['user']
  action :sync
end

git "#{home}/.pyenv/plugins/pyenv-virtualenv" do
  repository node['pyenv']['virtualenv_git_url']
  user node['pyenv']['user']
  group node['pyenv']['user']
  action :sync
end

# Install pythons
Array(node['pyenv']['versions']).each do |v|

  bash "Install python -v #{v}" do
    user node['pyenv']['user']
    cwd home
    action :run
    code <<-EOF
      export PYENV_ROOT="#{home}/.pyenv"
      export PATH=#{bin}:$PATH
      eval "$(pyenv init -)"
      pyenv install #{v}
      pyenv rehash
    EOF
    not_if { ::File.directory?("#{home}/.pyenv/versions/#{v}") }
  end

end


# define curent global python
if(node['pyenv'].attribute?("version"))

  bash "use python -v #{node['pyenv']['version']}" do
    user node['pyenv']['user']
    cwd home
    action :run
    code <<-EOF
      export PYENV_ROOT="#{home}/.pyenv"
      export PATH=#{bin}:$PATH
      eval "$(pyenv init -)"
      pyenv global #{node['pyenv']['version']}
      pyenv rehash
    EOF
  end

end