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

group = "#{node['LAMP']['group']['name']}"
www = "#{node['LAMP']['www']}"

directory "#{www}" do
  recursive true
  mode '2775'
  owner "#{group}"
  group "#{group}"
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
  owner "#{group}"
  group "#{group}"
  action :touch
end
