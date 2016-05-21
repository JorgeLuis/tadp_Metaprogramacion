require 'rspec'
require_relative '../scr/Pattern_Matching'

describe 'Pruebas de los combinators' do

  module Defensor; end
  module Atacante; end
  class Muralla
    include Defensor
  end
  class Guerrero
    include Atacante
    include Defensor
  end
  class Misil
    include Atacante
  end
  una_muralla = Muralla.new
  un_guerrero = Guerrero.new
  un_misil = Misil.new

  it '1. Una muralla no puede ser atacante y defensor a la vez' do
    expect(type(Defensor).and(type(Atacante)).call(una_muralla)).to eq(false)
  end

  it '2. Un guerrero es defensor y atacante' do
    expect(type(Defensor).and(type(Atacante)).call(un_guerrero)).to eq(true)
  end

  it '3. El numero 5 es Fixnum y entiende el mensaje +' do
    expect(duck(:+).and(type(Fixnum), val(5)).call(5)).to eq(true)
  end

  it '4. Una muralla es Defensor' do
    expect(type(Defensor).or(type(Atacante)).call(una_muralla)).to eq(true)
  end

  it '5. Un mensaje string no es atacante y menos defensor' do
    expect(type(Defensor).or(type(Atacante)).call('un delfin')).to eq(false)
  end

  it '6. Una muralla no es defensor' do
    expect(type(Defensor).not.call(una_muralla)).to eq(false)
  end

  it '7. Un misil no es defensor' do
    expect(type(Defensor).not.call(un_misil)).to eq(true)
  end

  # Mas Pruebas
  it '8. Un vector entiende los mensajes size y zip y ademas es de tipo Array' do
    expect(duck(:size, :zip).and(type Array).call [5,3]).to eq(true)
  end

  it '9. El string f bindea con el matcher variable y es de tipo String' do
    expect([:a,:b,:c,:d].and(type String).call 'f').to eq(true)
  end

  it '10. Un array es igual al array de otra lista pero es Array y no es de tipo Fixnum' do
    expect(list([1,2,3],false).and((type(Array).not).or(type Fixnum)).call [1,2,3]).to eq(false)
  end

  it '11. El numero 9 es 9 o es de tipo Integer' do
    expect(val(9).or(type Integer).call 9).to eq(true)
  end

  it '12. El string "hola" es de tipo string, entiende los mensajes
      length y to_sym y su valor es igual a "hola"'  do
    expect([val(9).or(type String), duck(:length, :to_sym), :a].and(val 'hola').not.call 'hola').to eq(false)
  end
end