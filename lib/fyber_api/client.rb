module FyberApi
  class Client

    API_KEY = 'b07a12df7d52e6c118e5d47d3f9e60135b109a1f'

    REQUIRED_PARAMS = %w(appid uid device_id pub0 page)

    DEFAULT_PARAMS = { 
                        timestamp: Time.now.to_i, 
                        format: 'json', 
                        locale: 'de',
                        ip: '109.235.143.113',
                        offer_types: '112'
                      }

    def initialize(params={})
      @params = DEFAULT_PARAMS.merge(params)
      raise MissingParams.new(" #{REQUIRED_PARAMS.join(',')} are required") if missing_params?
    end

    def offers
      Offer.list(@params)
    end

    def missing_params?
      ( ( @params.keys - DEFAULT_PARAMS.keys ) - REQUIRED_PARAMS ).any?
    end
  
  end  
end