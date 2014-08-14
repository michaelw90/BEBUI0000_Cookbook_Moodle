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

default['cookbook_moodle']['cronic'] = '/opt/bin/cronic'
default['cookbook_moodle']['cron_hour'] = "*"
default['cookbook_moodle']['cron_minute'] = "*/5"

default["cookbook_moodle"]['php_packages'] = []
default["cookbook_moodle"]['php_pears'] = []

default['cookbook_moodle']['htpasswd']['username'] = ''
default['cookbook_moodle']['htpasswd']['password'] = ''
default['cookbook_moodle']['htpasswd']['path'] = ''

default["databox"]["databases"] = {}

default['build-essential']['compile_time'] = true

