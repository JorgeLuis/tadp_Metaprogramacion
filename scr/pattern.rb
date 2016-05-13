
class Pattern
  attr_accessor :matchers

  def initialize
    @matchers ={}
  end
  def machea(un_objeto)
    un_mach = self.buscar_macheo(un_objeto)
    un_mach ? ejecutar_match(un_mach,un_objeto): nil
  end


  def buscar_macheo(un_objeto)
    self.matchers[un_objeto]
  end


  def ejecutar_match(un_mach,un_objeto)
    self.matchers[un_mach].call(un_objeto)
  end

  def self.with (matchers,&bloque)
    self.matchers[matchers]=bloque
  end
end