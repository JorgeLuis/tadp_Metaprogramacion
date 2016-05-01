class Matcher

  def val(variable_A, variable_B)
    variable_A.eql? variable_B
  end
  
  def type(objeto,tipo)
    objeto.class.equal? tipo
  end

  def duck_typing(*args, obje)
    args.all? { |method| obje.respond_to? method}
  end
end


class Combinators
  attr_accessor :matchers, :a_Matcher

  def initialize(a_Matcher)
    @a_Matcher = a_Matcher
    @matchers = []
  end

  def set_Matchers(sym, a_valor)
    struct_matcher = Struct.new(:criterio , :valor)
    matcher = struct_matcher.new
    matcher.criterio = sym
    matcher.valor = a_valor
    self.matchers << matcher
#    self.matchers.each{|matcher, valor|
#      if matcher.eql?(sym) and valor.nil?
#        self.matchers[matcher] = a_value
#      end}
  end

  def and(comparador)
    instancia = @a_Matcher.new
    matchers.all? { |un_Matcher|
      instancia.send "#{un_Matcher.criterio}", un_Matcher.valor, comparador
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
