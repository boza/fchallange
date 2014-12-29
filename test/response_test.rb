require 'test_helper'

class ResponseTest < Minitest::Test

  def test_body
    refute_empty successful_response.body['offers']
  end

  def test_error_response
    assert_raises FyberApi::RequestError do
     FyberApi::Response.new( stub(code: 400, headers: {}) )
    end
  end

  def test_invalid_response
    assert_raises FyberApi::InvalidSignature do
      FyberApi::Response.new( stub(code: 200, body: '', headers: { "x-sponsorpay-response-signature" => '123abc' }) )
    end
  end

  private

  def successful_response
    @success_response ||= FyberApi::Response.new( stub(code: 200, body: File.read('test/fixtures/response.json') ,headers: { "x-sponsorpay-response-signature" => Digest::SHA1.hexdigest(File.read('test/fixtures/response.json') + FyberApi::Client::API_KEY) } ))
  end 


end