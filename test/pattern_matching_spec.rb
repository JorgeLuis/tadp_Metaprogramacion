require 'rspec'
require_relative '../scr/pattern_matching'

describe 'Pattern Mathing' do

#========================== TEST 1A ====================================
  it 'Test: bindear una variable' do
    # Intente bildearlo con la clase Symbol (comentado en la src) pero se puede con variables locales.... para consultar.
      a = Variable.new
      expect(a.ejecutar('algo')).to be(true)
  end

#========================== TEST 1B ====================================

  it 'Test: para probar comparacion de variables' do
    criterio_valor = Valor.new(5)
    expect(criterio_valor.ejecutar(5)).to be(true)

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


    # Listas de matchers a evaluar
    # m1,m2,m3 .... matchers
    # e1,e2 ..... elementos (1,'s',...)

    # list([m1,m2], true).call(2)
    expect(Lista.new([Tipo.new(Integer), Duck.new(:times,:step)], true).ejecutar(2)).to be(false)
    # list([m1,m2], true).call([2,3])
    expect(Lista.new([Tipo.new(Integer), Duck.new(:times,:step)], true).ejecutar([2,3])).to be(true)
    # list([m1,m2], false).call([2,3])
    expect(Lista.new([Tipo.new(Integer), Duck.new(:times,:step)], false).ejecutar([2,3])).to be(true)
    # list([m1,m2], false).call([1,2,3,4])
    expect(Lista.new([Tipo.new(Integer), Duck.new(:times,:step)], false).ejecutar([1,2,3,4])).to be(true)
    # list([m1,m2,m3], true).call([2,3,4])
    expect(Lista.new([Tipo.new(Integer), Duck.new(:times,:step), Tipo.new(Fixnum)], true).ejecutar([2,3,4])).to be(true)
    # list([m1,m2,m3], false).call([2,3,4])
    expect(Lista.new([Tipo.new(Integer), Duck.new(:times,:step), Tipo.new(Fixnum)], false).ejecutar([2,3,4])).to be(true)
    # list([m1,m2,m3], true).call([2])
    expect(Lista.new([Tipo.new(Integer), Duck.new(:times,:step), Tipo.new(Fixnum)], true).ejecutar([2])).to be(false)
    # list([m1,m2,m3], false).call([2])
    expect(Lista.new([Tipo.new(Integer), Duck.new(:times,:step), Tipo.new(Fixnum)], false).ejecutar([2])).to be(true)
    # list([m1,e2,m3], false).call([1,2])
    expect(Lista.new([Tipo.new(Integer), 2, Duck.new(:times,:step), Tipo.new(Fixnum)], false).ejecutar([1,2])).to be(true)
    # list([m1,e2,e3,m4], true).call([1,2,'a',[1,2,3]])
    expect(Lista.new([Tipo.new(Integer), 2, 'a', Tipo.new(Array)], true).ejecutar([1,2,'a',[1,2,3]])).to be(true)
    # list([m1,e2,e3,m4], true).call([1,2,'a',[1,2,3]])
    expect(Lista.new([Tipo.new(Integer), 2, 'a', Tipo.new(Array)], true).ejecutar([1,2,'a',[1,2,3]])).to be(true)
    # list([m1,e2,e3,m4], false).call(['a',2,'a'])
    expect(Lista.new([Tipo.new(Integer), 2, 'a', Tipo.new(Array)], false).ejecutar(['a',2,'a'])).to be(false)

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
  it 'test para probar Combinators con AND' do
    module Atacante; end
    module Defensor; end
    class Guerrero
      include Atacante
      include Defensor
    end
    class Muralla
      include Defensor
    end
    muralla= Muralla.new
    guerrero= Guerrero.new
    expect(Combinator1.new(Tipo.new Defensor).and(Tipo.new Atacante).ejecutar muralla).to be(false)
    expect(Combinator1.new(Tipo.new Defensor).and(Tipo.new Atacante).ejecutar guerrero).to be(true)
    expect(Combinator1.new(Duck.new(:+,:-)).and(Tipo.new(Fixnum),Valor.new(5)).ejecutar 5).to be(true)
  end
#========================== TEST 2 AND ====================================
  it 'test para probar Combinators con OR' do
    module Atacante; end
    module Defensor; end
    class Muralla
      include Defensor
    end
    muralla= Muralla.new
    expect(Combinator1.new(Tipo.new Defensor).or(Tipo.new Atacante).ejecutar muralla).to be(true)
    expect(Combinator1.new(Tipo.new Defensor).or(Tipo.new Atacante).ejecutar 'un delfin').to be(false)
  end
#========================== TEST 3 NOT ====================================

  it 'test para probar Combinators con NOT' do
    module Atacante; end
    module Defensor; end
    class Muralla
      include Defensor
    end
    class Misil
      include Atacante
    end
    muralla= Muralla.new
    misil= Misil.new
    expect(Combinator1.new(Tipo.new Defensor).not.ejecutar(muralla)).to be(false)
    expect(Combinator1.new(Tipo.new Defensor).not.ejecutar(misil)).to be(true)

  end



#========================== TEST 3 Pattern ====================================
  # it 'test para probar un patron' do
  #
  #
  # #with(type(Animal), duck(:fly)) { ... }
  #
  #   class Animal
  #     def comer
  #       'guau'
  #     end
  #   end
  #
  # un_patron=Patron.new
  # un_patron.with(Tipo.new(Animal),Duck.new(:comer)){|x| x.comer}
  # un_patron.otherwise {'miau'}
  # perro=Animal.new
  # # Tengo que revisar porque devuelve nil
  # expect(un_patron.match(perro)).to eq('guau')
  # end



end