# class Symbol
#   def ejecutar (algo)
#
#
#     def foo
#       binding.local_variable_get(:a) #=> 1
#     end
#
#
#     true
#   end
# end


# Esta clase sirve como padre para los diferentes tipos de matchers
class Matcher
  def self.es_matcher? (x)
    x.is_a? self
  end
end
=begin
class Variable < Matcher
  attr_accessor :var
  def ejecutar (algo)
    @var = algo
    true
  end
end
=end

# class VariableSymbol < Matcher
#  include Symbol
  #attr_accessor :identificador
=begin
  def initialize(sym)
    @identidicador = sym
  end
=end

=begin
  def ejecutar (sym, algo)
    auxBinding = binding
    auxBinding.local_variable_set(sym.to_sym, algo)
    puts auxBinding.local_variable_get(sym.to_sym)
    true
  end
end
=end

class Valor < Matcher
  attr_accessor :primer_valor
  def initialize(a)
    @primer_valor=a
  end
  def ejecutar(segundo_valor)
    self.primer_valor.eql?segundo_valor
  end
end

class Tipo < Matcher
  attr_accessor :tipo
  def initialize(un_tipo)
    @tipo=un_tipo
  end
  def ejecutar(valor)
      valor.is_a? self.tipo
  end
end


class Lista < Matcher
  attr_accessor :lista, :condicion, :estrategia
  # Consideraciones: la lista de seteo puede tener matchers u otros objetos, los que son matchers tienen un tratamiento especial.
  # Con la estrategia evito repeticion de logica para distintos tamanios de listas.
  # Lo que hace es comprobar si cada elemento enlazado de las dos listas son iguales
  # o si matchea en caso que sea un matcher.
  def initialize(una_lista,una_condicion =true)
    @lista=una_lista
    @condicion=una_condicion
    @estrategia= Proc.new do |array|
      array.all? do |e1, e2| # Tomo un elemento del array y es [e1,e2]
        if Matcher.es_matcher? e2
          e2.ejecutar e1 # e2 es un matcher, ej: type(Integer).call(6)
        else
          e1 == e2
        end
      end
    end
  end

  def ejecutar(objetos)
    return false unless objetos.is_a? Array # Condicion necesaria: debe ser un Array

    # Caso a tener en cuenta, comparo los tamanios de las listas ya que si una es mayor que la otra, tengo que
    # tratarlos diferentes. Al usar el metodo zip, delego el trabajo para que me devuelva una lista enlazada por
    # el indice. Ej: [1,2,3].zip [1,4,5] #=> [[1, 1], [2, 4], [3, 5]]
    # Un caso particular del zip es si la lista izquierda es mayor que la derecha
    # Ej: [1,2,3].zip [1,4] #=> [[1, 1], [2, 4], [3, nil]]
    # El nil perjudicaria el resultado final del matcher, una solucion es cambiar el orden de las listas
    # Ej: [1,4].zip [1,2,3] #=> [[1, 1], [2, 4]]
    # Con la lista resultante debo trabajar, luego comparo los tamanios si son iguales o no para la condicion
    # , ya que se pide que los primeros N elementos sean identicos o matchen con la lista del llamado.

    if objetos.size <= self.lista.size
      # ejemplo: list([1,2,3]).call([1,2])
      elementos_identicos = self.estrategia.call (objetos.zip(self.lista))
      # objetos.zip(self.lista).all?{ |obj, obj2| if Matcher.es_matcher?(obj); obj2.ejecutar(obj) else obj==obj2 end}
    else
      # ejemplo: list([1,2,3]).call([1,2,3,4])
      elementos_identicos = self.estrategia.call (self.lista.zip(objetos).map {|x| x.reverse})
      # self.lista.zip(objetos).all?{ |obj, obj2| if Matcher.es_matcher?(obj); obj2.ejecutar(obj) else obj==obj2 end}
    end
    igual_tamanio = objetos.size == lista.size
    if condicion
      elementos_identicos & igual_tamanio
    else
      elementos_identicos
    end
  end
end

class Duck < Matcher
  attr_accessor :metodos
  def initialize(*argumentos)
    @metodos=argumentos
  end
  def ejecutar(un_objeto)
    self.metodos.all? { |method| un_objeto.respond_to? method}
  end
end

class Combinator1
  attr_accessor :combinador
  def initialize(*set)
    @combinador= [].push(set)
  end
  def and(*matchers)
    self.combinador << 'and' << matchers
    self
  end
  def or(*matchers)
    self.combinador << 'or' << matchers
    self
  end
  def not
    self.combinador << 'not'
    self
  end
  def ejecutar(algo)
    resultado=self.combinador[0].all?{|matcher| matcher.ejecutar algo}
    block= Proc.new{}
    self.combinador.each_with_index do |elem,pos|
      next if pos==0
      case elem
        when 'and'
          block= proc{|otro| otro & resultado}
        when 'or'
          block= proc{|otro| otro || resultado}
        when 'not'
          resultado= !resultado
        else
          resultado_y= elem.all? {|matcher| matcher.ejecutar algo}
          resultado= block.call resultado_y
      end
    end
    resultado
  end
end

class Patron
  attr_accessor :coleccion, :bloques, :excepcion

  def initialize
    @coleccion, @bloques= [], []
  end

  def with (*args,&un_bloque)
    self.coleccion.push(args)
    self.bloques << un_bloque
  end

  def otherwise (&un_bloque)
    @excepcion= un_bloque
  end

  def match(un_objeto)
    resultado = false
    self.coleccion.each_with_index do |matchers, pos|
      resultado = matchers.all?{|matcher| matcher.ejecutar(un_objeto)}
        if resultado
          self.bloques[pos].call un_objeto
          return
        end
    end
    self.excepcion.call unless resultado
  end
end
