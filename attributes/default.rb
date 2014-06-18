default['cookbook_moodle']['appname'] = 'moodle'
default['cookbook_moodle']['hostname'] = 'localhost'
default['cookbook_moodle']['user'] = 'www-data'
default['cookbook_moodle']['group'] = 'www-data'
default['cookbook_moodle']['address'] = 'http://localhost'

default['cookbook_moodle']['database']['type'] = 'mysql'
default['cookbook_moodle']['database']['root_password'] = nil
default['cookbook_moodle']['database']['database_name'] = 'moodle'
default['cookbook_moodle']['database']['username'] = 'moodle'
default['cookbook_moodle']['database']['password'] = ''

default['cookbook_moodle']['download'] = true
default['cookbook_moodle']['branch'] = 'MOODLE_24_STABLE'
default['cookbook_moodle']['cronic'] = '/opt/bin/cronic'
default['cookbook_moodle']['cron_hour'] = "*"
default['cookbook_moodle']['cron_minute'] = "5"

default['cookbook_moodle']['oracle']['basic_rpm'] = 'oracle-instantclient12.1-basic-12.1.0.1.0-1.x86_64.rpm'
default['cookbook_moodle']['oracle']['basic_zip'] = 'instantclient-basic-linux.x64-12.1.0.1.0.zip'
default['cookbook_moodle']['oracle']['sdk_zip'] = 'instantclient-sdk-linux.x64-12.1.0.1.0.zip'
default['cookbook_moodle']['oracle']['folder_name'] = 'instantclient_12_1'
default['cookbook_moodle']['oracle']['version'] = default['cookbook_moodle']['oracle']['basic_rpm'].split('-')[1].sub(/instantclient/, '')
default['cookbook_moodle']['oracle']['php']['bin'] = 'php'
default['cookbook_moodle']['oracle']['php']['version'] = '5.5.13'
default['cookbook_moodle']['oracle']['php']['url'] = 'http://us1.php.net/get'
default['cookbook_moodle']['oracle']['php']['prefix_dir'] = '/usr/local/php5'
default['cookbook_moodle']['oracle']['php']['conf_dir'] = '/usr/local/php5/cli'
default['cookbook_moodle']['oracle']['php']['ext_conf_dir'] = '/usr/local/php5/conf.d'
default['cookbook_moodle']['oracle']['php']['template'] = 'php.ini.erb'
default['cookbook_moodle']['oracle']['php']['directives'] = {
                                                              'date.timezone' => 'Europe/London',
                                                              'short_open_tag' => 'Off',
                                                              'magic_quotes_gpc' => 'Off',
                                                              'register_globals' => 'Off',
                                                              'session.autostart' => 'Off',
                                                              'upload_max_filesize' => '8M',
                                                              'max_execution_time' => '600',
                                                              'oci8.statement_cache_size' => 0
                                                            }
default['cookbook_moodle']['oracle']['php']['configure_options'] = %W{--prefix=#{node['cookbook_moodle']['oracle']['php']['prefix_dir']}
                                                                     --with-libdir=lib
                                                                     --with-config-file-path=#{node['cookbook_moodle']['oracle']['php']['conf_dir']}
                                                                     --with-config-file-scan-dir=#{node['cookbook_moodle']['oracle']['php']['ext_conf_dir']}
                                                                     --with-pear
                                                                     --enable-fpm
                                                                     --with-fpm-user=www-data
                                                                     --with-fpm-group=www-data
                                                                     --with-zlib
                                                                     --with-openssl
                                                                     --with-kerberos
                                                                     --with-bz2
                                                                     --with-curl
                                                                     --enable-ftp
                                                                     --enable-zip
                                                                     --enable-exif
                                                                     --with-gd
                                                                     --enable-gd-native-ttf
                                                                     --with-gettext
                                                                     --with-gmp
                                                                     --with-mhash
                                                                     --with-iconv
                                                                     --with-imap
                                                                     --with-imap-ssl
                                                                     --enable-sockets
                                                                     --enable-soap
                                                                     --with-xmlrpc
                                                                     --with-libevent-dir
                                                                     --with-mcrypt
                                                                     --enable-mbstring
                                                                     --with-t1lib
                                                                     --with-oci8=instantclient,/usr/lib/oracle/instantclient_12_1
                                                                     --with-pdo-oci=instantclient,/usr/lib/oracle/instantclient_12_1,12.1}

default[:build_essential][:compile_time] = true