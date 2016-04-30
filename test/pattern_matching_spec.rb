require 'rspec'
require_relative '../scr/pattern_matching'

describe 'Pattern Mathing' do
  macheo = Matcher.new


#========================== TEST 1A ====================================
  it 'Test: bindear una variable' do
    a_variable_name= lambda do
      |nombre|
      nombre.to_sym
      return true
    end

    expect(a_variable_name.call('anything')).to be(true)
  end

#========================== TEST 1B ====================================

  it 'Test: para probar comparacion de variables' do
    criterioValor = Matcher.new
    a = Matcher.new
    b = Matcher.new

    expect(criterioValor.val(5, 5)).to eq(true)
    expect(criterioValor.val(5, '5')).to eq(false)
    expect(criterioValor.val('a', 'a')).to eq(true)
    expect(criterioValor.val(a, a)).to eq(true)
    expect(criterioValor.val(a, b)).to eq(false)

  end

#========================== TEST 1C ====================================

  it 'Test: verifica si un objeto es del tipo indicado' do
    expect(macheo.type(1,Fixnum)).to be(true)
  end

  it 'Test: verifica si un objeto no es del tipo indicado' do
    expect(macheo.type(macheo,Fixnum)).to be(false)
    expect(macheo.type(Symbol,"blee")).to be(false)
  end


#========================== TEST 1D ====================================

  it 'Test: verifica si se cumple si el objeto es una lista' do
    an_array= [1,2,3,4]
    other_array= [1,2,3]

    myBlock= lambda do
              |lista,condicion,lista2|

              if lista.size == lista2.size
               return lista.equal?lista2
              end

              if condicion
                return false

              elsif lista.size < lista2.size
                  return lista.all?{ |x| lista2[x] }
              elsif lista.size > lista2.size
                return false
              end
    end

    myBlock2= lambda do
    |lista,lista2|
      condicion = true
      if lista.size == lista2.size
        return lista.equal?lista2
      end

      if condicion
        return false

      elsif lista.size < lista2.size
        return lista.all?{ |x| lista2[x] }
      elsif lista.size > lista2.size
        return false
      end
    end


    expect(myBlock.call(an_array,true,an_array)).to be(true)
    expect(myBlock.call(an_array,false,an_array)).to be(true)
    expect(myBlock.call(other_array,true,an_array)).to be(false)
    expect(myBlock.call(other_array,false,an_array)).to be(true)
    expect(myBlock.call(an_array,false,other_array)).to be(false)
    expect(myBlock2.call(other_array,an_array)).to be(false)

  end


#========================== TEST 1E ====================================

  it 'Test: verifica si los metodos de una clase entiende un objeto' do
    class A
      def golpe
      end
      def patada
      end
      def descanso
      end
    end
    pepe = A.new
    m = Matcher.new
    expect(m.duck_typing(:golpe, :patada, :descanso, pepe)).to eq(true)
    expect(m.duck_typing(:cagar, :jugar, :cariciar, pepe)).to eq(false)
  end

#========================== TEST 2 OR ====================================

  it 'test para probar combinador OR igual TRUE' do

    combinador_Or = Combinators.new([:type, :type], Matcher)

    combinador_Or.set_Matchers(:type, 5)
    combinador_Or.set_Matchers(:type, 6)

    expect(combinador_Or.or(Fixnum)).to eq(true)
  end

  it 'test para probar combinador OR igual FALSE' do

    combinador_Or = Combinators.new([:type, :type], Matcher)

    combinador_Or.set_Matchers(:type, 5)
    combinador_Or.set_Matchers(:type, 'hola')

    expect(combinador_Or.or(Fixnum)).to eq(false)
  end

#========================== TEST 2 AND ====================================

  it 'test para probar combinador AND igual TRUE' do

    combinador_And = Combinators.new([:type, :type], Matcher)

    combinador_And.set_Matchers(:type, 5)
    combinador_And.set_Matchers(:type, 6)

    expect(combinador_And.and(Fixnum)).to eq(true)
  end

  it 'test para probar combinador AND igual FALSE' do

    combinador_And = Combinators.new([:type, :type], Matcher)

    combinador_And.set_Matchers(:type, 5)
    combinador_And.set_Matchers(:type, 'hola')

    expect(combinador_And.and(Fixnum)).to eq(false)
  end
end
