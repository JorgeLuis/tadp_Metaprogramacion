require 'rspec'
require_relative '../scr/Pattern_Matching_v2'

describe 'Test de los 5 tipos de matchers' do

  # let(:k){}
  it '1.1.1 - Primer matcher de variable, debe retornar true siempre' do
    expect(:i.call 5).to eq(true)
    expect(i).to eq(5)
  end

  it '1.2.1 - Segundo matcher de valor, debe retornar true si ambos valores son iguales' do
    expect(val(6).call 6).to eq(true)
  end

  it '1.3.1 - Tercer matcher de tipo, debe retornar true si el valor es del mismo tipo' do
    expect(type(Array).call [8,9,6,5]).to eq(true)
  end

  it '1.4.1 - Cuarto matcher de lista, debe retornar true si los primeros valores
      con el otro vector' do
    x = [1,2,3]
    expect(list([1,2,3,4],false).call x).to eq(true)
  end

  it '1.5.1 - Quinto matcher de duck, debe retornar true si la instancia
      entiende estos mensajes' do
    expect(duck(:abs, :succ).call 5).to eq(true)
  end
end