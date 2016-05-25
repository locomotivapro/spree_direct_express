module DirectExpress
  class Translator

    PT_PARAMS = {
      login: 'login',
      weight: 'peso',
      zipcode: 'cepDestino',
      amount: 'valor'
    }

    def self.translate(en_params)
      en_params.inject({}) do |result, (key, value)|
        new_key = PT_PARAMS[key]
        result[new_key] = value
        result
      end
    end

    def self.t(key)
      {
        compute: :calcular_frete,
        compute_response: :calcular_frete_response,
        compute_result: :calcular_frete_result,
      }.fetch(key, "#{key} missing")
    end

  end
end
