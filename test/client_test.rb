require 'test_helper'

class ClientTest < Minitest::Test

  def test_client_initialization_error
    assert_raises FyberApi::MissingParams do
      FyberApi::Client.init()
    end
  end

  def test_missing_params
    assert api_client.missing_params?, "Should have missing params"
  end

  def test_no_missing_params
    api_client.params = params
    refute api_client.missing_params?, "Should have no missing params"
  end

  def test_missing_param_list
    api_client.params = { "appid" => 157, 
                          "uid" => 'player1',
                          "device_id" => '123abc',
                          "pub0"  => 'campaign2'
                        }
    assert_includes api_client.missing_params, 'page'
  end


  def test_get_offers
    FyberApi::Offer.expects(:list)
    api_client_with_params.offers
  end

  private

  def api_client
    @api_client ||= FyberApi::Client.new
  end

  def api_client_with_params
    @api_client ||= FyberApi::Client.new(params)
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