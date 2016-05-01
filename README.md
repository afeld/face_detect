# Face Detect

A Ruby gem for face detection in images. Also includes detection of facial features/landmarks. The backends are swappable.

While the intention is to support multiple adapters, the only one available for now is the [**Google Cloud Vision API**](https://cloud.google.com/vision/).

## Installation

Requires Ruby 2+.

1. Add this line to your application's Gemfile:

    ```ruby
    gem 'face_detect'
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
    result = detector.run
    result.faces #=> [<FaceDetect::Face>, ...]
    face = result.faces.first
    face.mouth_left.x #=> 225.06
    ```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/afeld/face_detect. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
