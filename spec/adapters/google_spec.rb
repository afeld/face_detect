require_relative '../../lib/face_detect/adapter/google'

describe FaceDetect::Adapter::Google do
  describe "integration" do
    it "downloads the image" do
      path = File.expand_path('../fixtures/obama.jpg', __dir__)
      input = File.new(path)

      detector = FaceDetect.new(
        file: input,
        adapter: FaceDetect::Adapter::Google
      )

      authorization = instance_double(Google::Auth::ServiceAccountCredentials)
      expect(detector.adapter_instance).to receive(:authorization).and_return(authorization)

      stub = stub_request(:post, %r{^https://vision.googleapis.com/})
      detector.run
      expect(stub).to have_been_requested
    end
  end
end
