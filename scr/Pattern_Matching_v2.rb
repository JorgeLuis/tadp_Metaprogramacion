module Validar
  def valida(obj)
    return obj if obj.is_a? Array
    [].push obj
  end
end
module Operadores
  include Validar
  def and(*args)
    And.new(valida(self), valida(*args))
  end
  def or(*args)
    Or.new(valida(self), valida(*args))
  end
  def not
    Not.new(valida(self))
  end
end

# Open Class Object
class Object
  include Operadores
  # Sintaxis de los matchers, menos la de variable que es un simbolo
  def val(value)
    Valor.new value
  end
  def type(tipo)
    Tipo.new tipo
  end
  def list(array, eq_tam)
    Lista.new(array, eq_tam)
  end
  def duck(*args)
    Duck.new(*args)
  end
  # Pattern
  def matches?(x, &block_patterns)
    Matches_1.new.matches?(x, &block_patterns)
  end
end


# Padre de los matchers
class Matcher
  def self.es_matcher?(algo)
    (algo.is_a? self) || (algo.is_a? Symbol)
  end
end

# Open Class Symbol, simula al matcher variable
class Symbol
  def call(x)
    # Variable.new.set self, x
    Object.send :define_method, self, &proc{x}
    true
  end
end
# Matchers
class Valor
  attr_accessor :valor
  def initialize(value)
    @valor= value
  end
  def call(x)
    self.valor.eql? x
  end
end

class Tipo < Matcher
  attr_accessor :tipo
  def initialize(tipo)
    @tipo= tipo
  end
  def call(x)
    x.is_a? self.tipo
  end
end

class Lista < Matcher
  attr_accessor :lista, :condicion, :estrategia
  def initialize(una_lista,una_condicion =true)
    @lista, @condicion=una_lista, una_condicion
    @estrategia= Proc.new do |array|
      array.all? do |e1, e2| # Tomo un elemento del array y es [e1,e2]
        if Matcher.es_matcher? e2
          e2.call e1 # e2 es un matcher, ej: type(Integer).call(6)
        else
          e1 == e2
        end
      end
    end
  end

  def call(un_array)
    return false unless un_array.is_a? Array # Condicion necesaria: debe ser un Array
    if un_array.size <= self.lista.size
      elementos_identicos = self.estrategia.call(un_array.zip(self.lista))
    else
      elementos_identicos = self.estrategia.call(self.lista.zip(un_array).map {|x| x.reverse})
    end
    igual_tamanio = un_array.size == lista.size
    if condicion
      elementos_identicos & igual_tamanio
    else
      elementos_identicos
    end
  end
end

class Duck
  attr_accessor :metodos
  def initialize(*argumentos)
    @metodos=argumentos
  end
  def call(x)
    self.metodos.all? { |method| x.respond_to? method}
  end
end

# Open Class
class Array
  include Operadores
end

# Operadores
class Combinator
  attr_accessor :left, :right
  def initialize(operando1, operando2)
    @left, @right = operando1, operando2
  end
end
class And < Combinator
  def call(x)
    self.left.all?{|matcher| matcher.call x} && self.right.all?{|matcher| matcher.call x}
  end
end
class Or < Combinator
  def call(x)
    (self.left+self.right).any?{|matcher| matcher.call x}
  end
end
class Not < Combinator
  def initialize(operando1)
    @left= operando1
  end
  def call(x)
    !self.left.all?{|matcher| matcher.call x}
  end
end

# Pattern
class Pattern
  attr_accessor :pattern, :block, :valor
  def with(*arg, &block)
    @pattern = arg
    @block = block
    if cumple_pattern?
      # @valor.instance_eval block
      self.instance_exec(&block)
    end
  end
  def matches?(valor, &block_patterns)
    @valor = valor
    self.instance_eval(&block_patterns)
  end
  def otherwise(&block_patterns)
    self.instance_eval(&block_patterns)
  end
  def cumple_pattern?
    @pattern.all? do |matcher|
      matcher.call(@valor)
    end
  end
end