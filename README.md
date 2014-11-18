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

### Rack::Timeout

If you are using `Rack::Timeout` you might want to do something like:

```ruby
after_fork do |server, worker|
  # Code to reconnect all databases belongs here
  server.logger.info("worker=#{worker.nr} spawned pid=#{$$}")

  timeout = Rack::Timeout.service_timeout
  begin
    Rack::Timeout.service_timeout = 60
    server.logger.info("worker=#{worker.nr} prewarming")
    start = Time.now
    Unicorn.prewarm(server).is_a?(Net::HTTPSuccess) or raise "Prewarm of worker #{worker.nr} failed"
    server.logger.info("worker=#{worker.nr} prewarmed in #{Time.now - start}")
  rescue => error
    server.logger.error("worker=#{worker.nr} prewarm failed: #{error} in #{Time.now - start}")
    raise
  ensure
    Rack::Timeout.service_timeout = timeout
  end
end
```

To prevent from timeouting on first requests.

## Contributing

1. Fork it ( https://github.com/3scale/unicorn-prewarm/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
