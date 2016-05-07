# class Symbol
#   def ejecutar (algo)
#     instance_eval "#{self.to_s} = #{algo}"
#     true
#   end
# end

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
          break
        end
    end
    self.excepcion.call unless resultado
  end
end
