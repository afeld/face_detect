# After following the setup steps in the README, run
#
#   GOOGLE_CREDENTIALS_JSON=$(cat <credentials>.json) bundle exec ruby script/test_google.rb
#
require 'pp'
require_relative '../lib/face_detect'
require_relative '../lib/face_detect/adapter/google'

path = File.expand_path('../spec/fixtures/obama.jpg', __dir__)
input = File.new(path)
detector = FaceDetect.new(
  file: input,
  adapter: FaceDetect::Adapter::Google
)
result = detector.run
pp result
