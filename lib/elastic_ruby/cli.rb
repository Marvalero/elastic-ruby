require 'thor'

module ElasticRuby
  class Cli < Thor
    desc 'indexes', 'show elasticsearch indexes'
    def indexes
      repo.all_indexes.each do |name|
        index_info = repo.types_for_index(name)
        puts "Index '#{index_info.index_name}' with types:"
        index_info.types.each do |type|
          puts " - Type '#{type.name}' with fields: #{type.fields.join(', ')}"
        end
      end
    end

    desc 'documents', 'show documents for an index'
    method_option :index,
                  aliases: '-i',
                  desc: 'Index name',
                  required: true
    method_option :type,
                  aliases: '-t',
                  desc: 'Type name',
                  required: true
    def documents(opts = options)
      opts = keys_to_sym(opts)
      repo.all_documents(opts).each do |doc|
        puts "Document with id #{doc.id}, source: #{doc.source}"
      end
    end

    private

    def keys_to_sym(opts)
      opts.each_with_object({}) do |(k, v), hash_with_sym|
        hash_with_sym[k.to_sym] = v
        hash_with_sym
      end
    end

    def repo
      @repo ||= ElasticRuby::Repo.new
    end
  end
end
