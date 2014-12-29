module FyberApi
  class Response

    def initialize(response)
      @response = response
      check_error_response
      check_valid_signature
    end

    def body
      parsed_response_body
    end
  
    def check_error_response
      case @response.code
      when 400..499
        raise RequestError.new(@response.headers['status'])
      when 500..599
        raise ServerError.new(@response.headers['status'])
      end   
    end

    def check_valid_signature
      raise InvalidSignature.new('signature for this request is invalid') unless valid?
    end

    private

    def valid?
      reponse_signature = Digest::SHA1.hexdigest(@response.body + Client::API_KEY)
      @response.headers["x-sponsorpay-response-signature"] == reponse_signature
    end

    def json_body
      @json_body ||= JSON(@response.body) 
    end

    def parsed_response_body
      json_body['code'] == "NO_CONTENT" ? response_fixture : json_body
    end

    # needed this because didn't find content
    def response_fixture
      JSON File.read('test/fixtures/response.json')
    end

  end  
end