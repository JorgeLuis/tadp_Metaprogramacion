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

  it 'Test: verifica si se cumple si el objeto es una lista' do

    an_array = [1,2,3,4]
    other_array = [2,1,3,4]
    tres =[1,2,3]

    a = Lista.new(an_array,true)
    b = Lista.new(an_array,false)
    c = Lista.new(tres,true)
    d = Lista.new(tres,false)
    e = Lista.new(other_array,true)
    f = Lista.new(other_array,false)
    g = Lista.new tres

    expect(a.ejecutar(an_array)).to be(true)
    expect(b.ejecutar(an_array)).to be(true)

    expect(c.ejecutar(an_array)).to be(false)
    expect(d.ejecutar(an_array)).to be(true)

    expect(e.ejecutar(an_array)).to be(false)
    expect(f.ejecutar(an_array)).to be(false)

    expect(g.ejecutar an_array).to be(false)
    # Prueba de varialbes
    a = Variable.new
    b = Variable.new
    c = Variable.new
    variables=[a,b,c]
    expect(variables.ejecutar(tres)).to be(true)
    expect(a.var).to eq(1)  #Comprueba si se 'bindeo' en la variable

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
