#
# Cookbook Name:: mqm
# Recipe:: default
#

cookbook_file "/tmp/#{node.mqm.source_file}" do
  source node.mqm.source_file
  mode '0755'
  owner 'root'
  group 'root'
end

directory '/tmp/mqm' do
  action :create
end

execute 'extract_tar' do
  command "tar xf /tmp/#{node.mqm.source_file} -C /tmp/mqm"
  cwd '/tmp'
  not_if { File.exists?("/tmp/mqm/mqlicense.sh") }
end

execute 'accept_license' do
  command "/tmp/mqm/mqlicense.sh -accept"
  cwd '/tmp/mqm'
end

node.mqm.mq_packages.each do |mqm|
  package mqm do
    action :install
    source "/tmp/mqm/#{mqm}"
  end
end
