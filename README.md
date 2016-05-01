# Face Detect

A Ruby gem for face detection in images. Also includes detection of facial features/landmarks. The backends are swappable.

While the intention is to support multiple adapters, the only one available for now is the [**Google Cloud Vision API**](https://cloud.google.com/vision/).

## Installation

Requires Ruby 2.x.

1. Add this line to your application's Gemfile:

    ```ruby
    gem 'face_detect'
    gem 'googleauth'
    gem 'google-api-client'
    ```

1. Execute:

    ```bash
    bundle
    ```

1. [Create a JSON service account key.](https://console.cloud.google.com/apis/credentials/serviceaccountkey)

## Usage

1. The JSON file that you downloaded contains your credentials. Set the full contents as an environment variable.

    ```bash
    export GOOGLE_CREDENTIALS_JSON=$(cat <credentials>.json)
    ```

1. Add the following to your code:

    ```ruby
    require 'face_detect'
    require 'face_detect/adapter/google'

    input = File.new('image.png')
    detector = FaceDetect.new(
      file: input,
      adapter: FaceDetect::Adapter::Google
    )
    results = detector.run
    results #=> [<FaceDetect::Face>, ...]
    face = results.first
    face.mouth_left.x #=> 225.06
    ```
