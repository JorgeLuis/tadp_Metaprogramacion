class Matcher
    def a_variable_name(valor)
   self.instance_eval{valor}
    true
  end

  def val

  end

  def type(objeto,tipo)
    objeto.class.equal?tipo
  end
end


class Combinators

  def and(un_matche,otro_match)

  end

  def or

  end

  def not

  end


end
