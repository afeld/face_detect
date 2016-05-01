# After following the installation steps in the README, run
#
#   bundle exec ruby script/test_google_full.rb
#
# You can also specify the IMG environment variable as a path to an image if you want to test with something else.
#
require 'pp'

require_relative '../lib/face_detect'
require_relative '../lib/face_detect/adapter/google'

path = ENV['IMG'] || File.expand_path('../spec/fixtures/obama.jpg', __dir__)
input = File.new(path)
detector = FaceDetect.new(
  file: input,
  adapter: FaceDetect::Adapter::Google
)
result = detector.run
pp result
