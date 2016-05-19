class Matches_1

  attr_accessor :pattern, :block, :valor

  def initialize(*arg)
    @pattern = arg || []
  end

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

   def matches2?(object_match, &block)
         lista_matches= object_match.flapmap
         matches_encontrados =buscar_macheo(lista_matches)

         #sino existe un match encontes que lance una exeption
         if matches_encontrados.nil?
        raise EmptyMatchException.new("Can't call matches? without class and block")
        end

         self.instance_eval(&block_patterns)

   end

    #busca si se cumple algun match de la lista, con el select
    #hace un filter como el de haskell, sino encuentra devuelve la lista vacia
    #de la lista trae el primero.
    #la funcion tiene que devolver el primer matcheo de la lista o nill
   def buscar_macheo (lista_matches)
     return   (lista_matches.select{|m|m.call(@valor)}).firts  #aca puede ser que rompe!!!
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


class EmptyMatchException<Exception

end