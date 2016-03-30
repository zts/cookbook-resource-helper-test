class ::Chef::Recipe
  include ::HelperTest
end

if do_something?('foo')
  log "something must be done"
else
  log "nothing will be done"
end
