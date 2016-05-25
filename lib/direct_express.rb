require 'savon'
require 'direct_express/client'
require 'direct_express/translator'
require 'direct_express/parser'

module DirectExpress

  module Config
    attr_writer :environment

    def wsdl_url
      if @environment == :production
        'http://wsdirect.directlog.com.br/v2/wsdirectlog.asmx?wsdl'
      else
        'http://wsdirect.directlog.com.br/dev/wsdirectlog.asmx?wsdl'
      end
    end
  end

  extend Config

end

#client = DirectExpress::Client.new
#params = { login: '8333', weight: '2', zipcode: '03146020', amount: '250' }
#p client.calculate(params)
