require_relative '../../lib/face_detect/adapter/google'

describe FaceDetect::Adapter::Google do
  def stub_auth(detector)
    authorization = instance_double(Google::Auth::ServiceAccountCredentials)
    expect(detector.adapter_instance).to receive(:authorization).and_return(authorization)
  end

  def stub_annotations(annotations=[])
    stub_request(:post, %r{^https://vision.googleapis.com/}).to_return(
      headers: {
        'Content-Type' => 'application/json'
      },
      body: {
        responses: [
          {
            faceAnnotations: annotations
          }
        ]
      }.to_json
    )
  end

  describe "integration" do
    it "makes the API request" do
      detector = FaceDetect.new(
        file: fixture_file('obama.jpg'),
        adapter: FaceDetect::Adapter::Google
      )
      stub_auth(detector)

      stub = stub_annotations
      detector.run
      expect(stub).to have_been_requested
    end
  end

  describe '#run' do
    it "returns the landmarks" do
      detector = FaceDetect.new(
        file: fixture_file('obama.jpg'),
        adapter: FaceDetect::Adapter::Google
      )
      stub_auth(detector)

      stub_annotations([
        {
          landmarks: [
            {
              type: 'LEFT_EYE',
              position: {
                x: 123.0,
                y: 456.0,
                z: 789.0
              }
            }
          ]
        }
      ])
      results = detector.run
      expect(results.size).to eq(1)
      face = results.first
      expect(face).to be_a(FaceDetect::Face)
      expect(face.left_eye).to be_a(FaceDetect::Landmark)
      expect(face.left_eye.x).to eq(123.0)
      expect(face.left_eye.y).to eq(456.0)
    end
  end
end
