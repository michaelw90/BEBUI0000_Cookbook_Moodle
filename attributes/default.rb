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
default['cookbook_moodle']['oracle']['version'] = default['cookbook_moodle']['basic_rpm'].split('-')[1].sub(/instantclient/, '')

default[:build_essential][:compile_time] = true