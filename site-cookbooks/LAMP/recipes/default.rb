#
# Cookbook Name:: LAMP
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

%w(php-devel php-mbstring).each { |p| package p }

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
  action :nothing
end

httpd_conf_d = node['LAMP']['httpd/conf.d']

template "vhosts" do
  path "#{httpd_conf_d['path']}#{httpd_conf_d['vhosts']}"
  source "vhosts.erb"
  mode '0644'
end

file "#{httpd_conf_d['path']}#{node['LAMP']['httpd_conf']['name']}" do
  action :delete
end

template "php.ini" do
  path '/etc/php.ini'
  source "php.ini.erb"
  mode '0644'
end
