require 'pp'

#
# Cookbook Name:: rapns
# Recipe:: default
#

# Set your application name here
appname = "vendingserver"

node[:applications].each do |app_name,data|
  user = node[:users].first

  case node[:instance_role]
   when "solo", "app", "app_master"
     template "/etc/monit.d/rapns.#{app_name}.monitrc" do
       source "rapns.monitrc.erb"
       owner node[:owner_name]
       group node[:owner_name]
       mode 0644
       variables({
         :app_name => app_name,
         :user => node[:owner_name],
         :env => node[:environment][:framework_env]
       })
     end
  end
end