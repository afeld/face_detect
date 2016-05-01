require 'webmock/rspec'
require_relative '../lib/face_detect'

WebMock.disable_net_connect!

def fixture_file(filename)
  path = File.expand_path("fixtures/#{filename}", __dir__)
  File.new(path)
end
