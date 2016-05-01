# Face Detect

A Ruby gem for face detection in images. Also includes detection of facial features/landmarks. The backends are swappable.

## Installation

Requires Ruby 2+. Add this line to your application's Gemfile:

```ruby
gem 'face_detect'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install face_detect

## Usage

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

`FaceDetect` accepts either a URL as a String, or a File/TempFile instance.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/afeld/face_detect. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
