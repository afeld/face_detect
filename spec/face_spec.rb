describe FaceDetect::Face do
  describe '.new' do
    it "accepts no arguments" do
      expect {
        FaceDetect::Face.new
      }.to_not raise_error
    end

    it "accepts the landmark names as strings" do
      landmark = FaceDetect::Landmark.new(1, 2)
      face = FaceDetect::Face.new('left_eye' => landmark)
      expect(face.left_eye).to eq(landmark)
    end

    it "accepts the landmark names as symbols" do
      landmark = FaceDetect::Landmark.new(1, 2)
      face = FaceDetect::Face.new(left_eye: landmark)
      expect(face.left_eye).to eq(landmark)
    end

    it "raises an error for an unknown landmark" do
      landmark = FaceDetect::Landmark.new(1, 2)
      expect {
        FaceDetect::Face.new(foo: landmark)
      }.to raise_error(RuntimeError)
    end
  end
end
