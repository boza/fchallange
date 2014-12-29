module Fyber

  class FyberError < StandardError; end
  class InvalidSignature < FyberError; end
  class MissingParams < FyberError; end
  class UnknownError < FyberError; end
  class ServerError < FyberError; end
  class RequestError < FyberError;end
  
end