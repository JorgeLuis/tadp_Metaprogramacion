require 'rspec'
require_relative '../scr/pattern_matching'

describe 'Pattern Mathing' do
  macheo = Matcher.new

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

  it 'test para verificar si un objeto es del tipo indicado' do
    expect(macheo.type(1,Fixnum)).to be(true)
  end

  it 'test para verificar si un objeto no es del tipo indicado' do
    expect(macheo.type(macheo,Fixnum)).to be(false)
    expect(macheo.type(Symbol,"blee")).to be(false)
  end

  class Ejemplo
    attr_accessor :valor

  end

  it "test " do

    k=Ejemplo.new
    puts (k.instance_eval{ k.instance_variables} )

  end


end