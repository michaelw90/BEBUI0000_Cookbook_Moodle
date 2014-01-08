default['cookbook_moodle']['appname'] = 'moodle'
default['cookbook_moodle']['hostname'] = 'localhost'
default['cookbook_moodle']['user'] = 'moodle'
default['cookbook_moodle']['group'] = 'moodle'

default['cookbook_moodle']['database']['root_password'] = nil
default['cookbook_moodle']['database']['username'] = 'moodle'
default['cookbook_moodle']['database']['password'] = ''

default['cookbook_moodle']['branch'] = 'MOODLE_24_STABLE'
default['cookbook_moodle']['cronic'] = '/opt/bin/cronic'
default['cookbook_moodle']['cron_hour'] = 23

default[:build_essential][:compiletime] = true