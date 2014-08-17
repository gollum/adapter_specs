The spec suite for Gollum Git adapters.

To test your adapter against these specs, add the following to spec/spec_helper.rb:

```ruby
  gem_spec = Gem::Specification.find_by_name('gollum_git_adapter_specs')  
  gem_spec_dir = "#{gem_spec.gem_dir}/#{gem_spec.require_paths[0]}"  
  Dir.glob("#{gem_spec_dir}/**/*.rb").each {|spec| require "#{spec}"}  
```
