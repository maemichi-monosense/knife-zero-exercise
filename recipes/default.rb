#
# Cookbook Name:: LAMP
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

include_recipe "LAMP"

%w(httpd mysqld).each do |srv|
  service srv do
    supports status: true, restart: true, reload: true
    action [:enable, :start]
  end
end

www = "#{node['LAMP']['www']}"
group = "#{node['LAMP']['group']['name']}"

directory "#{www}" do
  recursive true
  mode '2775'
  owner "#{group}"
  group "#{group}"
  action :create
end
