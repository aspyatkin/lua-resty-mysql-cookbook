name 'lua-resty-mysql'
maintainer 'Alexander Pyatkin'
maintainer_email 'aspyatkin@gmail.com'
license 'MIT'
description 'Installs and configures lua-resty-mysql'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '1.0.0'

recipe 'lua-resty-musql', 'Installs and configures lua-resty-mysql'

depends 'build-essential'

source_url 'https://github.com/aspyatkin/lua-resty-mysql-cookbook'
