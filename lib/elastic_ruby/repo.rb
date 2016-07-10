module ElasticRuby
  class Repo
    def all_indexes
      client.all_indexes.map do |ind|
        ind['index']
      end
    end

    def types_for_index(name)
      Entity::Index.new client.types_for_index(name)
    end

    def all_documents(index:, type:)
      res = client.all_documents(index: index, type: type)
      res['hits']['hits'].map do |doc|
        Entity::Document.new(doc)
      end
    end

    private

    def client
      @client ||= ElasticRuby::Client.new(server: config.server)
    end

    def config
      @config ||= ElasticRuby::Config.new
    end
  end
end
