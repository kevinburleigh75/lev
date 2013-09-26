module Lev

  class TermMapper

    def self.verbatim
      ScopedAndMapped.new(nil, nil)
    end

    def self.scope_and_map(scope, mapping)
      ScopedAndMapped.new(scope, mapping)
    end

    def map(inputs)
      raise AbstractMethodCalled
    end

  protected

    class ScopedAndMapped < TermMapper
      def initialize(scope=nil, mapping=nil)
        @scope = scope
        @mapping = mapping
      end

      def map(inputs)
        inputs = [inputs].flatten.compact
        inputs.collect do |input|
          mapped = (@mapping || {})[input] || input
          @scope.nil? ? mapped : [@scope, mapped].flatten
        end
      end
    end

  end

end