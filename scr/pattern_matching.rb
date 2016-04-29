class Matcher

  def a_variable_name(valor)
    self.instance_eval{valor}
    true
  end

  def val(variable_A, variable_B)
    variable_A.eql? variable_B
  end
  
  def type(objeto,tipo)
    objeto.class.equal?tipo
  end

  def list (values1,values2,match_size)
    @flag=true
    values1.each_index { |index|
      if values1[index]!=values2[index]
        @flag=false
      end}
    if (values1.length!=values2.length && match_size)
      @flag=false
    end
    @flag
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
