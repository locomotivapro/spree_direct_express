module DirectExpress
  class Client

    def initialize(environment=:development)
      DirectExpress.environment = environment
    end

    def calculate(params)
      response = client.call Translator.t(:compute), message: Translator.translate(params)
      response.success? ? parse(response.body) : nil
    end

    private

    def client
      @client ||= Savon.client(
        wsdl: DirectExpress.wsdl_url,
        env_namespace: :soap,
        namespace_identifier: :dir
      )
    end

    def parse(response_hash)
      Parser.new(response_hash).result
    end

  end
end
