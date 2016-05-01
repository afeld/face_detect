require 'googleauth'
require 'google/apis/vision_v1'

class FaceDetect
  module Adapter
    class Google
      Vision = ::Google::Apis::VisionV1 # Alias the module

      attr_reader :file

      def initialize(file)
        @file = file
      end

      def run
        response = service.annotate_image(batch_request, fields: fields)
        # TODO convert
      end

      private

      def service
        @service ||= Vision::VisionService.new
      end

      def scopes
        ['https://www.googleapis.com/auth/cloud-platform']
      end

      def authorization
        ::Google::Auth.get_application_default(scopes)
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
