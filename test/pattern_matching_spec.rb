require 'rspec'
require_relative '../scr/pattern_matching'

describe 'Pattern Mathing' do
  macheo = Matcher.new

  it 'test para bindear una variable' do
    expect(macheo.a_variable_name('anything')).to be(true)
  end
  
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

  it 'test para verificar que una varieble este definida' do
    macheo.a_variable_name('nueva_variable')
    expect(macheo.instance_variable_defined?('@nueva_variable')).to be(true) #error tiene que ser true
  end

  it 'test para verificar que una variable no este definida' do
    expect(macheo.instance_variable_defined?("@b")).to be(false)
  end

  it 'test para verificar si un objeto es del tipo indicado' do
    expect(macheo.type(1,Fixnum)).to be(true)
  end

  it 'test para verificar si un objeto no es del tipo indicado' do
    expect(macheo.type(macheo,Fixnum)).to be(false)
    expect(macheo.type(Symbol,"blee")).to be(false)
  end


  it 'Pruebo si los metodos de una clase entiende un objeto' do
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
end
