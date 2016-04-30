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
    if otra_lista.size<lista.size
      igual_elementos = otra_lista.zip(lista).map { |x, y| x == y }.all? { |z| z }
    else
      igual_elementos = lista.zip(otra_lista).map { |x, y| x == y }.all? { |z| z }
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
