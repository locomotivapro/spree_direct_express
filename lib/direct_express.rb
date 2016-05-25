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
