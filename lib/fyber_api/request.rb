module FyberApi
  class Request
    include HTTParty

    attr_accessor :params

    base_uri 'api.sponsorpay.com'

    def initialize(route, params)
      @params = params
      @route  = route
      sign_request
      @query = { query: @params }
    end

    def sign_request
      parameters = @params.to_a.map { |pairs| pairs.join('=') }.sort.join('&')
      query_string = '%{keys}&%{api}' % { keys: parameters, api: Client::API_KEY }
      @params[:hashkey] = Digest::SHA1.hexdigest(query_string)
    end

    def get
      Response.new( self.class.get(@route, @query) )
    end

  end  
end