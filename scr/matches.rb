
class Matches
  attr_accessor :patrones

  def initialize (p)
    @patrones=p
  end
  def self.matches?(object_match, &block)

     un_match = self.buscar_macheo(object_match)
     un_match ? self.ejecutar_bloque(block):
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
