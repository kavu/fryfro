require 'httparty'

module Fryfro
  class Endpoint
    include HTTParty

    headers 'Accept' => 'application/xml'

    debug_output $stdout if ENV['DEBUG']

    class << self
      def [](metric)
        Proc.new do |code, key, opts = {}|
          hash = { api_access_code: code }
          hash[:api_key] = key if key
          hash.merge!(opts)

          get("/#{camelize(metric)}?#{queryize(hash)}")
        end
      end

      def queryize(hash)
        camelized_hash = Hash[hash.map { |k, v| [camelize_key(k), v] }]
        URI.encode_www_form(camelized_hash)
      end

      def camelize(sym)
        sym.to_s.split('_').map { |w| w.capitalize }.join
      end

      def camelize_key(sym)
        parts = sym.to_s.split('_')
        parts[0] + parts[1..-1].map { |w| w.capitalize }.join
      end
    end
  end
end
