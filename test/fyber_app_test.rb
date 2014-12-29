require 'test_helper'

class FyberAppTest < RackAppTest

  def test_get_index
    get '/'
    assert_equal 200, last_response.status
  end

  def test_post_offers_no_params
    travel_to Time.at(1417622933) do
      assert_raises FyberApi::MissingParams do
        VCR.use_cassette "offer#error", match_requests_on: [:method] do
          post '/offers'
        end
      end
    end
  end

  def test_post_offers_success
    travel_to Time.at(1417622933) do
      VCR.use_cassette "offer#success", match_requests_on: [:method] do
        post '/offers', uid: 'player1', pub0: 'campaign2', page: 1
        assert last_response.ok?
        assert_match "Tap  Fish", last_response.body 
      end
    end
  end

end