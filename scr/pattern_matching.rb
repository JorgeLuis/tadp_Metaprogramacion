class Matcher

  def val(variable_A, variable_B)
    variable_A.eql? variable_B
  end
  
  def type(objeto,tipo)
    objeto.class.equal?tipo
  end

  def duck_typing(*args, obj)
    return args.all? { |method| obj.respond_to? method}
  end
end


class Combinators
  attr_reader :matchers, :a_Matcher

  def initialize(matchers, a_Matcher)
    @a_Matcher= a_Matcher
    @matchers= {}
    matchers.each do |matcher|
      self.matchers[matcher] = nil
    end
  end

  def set_Matchers(sym, value)
    self.matchers[sym] = value
  end

  def and

  end

  def or(comparador)
    instancia = @a_Matcher.new
    matchers.any? { |metodo_Matcher, valor|
      instancia.send "#{metodo_Matcher}".to_sym, valor, comparador
    }
  end

  def not

  end


end
