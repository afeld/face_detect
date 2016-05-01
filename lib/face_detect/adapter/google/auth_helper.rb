require 'googleauth'
require 'stringio'

class FaceDetect
  module Adapter
    class Google
      module AuthHelper
        class << self
          def scopes
            ['https://www.googleapis.com/auth/cloud-platform']
          end

          def credentials
            ENV.fetch('GOOGLE_CREDENTIALS_JSON')
          end

          def authorization
            key_io = StringIO.new(credentials)
            ::Google::Auth::ServiceAccountCredentials.make_creds(
              json_key_io: key_io,
              scope: scopes
            )
          end
        end
      end
    end
  end
end
