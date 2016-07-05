#
# Cookbook Name:: LAMP
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

%w(httpd mysqld).each do |srv|
  service srv do
    supports status: true, restart: true, reload: true
    action [:enable, :start]
  end
end

user = 'ec2-user'
name = "#{node['LAMP']['group']['name']}"

group "#{name}" do
  action :create
  members "#{user}"
  append true
end

www = "#{node['LAMP']['www']}"

directory "#{www}" do
  recursive true
  mode '2775'
  owner "#{user}"
  group "#{name}"
  action :create
end

doc_root = "#{node['LAMP']['doc_root']}"

directory "#{doc_root}" do
  recursive true
  action :create
end

html = "#{node['LAMP']['doc_root']}index.html"

file "#{html}" do
  mode '0664'
  owner "#{user}"
  group "#{name}"
  action :touch
end

httpd_conf = node['LAMP']['httpd_conf']

template "httpd_conf" do
  path "#{httpd_conf['dir']}#{httpd_conf['name']}"
  source "httpd_conf.erb"
  mode '0644'
end

# fish-shell
yum_repository 'fish' do
  baseurl 'http://fishshell.com/files/linux/RedHat_RHEL-6/fish.release:2.repo'
  action :create
end

package 'fish' do
  action :install
end
