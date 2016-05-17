require_relative '../scr/pattern'

class Matches
  attr_accessor :patrones

  # @param [Object] patrones
  def initialize (patrones)
    @patrones=patrones
  end
  # def matches?(object_match, &block)
  #
  #    un_match = self.buscar_macheo(object_match)
  #    if un_match ? self.ejecutar_bloque(block) elsif
  #     raise EmptyMatchException.new("Can't call matches? without class and block")
  #
  # end
  #
  # def buscar_macheo (object_match)
  #
  #    @patrones.any?{|p|p.ejecutar(5)}
  #   #self.patrones.select{|pattern| pattern.machea(object_match)}
  #   #true
  # end
  #
  # def ejecutar_bloque(&bloque)
  #   bloque.call()
  # end

   def matches1?(object_match, &block)
     pattern = Pattern.new(object_match)
     pattern.instance_eval(&block)
    end




end
