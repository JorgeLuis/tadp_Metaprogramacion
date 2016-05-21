require 'rspec'
require 'ostruct'
require_relative '../scr/Pattern_Matching'

describe 'Test de Pattern' do
  it 'Test punto 3 con matcher list' do
    expect(matches?([1 , 2, 3]) do
             with(list([ :a, val(2), 3],true)) { a + 2 }
             with(list([ 1, 2, 3], true)) { 'aca no llego' }
             otherwise { 'aca no llego otherwise' }
           end).to be(3)
  end

  it 'Test punto 3 con matcher object x' do
    x = Object.new
    x.send( :define_singleton_method, :hola) { 'hola' }
    expect(matches?(x) do
             with(duck( :hola)) { 'chau!' }
             with(list([ 1, 2, 3], true)) { 'aca no llego' }
           end).to eq('chau!')
  end

  it 'Test punto 3 con matcher x = 2 ' do
    x = 2
    expect(matches?(x) do
             with(list([ 1, 2, 3], true)) { 'aca no llego' }
             otherwise { 'aca si llego' }
           end).to eq('aca si llego')
  end
end