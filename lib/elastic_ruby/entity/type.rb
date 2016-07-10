module ElasticRuby
  module Entity
    class Type
      attr_accessor :args, :name

      def initialize(name:, args:)
        self.args = args
        self.name = name
      end

      def fields
        args['properties'].keys
      end
    end
  end
end
