require 'typhoeus'
require 'json'

module ElasticRuby
  class Client
    attr_accessor :server

    def initialize(server:)
      @server = server
    end

    def all_indexes
      request_body('/_cat/indices?format=json')
    end

    def types_for_index(name)
      request_body("/#{name}")
    end

    def all_documents(index:, type:)
      request_body("/#{index}/#{type}/_search")
    end

    private

    def request_body(path)
      req = Typhoeus.get uri(path)

      raise "Failed request: #{req.inspect}" unless req.success?
      JSON.parse(req.body)
    end

    def uri(path)
      "#{server}#{path}"
    end
  end
end
