require 'set'

class FaceDetect
  class Face
    # https://cloud.google.com/vision/reference/rest/v1/images/annotate#Landmark
    LANDMARK_NAMES = %i(
      left_eye
      right_eye
      left_of_left_eyebrow
      right_of_left_eyebrow
      left_of_right_eyebrow
      right_of_right_eyebrow
      midpoint_between_eyes
      nose_tip
      upper_lip
      lower_lip
      mouth_left
      mouth_right
      mouth_center
      nose_bottom_right
      nose_bottom_left
      nose_bottom_center
      left_eye_top_boundary
      left_eye_right_corner
      left_eye_bottom_boundary
      left_eye_left_corner
      right_eye_top_boundary
      right_eye_right_corner
      right_eye_bottom_boundary
      right_eye_left_corner
      left_eyebrow_upper_midpoint
      right_eyebrow_upper_midpoint
      left_ear_tragion
      right_ear_tragion
      left_eye_pupil
      right_eye_pupil
      forehead_glabella
      chin_gnathion
      chin_left_gonion
      chin_right_gonion
    ).to_set.freeze

    attr_reader *LANDMARK_NAMES

    def initialize(landmarks_by_name={})
      landmarks_by_name.each do |name, landmark|
        unless LANDMARK_NAMES.include?(name.to_sym)
          raise "'#{name}' not a valid landmark name."
        end
        instance_variable_set("@#{name}", landmark)
      end
    end
  end
end
