resource_name :my_test_resource2

property :foo, String, required: false

default_action :create

include ::HelperTest

action :create do
  if do_something?('foo')
    log "something else must be done"
  else
    log "nothing else will be done"
  end
end
