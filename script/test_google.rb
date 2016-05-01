# Create a JSON service account key here:
#
# https://console.cloud.google.com/apis/credentials/serviceaccountkey
#
# then run with
#
#   GOOGLE_CREDENTIALS_JSON=$(cat <credentials>.json) bundle exec ruby script/test_google.rb
#
# http://www.rubydoc.info/github/google/google-api-ruby-client/Google/Apis/VisionV1/VisionService
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
