module DirectExpress
  class Parser

    RESPONSE_REGEX = /<valorfrete>([0-9]{1,3}\.[0-9]{1,2})<\/valorfrete>.*<prazoentrega>([0-9]{1,2})<\/prazoentrega>/m

    attr_reader :result

    def initialize(response_hash)
      @response_hash = response_hash
      parse_hash
    end

    private

    ResponseResult = Struct.new(:amount, :days)

    def parse_hash
      response_string = @response_hash[t(:compute_response)][t(:compute_result)]
      data = RESPONSE_REGEX.match response_string
      price, days = data[1].to_f, data[2].to_i
      @result = ResponseResult.new(price, days)
    end

    def t(key)
      Translator.t(key)
    end

  end
end
