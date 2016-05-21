require 'rspec'
require_relative '../scr/Pattern_Matching'

describe 'Test de los 5 tipos de matchers' do

  # let(:k){}
  it '1.1.1 - Primer matcher de variable, debe retornar true siempre' do
    #:a_variable_name.call('anything') #=> true
    expect(:i.call 5).to eq(true)
    expect(i).to eq(5)
  end

  it '1.2.1 - Segundo matcher de valor, debe retornar true si ambos valores son iguales' do
    # val(5).call(5) #=> true
    # val(5).call('5') #=> false
    # val(5).call(4) #=> false
    expect(val(5).call 5).to eq(true)
    expect(val(5).call '5').to eq(false)
    expect(val(5).call 4).to eq(false)
  end

  it '1.3.1 - Tercer matcher de tipo, debe retornar true si el valor es del mismo tipo' do
    # type(Integer).call(5) #=> true
    # type(Symbol).call("Trust me, I'm a Symbol..") #=> false
    # type(Symbol).call(:a_real_symbol) #=> true

    expect(type(Integer).call 5).to eq(true)
    expect(type(Symbol).call("Trust me, I'm a Symbol..")).to eq(false)
    expect(type(Symbol).call(:a_real_symbol)).to eq(true)
  end

  it '1.4.1 - Cuarto matcher de lista, debe retornar true si los primeros valores con el otro vector' do

    an_array = [1, 2, 3, 4]

    #list(values, match_size?)
    expect(list([1, 2, 3, 4], true).call(an_array)).to eq(true) #=> true
    expect(list([1, 2, 3, 4], false).call(an_array)).to eq(true) #=> true

    expect(list([1, 2, 3], true).call(an_array)).to eq(false) #=> false
    expect(list([1, 2, 3], false).call(an_array)).to eq(true) #=> true

    expect(list([2, 1, 3, 4], true).call(an_array)).to eq(false) #=> false
    expect(list([2, 1, 3, 4], false).call(an_array)).to eq(false) #=> false

    # #Si no se especifica, match_size? se considera true
    expect(list([1, 2, 3]).call(an_array)).to eq(false) #=> false

    #También pueden combinarse con el Matcher de Variables
    expect(list([:a, :b, :c, :d]).call(an_array)).to eq(true) #=> true

  end

  it '1.5.1 - Quinto matcher de duck, debe retornar true si la instancia entiende estos mensajes' do

    psyduck = Object.new
    def psyduck.cuack
      'psy..duck?'
    end
    def psyduck.fly
      '(headache)'
    end

    class Dragon
      def fly
        'do some flying'
      end
    end
    a_dragon = Dragon.new

    expect(duck(:cuack, :fly).call(psyduck)).to eq(true) #=> true
    expect(duck(:cuack, :fly).call(a_dragon)).to eq(false) #=> false
    expect(duck(:fly).call(a_dragon)).to eq(true) #=> true
    expect(duck(:to_s).call(Object.new)).to eq(true) #=> true

  end
end