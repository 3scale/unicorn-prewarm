require 'unicorn/prewarm'

RSpec.describe 'unicorn' do
  let(:server) { Unicorn::HttpServer.new(app) }
  let(:app){ Proc.new{ [200, [''], []] } }

  it 'calls the app' do
    expect(Unicorn.prewarm(server)).to be_a(Net::HTTPSuccess)
  end
end
