#
# Cookbook Name:: LAMP
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

include_recipe "LAMP"

service "httpd" do
  supports status: true, restart: true, reload: true
  action [:enable, :start]
end
