require 'rspec'
require_relative '../scr/Pattern_Matching_v2'

describe 'Pruebas de los combinators' do

  it '2.1.1 - Debe devolver true ya que las dos condiciones
      se cumplen para un parametro dado' do
    expect(duck(:size, :zip).and(type Array).call [5,3]).to eq(true)
  end

  it '2.1.2 - Combinator AND  entre un conjunto de matchers de simbolos y
      un type de String' do
    expect([:a,:b,:c,:d].and(type String).call 'f').to eq(true)
  end

  it '2.2.1 - Combinacion de AND, NOT y OR' do
    expect(list([1,2,3],false).and((type(Array).not).or(type Fixnum)).call [1,2,3]).to eq(false)
  end


  it '2.2.2 - Combinator OR, matchers entre val y type ' do
    expect(val(9).or(type Integer).call 9).to eq(true)
  end

  it '2.3.1 - Combinator de los 3 operadores con val, type, duck, val' do
    expect([val(9).or(type String), duck(:length, :to_sym), :a].and(val 'hola').not.call 'hola').to eq(false)
  end

end