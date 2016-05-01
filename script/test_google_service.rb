# After following the installation steps in the README, run
#
#   bundle exec ruby script/test_google_adatper.rb
#
# You can also specify the IMG environment variable as a path to an image if you want to test with something else.
#
require 'json'

require_relative '../lib/face_detect'
require_relative '../lib/face_detect/adapter/google'

path = ENV['IMG'] || File.expand_path('../spec/fixtures/obama.jpg', __dir__)
input = File.new(path)

authorization = FaceDetect::Adapter::Google::AuthHelper.authorization
service = FaceDetect::Adapter::Google::Service.new(authorization, input)
result = service.run
puts result.to_json
