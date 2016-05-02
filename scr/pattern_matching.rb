class Variable
  attr_accessor :var
  def ejecutar (algo)
    @var = algo
    true
  end
end

class Valor
  attr_accessor :primer_valor
  def initialize(a)
    @primer_valor=a
  end
  def ejecutar(segundo_valor)
    self.primer_valor.eql?segundo_valor
  end
end

class Tipo
  attr_accessor :tipo
  def initialize(un_tipo)
    @tipo=un_tipo
  end
  def ejecutar(valor)
      valor.is_a?self.tipo
  end
end

class Lista
  attr_accessor :lista, :condicion

  def initialize(una_lista,una_condicion =true)
    @lista=una_lista
    @condicion=una_condicion
  end

  def ejecutar(otra_lista)
    @tipo=Tipo.new(Variable)
    if otra_lista.size<lista.size
      igual_elementos = otra_lista.zip(lista).all?{ |x, y| if @tipo.ejecutar(x); x.ejecutar(y) else x==y  end}
    else
      igual_elementos = lista.zip(otra_lista).all?{ |x, y| if @tipo.ejecutar(x); x.ejecutar(y) else x==y  end}
    end
    igual_tamanio = otra_lista.size == lista.size
    if condicion
      igual_elementos & igual_tamanio
    else
      igual_elementos
    end
      end
end

class Duck
  attr_accessor :metodos
  def initialize(*argumentos)
    @metodos=argumentos
  end

  def ejecutar(un_objeto)
  self.metodos.all? { |method| un_objeto.respond_to? method}
  end
end


class Combinators
  attr_accessor :matchers

  def initialize(*un_matchers)
    @matchers = un_matchers
  end

  def and
  self.matchers.all? {
      |un_Matcher|
      instancia.send "#{un_Matcher}", un_Matcher
    }
  end

  def or(comparador)
    instancia = @a_Matcher.new
    self.matchers.any? { |un_Matcher|
      instancia.send "#{un_Matcher.criterio}", un_Matcher.valor, comparador
    }
  end

  def not(compadador)
    instancia = @a_Matcher.new
    instancia.send "#{self.matchers[0].criterio}", self.matchers[0].valor ,compadador
  end
end

class Patron
  attr_accessor :matchers, :bloque

  def with (*args,&un_bloque)
    self.matchers =*args  #guardo la lista o elementos matchers
    self.bloque = un_bloque
  end

  def otherwise (&un_bloque)
    self.bloque = un_bloque
  end

  def ejecutar(un_objeto)
    if self.match(un_objeto)  #Pregunto si matchea con todos los matchers
      self.bloque.call(un_objeto) #Ejecuto el bloque con el objeto dado
    end
  end

  def match(un_objeto)
    self.matchers.all? {|matcher| matcher.ejecutar(un_objeto)} #comprueba si todos los matchers responden con un_obejto
  end
end

class Animal
  attr_accessor :energia
  def comer
    self.energia = 10
  end
end

