require 'google/apis/vision_v1'

class FaceDetect
  module Adapter
    class Google
      class Service
        # alias the module
        # http://www.rubydoc.info/github/google/google-api-ruby-client/Google/Apis/VisionV1/VisionService
        Vision = ::Google::Apis::VisionV1

        attr_reader :authorization, :file

        def initialize(authorization, file)
          @authorization = authorization
          @file = file
        end

        def run
          service.authorization = authorization
          service.annotate_image(batch_request, fields: fields)
        end

        private

        def service
          @service ||= Vision::VisionService.new
        end

        def image_contents
          File.read(file)
        end

        def image
          Vision::Image.new(content: image_contents)
        end

        def features
          [Vision::Feature.new(type: 'FACE_DETECTION')]
        end

        def batch_request
          @batch_request ||= Vision::BatchAnnotateImagesRequest.new(
            requests: [
              {
                image: image,
                features: features
              }
            ]
          )
        end

        def fields
          'responses(faceAnnotations(landmarks))'
        end
      end
    end
  end
end
