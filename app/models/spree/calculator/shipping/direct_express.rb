require 'digest/md5'
require 'ostruct'
require_dependency 'spree/shipping_calculator'

module Spree
  module Calculator::Shipping
    class DirectExpress < ShippingCalculator

      def available?(package)
      end

      def self.description
      end

      def self.service_code
      end

      def compute_package(package)
      end

    end
  end
end
