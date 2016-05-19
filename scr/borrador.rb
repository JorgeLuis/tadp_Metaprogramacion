class Matcher
  def self.es_matcher? (x)
    x.is_a? self
  end
end

class Object
  def val(value)
    Valor.new value
  end

  def type(un_tipo)
    Tipo.new un_tipo
  end

  def list(un_array, bool=true)
    Lista.new(un_array,bool)
  end

  #segun los test del punto 4 tiene que ir en object
  #x = [ 1 , 2 , 3 ] o x = Object .new  o x =2
  # def matches?(valor, &block_patterns)
  #   @valor = valor
  #   self.instance_eval(&block_patterns)
  # end
  #
  #
  # def matches2?(*possible_matchs, &block)
  #   matches_pattern = possible_matchs.flat_map
  #
  #   matches_pattern.select{|match| Matches_1.new(match).cumple_pattern?.instance_eval &block }
  # end
end


class Valor
  attr_accessor :value
  def initialize(valor)
    @value=valor
  end
  def call(obj)
    self.value.eql? obj
  end
end

class Variable < Matcher
  def initialize(simbolo,algo)
    Object.send :attr_accessor, simbolo
    send "#{simbolo.to_s}=".to_sym, algo
    eval(simbolo.to_s, binding)
  end
end

class Symbol
  def call(obj)
    Variable.new(self,obj)
    true
  end

  def self.es_symbol? (x)
    x.is_a? self
  end

end

class Tipo
  attr_accessor :tipo
  def initialize(un_tipo)
    @tipo=un_tipo
  end
  def call(valor)
    valor.is_a? self.tipo
  end
end

class Lista < Matcher
  attr_accessor :lista, :condicion, :estrategia
  def initialize(una_lista,una_condicion =true)
    @lista=una_lista
    @condicion=una_condicion
    @estrategia= Proc.new do |array|
      array.all? do |e1, e2| # Tomo un elemento del array y es [e1,e2]
        if Matcher.es_matcher? e2
          e2.call e1 # e2 es un matcher, ej: type(Integer).call(6)
        else
          if Symbol.es_symbol? e2
            e2.call(e1)
          else
            if Symbol.es_symbol? e1
              e1.call(e2)
            else
              e1 == e2
            end
          end
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







# pruebas
# val(5).call(6)
# :a.call(5)
# type(Integer).call(5)
# list([1,2,3],true).call([1,3])


# def hi
# 	puts 'aaaaa'
# end

# def hi2
# 	puts 'bbbbb'
# end

# def with(&block)
# 	instance_eval &block
# end

# with{
# 	hi
# 	hi2
# }
	
