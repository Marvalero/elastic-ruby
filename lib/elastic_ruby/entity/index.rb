module ElasticRuby
  module Entity
    class Index
      attr_accessor :args

      def initialize(args)
        self.args = args
      end

      def type_names
        args[index_name]['mappings'].keys
      end

      def types
        @types ||= type_names.map do |name|
          Entity::Type.new name: name, args: args[index_name]['mappings'][name]
        end
      end

      def index_name
        args.keys.first
      end
    end
  end
end
