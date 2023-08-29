def fixture(name)
  File.join(File.dirname(__FILE__), 'fixtures', name)
end

def cloned_testpath(path, bare = false)
  tmpdir = Dir.mktmpdir(self.class.name)
  bare   = bare ? "--bare" : ""
  redirect = Gem.win_platform? ? '' : '2>/dev/null'
  %x{git clone #{bare} '#{path}' #{tmpdir} #{redirect}}
  tmpdir
end

RSpec.configure do |config|
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end