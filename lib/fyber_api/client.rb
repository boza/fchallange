module FyberApi
  class Client

    attr_accessor :params

    API_KEY = 'b07a12df7d52e6c118e5d47d3f9e60135b109a1f'

    REQUIRED_PARAMS = %w(appid uid device_id pub0 page)

    DEFAULT_PARAMS = { 
                        timestamp: Time.now.to_i, 
                        format: 'json', 
                        locale: 'de',
                        ip: '109.235.143.113',
                        offer_types: '112'
                      }

    def self.init(params={})
      new(params).tap do |client|
        raise FyberApi::MissingParams.new(" #{REQUIRED_PARAMS.join(',')} are required") if client.missing_params?
      end
    end

    def initialize(params={})
      @params = DEFAULT_PARAMS.merge(params)
    end

    def offers
      Offer.list(@params)
    end

    def missing_params?
      missing_params.any?
    end

    def missing_params
      REQUIRED_PARAMS.reject do |param|
        ( params.keys - DEFAULT_PARAMS.keys ).include?(param)
      end
    end
  
  end  
end