require 'digest/md5'
require_dependency 'spree/shipping_calculator'

module Spree
  module Calculator::Shipping
    class DirectExpress < ShippingCalculator
      preference :login, :string, default: '8333'

      def available?(package)
        !compute(package).nil?
      #rescue Spree::ShippingError
        #false
      end

      def self.description
        'Integrate with Direct Express courrier'
      end

      def compute_package(package)
        order = package.order
        response = retrieve_rate_from_cache(package, order)

        return nil if response.kind_of?(Spree::ShippingError)
        return nil if response == 0.0

        return response
      end

      private

      def retrieve_rate(package, order)
        environment = Rails.env.to_sym
        params = {
          login: self.preferred_login,
          weight: package_weight(package),
          zipcode: order.ship_address.zipcode,
          amount: order.total.to_f
        }

        webservice_client = ::DirectExpress::Client.new(environment)
        response = webservice_client.calculate(params)
        response.price
      end

      def cache_key(package, order)
        stock_location = package.stock_location.nil? ? "" : "#{package.stock_location.id}-"
        ship_address = order.ship_address
        contents_hash = Digest::MD5.hexdigest(package.contents.map {|content_item| content_item.variant.id.to_s + "_" + content_item.quantity.to_s }.join("|"))
        @cache_key = "#{self.class.to_s.demodulize.downcase}-#{stock_location}-#{order.number}-#{ship_address.country.iso}-#{fetch_best_state_from_address(ship_address)}-#{ship_address.city}-#{ship_address.zipcode}-#{contents_hash}-#{I18n.locale}".gsub(" ","")
      end

      def fetch_best_state_from_address(address)
        address.state ? address.state.abbr : address.state_name
      end

      def package_weight(package)
        default_weight = 1.0

        package_weight = package.contents.inject(0.0) do |total_weight, content_item|
          item_weight = content_item.variant.weight.to_f
          item_weight = default_weight if item_weight <= 0
          total_weight += item_weight * content_item.quantity
        end

        package_weight
      end

      def retrieve_rate_from_cache(package, order)
        Rails.cache.fetch(cache_key(package, order)) do
          retrieve_rate(package, order)
        end
      end

    end
  end
end
