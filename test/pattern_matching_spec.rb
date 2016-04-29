require 'rspec'
require_relative '../scr/pattern_matching'

describe 'Pattern Mathing' do
  macheo = Matcher.new


#========================== TEST 1A ====================================
  it 'test para bindear una variable' do
    expect(macheo.a_variable_name('anything')).to be(true)
  end

  it 'test para verificar que una varieble este definida' do
    macheo.a_variable_name( 'nueva_variable')
    expect(macheo.instance_variable_defined?('@nueva_variable')).to be(false) #error tiene que ser true
  end

  it 'test para verificar que una variable no este definida' do
    expect(macheo.instance_variable_defined?("@b")).to be(false)
  end

#========================== TEST 1B ====================================

  it 'test para probar comparacion de variables' do
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

  it 'test para verificar si un objeto es del tipo indicado' do
    expect(macheo.type(1,Fixnum)).to be(true)
  end

  it 'test para verificar si un objeto no es del tipo indicado' do
    expect(macheo.type(macheo,Fixnum)).to be(false)
    expect(macheo.type(Symbol,"blee")).to be(false)
  end


#========================== TEST 1D ====================================

  it '1d.test para verificar si se cumple si el objeto es una lista' do
    an_array= [1,2,3,4]
    other_array= [1,2,3]

    myBlock= lambda do
              |lista,condicion|

              if condicion
                lista.equal?an_array
              else
                an_array.include?lista
              end

            end

    puts(myBlock.call(an_array,true))
    puts(myBlock.call(an_array,false))
    #puts(myBlock.call(other_array,true))


  end


#========================== TEST 1E ====================================

  it '1e.Pruebo si los metodos de una clase entiende un objeto' do
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
end
