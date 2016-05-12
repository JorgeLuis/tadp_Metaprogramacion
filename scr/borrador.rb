class Matcher
  def self.es_matcher? (x)
    x.is_a? self
  end
end


class Valor
	attr_accessor :value
	def set(valor)
		@value=valor
	end
	def call(obj)
		self.value.eql? obj
	end
end

# class Symbol
# 	attr_accessor :a
# 	def call(obj)
# 		@a=obj
# 		true
# 	end
# end

class Tipo
	attr_accessor :tipo
  	def set(un_tipo)
    	@tipo=un_tipo
  	end
  	def call(valor)
      valor.is_a? self.tipo
  end
end

class Lista < Matcher
  attr_accessor :lista, :condicion, :estrategia
  def set(una_lista,una_condicion =true)
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


# Matchers
def val(value)
	return Valor.new.set value
end

def type(un_tipo)
	return Tipo.new.set un_tipo
end

def list(un_array, bool=true)
	return Lista.new.set(un_array,bool)
end
	
	




# pruebas
# val(5).call(6)
# :a.call(5)
# type(Integer).call(5)
list([1,2,3],true).call([1,3])


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
	
