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

  def list (values1,values2)
    @flag=true
    values1.each_index { |index|
      if values1[index]!=values2[index]
        @flag=false
      end}
    @flag
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
