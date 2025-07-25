# frozen_string_literal: true

module RubyLLM
  # Holds per-call configs
  class Context
    attr_reader :config

    def initialize(config)
      @config = config
      @connections = {}
    end

    def chat(*args, **kwargs, &block)
      Chat.new(*args, **kwargs, context: self, &block)
    end

    def embed(*args, **kwargs, &block)
      Embedding.embed(*args, **kwargs, context: self, &block)
    end

    def paint(*args, **kwargs, &block)
      Image.paint(*args, **kwargs, context: self, &block)
    end

    def connection_for(provider_module)
      slug = provider_module.slug.to_sym
      @connections[slug] ||= Connection.new(provider_module, @config)
    end
  end
end
