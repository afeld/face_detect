require_relative 'google/auth_helper'
require_relative 'google/service'

class FaceDetect
  module Adapter
    class Google
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

      def authorization
        AuthHelper.authorization
      end

      def execute
        service = Service.new(authorization, file)
        batch_response = service.run
      end

      def landmarks_by_name(annotation)
        results = {}
        annotation.landmarks.each do |google_landmark|
          name = google_landmark.type.downcase
          results[name] = convert_landmark(google_landmark)
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
