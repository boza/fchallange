require 'test_helper'

class RequestTest < Minitest::Test


  def test_sign_request
    parameters = params.to_a.map { |pairs| pairs.join('=') }.sort.join('&')
    query_string = '%{keys}&%{api}' % { keys: parameters, api: FyberApi::Client::API_KEY }
    
    assert_equal request.params[:hashkey], Digest::SHA1.hexdigest(query_string)
  end

  def test_get
    VCR.use_cassette "offers#mock" do
      FyberApi::Response.expects(:new)
      request.get
    end
  end

 
  private

  def request
    @request ||= FyberApi::Request.new('/feed/v1/offers.json', params)
  end

  def params
    @params ||= { "appid" => 157, 
                  "uid" => 'player1',
                  "device_id" => '123abc',
                  "pub0"  => 'campaign2',
                  "page"  => 1
                }
  end 

end