require 'unicorn'
require 'unicorn/prewarm/version'

module Unicorn
  def self.prewarm(server, options={})
    get = Net::HTTP::Get.new(options.fetch(:uri, '/'))

    # Inject custom HTTP Request headers if provided
    if options[:headers]
      options[:headers].each {|key, value| get[key.to_s] = value }
    end

    fake = Unicorn::Prewarm::FakeSocket.new(get)
    server.send(:process_client, fake)
    fake.response
  end

  module Prewarm
    class NetStringIO < StringIO
      def readline
        super.chomp
      end

      def readuntil(idx, ignore_eof)
        buff = ''
        loop do
          char = read(1)
          return buff unless char
          buff << char
          return buff if char == idx
        end
      end
    end

    class FakeSocket
      HTTP_VERSION = '1.1'.freeze

      def initialize(req, version = HTTP_VERSION, path = req.path)
        @req = req
        @version = version
        @path = path
        @out = StringIO.new
      end

      def kgio_read!(_size, buff = '')
        sock = StringIO.new(buff)
        @req.send(:write_header, sock, @version, @path)
        buff
      end

      def kgio_addr
        '127.0.0.1'
      end

      def write(line)
        @out << line
      end

      def response
        res = NetStringIO.new(@out.string)
        Net::HTTPResponse.read_new(res)
      end

      def closed?
        true
      end
    end
  end
end
