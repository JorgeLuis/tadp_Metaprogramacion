require 'rspec'
require_relative '../scr/pattern_matching'

describe 'Pattern Mathing' do

#========================== TEST 1A ====================================
  it 'Test: bindear una variable' do
    a = Variable.new
    expect(a.ejecutar('algo')).to be(true)
  end

#========================== TEST 1B ====================================

  it 'Test: para probar comparacion de variables' do
    criterioValor = Valor.new(5)
    expect(criterioValor.ejecutar(5)).to be(true)

  end

#========================== TEST 1C ====================================

  it 'Test: verifica si un objeto es del tipo indicado' do
    un_tipo = Tipo.new(Fixnum)
    otro_tipo = Tipo.new(Symbol)
    expect(un_tipo.ejecutar(5)).to be(true)
    expect(otro_tipo.ejecutar(':5')).to be(false)
    expect(otro_tipo.ejecutar(:g)).to be(true)

  end

#========================== TEST 1D ====================================

  it 'Test: verifica los test del enunciado' do

    an_array = [1,2,3,4]
    other_array = [2,1,3,4]
    tres =[1,2,3]

    ###   list(values, match_size?)

    #list([1, 2, 3, 4], true).call(an_array) #=> true
    #list([1, 2, 3, 4], false).call(an_array) #=> true
    a = Lista.new(an_array,true)
    expect(a.ejecutar(an_array)).to be(true)
    b = Lista.new(an_array,false)
    expect(b.ejecutar(an_array)).to be(true)

    #list([1, 2, 3], true).call(an_array) #=> false
    #ist([1, 2, 3], false).call(an_array) #=> true
    c = Lista.new(tres,true)
    expect(c.ejecutar(an_array)).to be(false)
    d = Lista.new(tres,false)
    expect(d.ejecutar(an_array)).to be(true)

    #list([2, 1, 3, 4], true).call(an_array) #=> false
    #list([2, 1, 3, 4], false).call(an_array) #=> false
    e = Lista.new(other_array,true)
    expect(e.ejecutar(an_array)).to be(false)
    f = Lista.new(other_array,false)
    expect(f.ejecutar(an_array)).to be(false)

    ###   Si no se especifica, match_size? se considera true

    #list([1, 2, 3]).call(an_array) #=> false
    g = Lista.new tres
    expect(g.ejecutar an_array).to be(false)

    ###   También pueden combinarse con el Matcher de Variables

    #list([:a, :b, :c, :d]).call(an_array) #=> true

    a = Variable.new
    b = Variable.new
    c = Variable.new
    sim=Lista.new([a,b,c])
    expect(sim.ejecutar(tres)).to be(true)
    expect(a.var).to eq(1)  #Comprueba si se 'bindeo' en la variable descrita
    expect(b.var).to eq(2)  #Comprueba si se 'bindeo' en la variable descrita
    expect(c.var).to eq(3)  #Comprueba si se 'bindeo' en la variable descrita

  end


#========================== TEST 1E ====================================

  it 'Test: verifica si los metodos de una clase entiende un objeto' do
    class A
      def golpe; end
      def patada; end
      def descanso; end
    end
    pepe = A.new
    cuak = Duck.new(:golpe, :patada, :descanso)
    cuak_cuak = Duck.new(:cagar, :jugar, :cariciar)
    expect(cuak.ejecutar pepe).to be(true)
    expect(cuak_cuak.ejecutar pepe).to be(false)
  end

#========================== TEST 2 AND ====================================

  it 'test para probar combinador AND igual TRUE' do
    un_tipo = Tipo.new(Fixnum)
    otro_tipo = Tipo.new(Integer)

    un_conbinator_and = Combinators.new(un_tipo,otro_tipo)

    #expect(un_conbinator_and.ejecutar(1)).to be(true)
  end

#========================== TEST 2 OR ====================================

  it 'test para probar combinador OR igual TRUE' do

  end


#========================== TEST 3 NOT ====================================

  it 'test para probar combinador NOT igual TRUE' do

  end


end
