class FaceDetect
  class Landmark
    attr_reader :x, :y

    def initialize(x, y)
      @x = x.to_f
      @y = y.to_f
    end
  end
end
