require 'test_helper'

class OfferTest < Minitest::Test

  def test_list
    request = stub(get: stub(body: response))
    FyberApi::Request.expects(:new).returns(request)
    offers= FyberApi::Offer.list(params)
    assert offers.any?, "no offers were parsed"
  end

  def test_title
    assert_match 'Tap  Fish', offer.title 
  end

  def test_payout
    assert_equal 90, offer.payout 
  end

  def test_thumbnail_low
    assert_match "http://cdn.sponsorpay.com/assets/1808/icon175x175-2_square_60.png", offer.thumbnail_low 
  end

  def test_existing_find_value_for_key
    assert_match "Download and START", offer.find_value_for('required_actions')
  end

  def test_non_existing_value_for_key
    assert_nil offer.find_value_for('non_existing_key')    
  end

  private

  def offer
    @offer ||= FyberApi::Offer.new(response['offers'].first)
  end

  def response
    @response ||= JSON(File.read('test/fixtures/response.json'))   
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