require_relative '../scr/pattern'

class Matches
  attr_accessor :patrones

  def initialize (patrones)
    @patrones=patrones
  end
  def matches?(object_match, &block)

     un_match = self.buscar_macheo(object_match)
     un_match ? self.ejecutar_bloque():
    raise EmptyMatchException.new("Can't call matches? without class and block")

  end

  def buscar_macheo (object_match)
    (patrones.select{|pattern| pattern.machea(object_match)}).first
  end

  def ejecutar_bloque(&bloque)
    bloque.call()
  end

end

class EmptyMatchException < Exception

end
