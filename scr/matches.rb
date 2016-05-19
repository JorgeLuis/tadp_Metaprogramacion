require_relative '../scr/pattern'

class Matches
  attr_accessor :patrones

  # @param [Object] patrones
  def initialize (patrones)
    @patrones=patrones
  end

  #
  # def ejecutar_bloque(&bloque)
  #   bloque.call()
  # end

   def matches1?(object_match, &block)
     pattern = Pattern.new(object_match)
     pattern.instance_eval(&block)
    end




end
