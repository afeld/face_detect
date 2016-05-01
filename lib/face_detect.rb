require 'face_detect/version'

class FaceDetect
  attr_reader :file, :adapter_instance

  # TODO accept a File or a URL
  def initialize(file:, adapter:)
    @file = file
    @adapter_instance = adapter.new(file)
  end

  def run
    adapter_instance.run
  end
end
