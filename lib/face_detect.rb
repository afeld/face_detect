require 'face_detect/version'

class FaceDetect
  attr_reader :file, :adapter_class

  # TODO accept a File or a URL
  def initialize(file:, adapter:)
    @file = file
    @adapter_class = adapter
  end

  def run
    instance = adapter_class.new(file)
    instance.run
  end
end
