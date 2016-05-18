class Matches_1

  attr_accessor :pattern, :block, :valor

  def initialize
    @pattern = []
  end

  def with(*arg, &block)
    @pattern = arg
    @block = block
    if cumple_pattern?
      #bindar variables
      # @valor.instance_eval block
      self.instance_exec(&block)
      # true
    end
  end

  def matches?(valor, &block_patterns)
    @valor = valor
    self.instance_eval(&block_patterns)
  end

  def cumple_pattern?
    @pattern.all? do |matcher|
      matcher.call(@valor)
    end
  end
end