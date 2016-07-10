module ElasticRuby
  module Entity
    class Document
      attr_accessor :args

      def initialize(args)
        self.args = args
      end

      def types
        args['_type']
      end

      def id
        args['_id']
      end

      def source
        args['_source']
      end

      def index_name
        args['_index']
      end
    end
  end
end
