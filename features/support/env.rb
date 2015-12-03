require 'aruba/cucumber'

When /^I run lr (.*)$/ do |args|
  When "I run \"ruby ../../../bin/lr #{args}\""
end
