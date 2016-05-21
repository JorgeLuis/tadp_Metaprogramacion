require 'ostruct'

class Matches_1

  attr_accessor :pattern, :block, :valor, :patrones, :bloque_otherwise

  def initialize(*arg)
    # @pattern = arg || []
    @patrones = []
  end

  # def with(*arg, &block)
  #   @pattern = arg
  #   @block = block
  #   if cumple_pattern?
  #     # @valor.instance_eval block
  #     self.instance_exec(&block)
  #   end
  # end


  def with1(*arg, &block)
    patron = OpenStruct.new
    # patron = Patron.new
    patron.matchs = arg
    patron.bloque = block
    @patrones << patron
  end



  def matches?(valor, &block_patterns)
    @valor = valor
    self.instance_eval(&block_patterns)

    patron_ejecutar =@patrones.select { |patron| cumple_pattern1?(patron.matchs)}.first

    if patron_ejecutar.nil?
      return self.instance_exec(&@bloque_otherwise)
    else
      bloque_ejecutar = patron_ejecutar.bloque
      return self.instance_exec(&bloque_ejecutar)
    end
  end

  def otherwise(&block_ejecutar)
    # patron = OpenStruct.new
    # # patron = Patron.new
    # patron.matchs = []
    # patron.bloque = block_ejecutar
    @bloque_otherwise = block_ejecutar
    # self.instance_exec(&block_ejecutar)
  end

  # def cumple_pattern?
  #   @pattern.all? do |matcher|
  #     matcher.call(@valor)
  #   end
  # end

  def cumple_pattern1?(pattern)
  pattern.all? do |matcher|
    matcher.call(@valor)
  end
  end
#
# def matches2?(object_match, &block)
#       lista_matches= object_match.flapmap
#       matches_encontrados =buscar_macheo(lista_matches)
#
#       #sino existe un match encontes que lance una exeption
#       if matches_encontrados.nil?
#      raise EmptyMatchException.new("Can't call matches? without class and block")
#      end
#
#       self.instance_eval(&block_patterns)
#
# end
#
#  #busca si se cumple algun match de la lista, con el select
#  #hace un filter como el de haskell, sino encuentra devuelve la lista vacia
#  #de la lista trae el primero.
#  #la funcion tiene que devolver el primer matcheo de la lista o nill
# def buscar_macheo (lista_matches)
#   return   (lista_matches.select{|m|m.call(@valor)}).firts  #aca puede ser que rompe!!!
# end

end


# class EmptyMatchException<Exception
#
# end
