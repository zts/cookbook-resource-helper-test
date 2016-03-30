resource_name :my_test_resource

property :foo, String, required: false

default_action :create

include ::HelperTest

action :create do
  if do_something?('foo')
    log "something must be done"
  else
    log "nothing will be done"
  end
end
