include_recipe 'build-essential'
id = 'lua-resty-mysql'

lua_resty_mysql_tar_path = ::File.join(
  ::Chef::Config['file_cache_path'],
  "lua-resty-mysql-#{node[id]['version']}.tar.gz"
)
lua_resty_mysql_src_url = "#{node[id]['url']}/v#{node[id]['version']}.tar.gz"
lua_resty_mysql_src_dir = ::File.join(
  ::Chef::Config['file_cache_path'],
  "lua-resty-mysql-#{node[id]['version']}"
)

remote_file lua_resty_mysql_tar_path do
  source lua_resty_mysql_src_url
  checksum node[id]['checksum']
  mode 0644
end

directory lua_resty_mysql_src_dir do
  action :create
end

makefile_path = ::File.join(lua_resty_mysql_src_dir, 'Makefile')

execute "tar --no-same-owner -zxf #{::File.basename(lua_resty_mysql_tar_path)}"\
        " -C #{lua_resty_mysql_src_dir} --strip-components 1" do
  cwd ::Chef::Config['file_cache_path']
  creates makefile_path
end

execute 'make install lua-resty-mysql package' do
  environment(
    'PATH' => '/usr/local/bin:/usr/bin:/bin',
    'LUA_VERSION' => node[id]['lua_version']
  )
  command 'make install'
  cwd lua_resty_mysql_src_dir
  action :run
end
