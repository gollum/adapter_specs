def fixture(name)
  File.join(File.dirname(__FILE__), 'fixtures', name)
end

RSpec.configure do |config|
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end