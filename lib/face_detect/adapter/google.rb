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
        batch_response = execute
        response = batch_response.responses.first
        response.face_annotations.map do |annotation|
          convert_face(annotation)
        end
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

      def landmarks_by_name(annotation)
        results = {}
        annotation.landmarks.each do |google_landmark|
          results[google_landmark.type] = convert_landmark(google_landmark)
        end
        results
      end

      def convert_face(annotation)
        FaceDetect::Face.new(landmarks_by_name(annotation))
      end

      def convert_landmark(google_landmark)
        pos = google_landmark.position
        FaceDetect::Landmark.new(pos.x, pos.y)
      end
    end
  end
end
