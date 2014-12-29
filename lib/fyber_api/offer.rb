module FyberApi
  class Offer

    attr_accessor :offer_information

    def self.list(params)
      response = Request.new('/feed/v1/offers.json', params).get
      response_offers = response.body['offers'] || []
      response_offers.map { |offer| new(offer) }
    end

    def initialize(offer_information={})
      @offer_information = offer_information
    end

    def title
      find_value_for('title')
    end

    def payout
      find_value_for('payout')
    end

    def thumbnail_low
      find_thumbnail('lowres')
    end

    def thumbnail_high
      find_thumbnail('hires')
    end

    def find_thumbnail(thumbnail_key)
      (find_value_for('thumbnail') || {} ).fetch(thumbnail_key, nil)
    end

    def find_value_for(key)
      @offer_information.fetch(key, nil)
    end
  
  end  
end