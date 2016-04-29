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

  def list (values1,values2)
    @flag=true
    values1.each_index { |index|
      if values1[index]!=values2[index]
        @flag=false
      end}
    @flag
  end

  def duck_typing(*args, obj)
    return args.all? { |method| obj.respond_to? method}
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
