# Unicorn::Prewarm [![Build Status](https://travis-ci.org/3scale/unicorn-prewarm.svg?branch=master)](https://travis-ci.org/3scale/unicorn-prewarm) [![Code Climate](https://codeclimate.com/github/3scale/unicorn-prewarm/badges/gpa.svg)]

Prewarm your workers before they receive real traffic.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'unicorn-prewarm'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install unicorn-prewarm

## Usage

In unicorn config `after_fork` do:

```ruby
after_fork do |server,worker|
  response = Unicorn.prewarm(server)
  # check if the response is OK, it shall be Net::HTTPSuccess
end
```

## Contributing

1. Fork it ( https://github.com/3scale/unicorn-prewarm/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
