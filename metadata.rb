name             'cookbook_moodle'
maintainer       'Fred Thompson'
maintainer_email 'fred.thompson@buildempire.co.uk'
license          'Apache 2.0'
description      'The Moodle cookbook, a fresh moodle deployment'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.0.9'

recipe 'cookbook_moodle', 'The Moodle cookbook, a fresh moodle deployment.'

%w{ ubuntu }.each do |os|
  supports os
end

%w{git cookbook_phpbox}.each do |cb|
  depends cb
end