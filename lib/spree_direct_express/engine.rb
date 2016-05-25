module SpreeDirectExpress
  class Engine < Rails::Engine
    require 'spree/core'
    isolate_namespace Spree
    engine_name 'spree_direct_express'

    # use rspec for tests
    config.generators do |g|
      g.test_framework :rspec
    end

    def self.activate
      file = File.join(File.dirname(__FILE__), "../../app/models/spree/calculator/shipping/direct_express.rb")
      Rails.env.production? ? require(file) : load(file)

      Dir.glob(File.join(File.dirname(__FILE__), "../../app/**/*_decorator*.rb")) do |c|
        Rails.configuration.cache_classes ? require(c) : load(c)
      end
    end

    config.autoload_paths += %W(#{config.root}/lib)
    config.to_prepare &method(:activate).to_proc

    initializer "spree_direct_express.register.calculators", after: 'spree.register.calculators' do |app|
      file = File.join(File.dirname(__FILE__), "../../app/models/spree/calculator/shipping/direct_express.rb")
      Rails.env.production? ? require(file) : load(file)

      app.config.spree.calculators.shipping_methods << Spree::Calculator::Shipping::DirectExpress
    end

  end
end
