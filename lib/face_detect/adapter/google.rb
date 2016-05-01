require 'googleauth'
require 'google/apis/vision_v1'
require 'stringio'

class FaceDetect
  module Adapter
    class Google
      # alias the module
      # http://www.rubydoc.info/github/google/google-api-ruby-client/Google/Apis/VisionV1/VisionService
      Vision = ::Google::Apis::VisionV1

      attr_reader :file

      def initialize(file)
        @file = file
      end

      def run
        results = execute
        # TODO convert
      end

      private

      def service
        @service ||= Vision::VisionService.new
      end

      def scopes
        ['https://www.googleapis.com/auth/cloud-platform']
      end

      def credentials
        ENV.fetch('GOOGLE_CREDENTIALS_JSON')
      end

      def authorization
        key_io = StringIO.new(credentials)
        ::Google::Auth::ServiceAccountCredentials.make_creds(json_key_io: key_io, scope: scopes)
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

      def execute
        service.authorization = authorization
        service.annotate_image(batch_request, fields: fields)
      end
    end
  end
end
