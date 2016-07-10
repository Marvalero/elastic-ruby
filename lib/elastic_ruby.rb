require'pry'

module ElasticRuby
  Dir.glob('./lib/elastic_ruby/*rb').each { |path| require path }
  Dir.glob('./lib/elastic_ruby/entity/*rb').each { |path| require path }
end
