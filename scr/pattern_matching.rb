class Matcher

  attr_accessor :unaVariable

  def a_variable_name(valor)

    unaVariable = self.instance_eval{valor}
    true
  end

  def val(variable_A, variable_B)
    variable_A.eql? variable_B
  end

  def type(objeto,tipo)
    objeto.class.equal?tipo
  end
end


class Combinators

  def and

  end

  def or

  end

  def not

  end


end
