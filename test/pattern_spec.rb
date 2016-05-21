require 'rspec'
require_relative '../scr/Pattern_Matching_v2'
require_relative '../scr/matches_1'

context 'Test de los patrones' do


=begin
  it 'Test punto 3 con matcher :a' do
    x = Matches_1.new
    expect(x.matches?(2) do
             with(:a){ 2 +1 }
           end).to be(3)
  end


  it 'Test punto 3 con matcher val' do
    x = Matches_1.new
    expect(x.matches?(2) do
             with(val(2)){ 2 +1 }
           end).to be(3)
  end

  it 'Test punto 3 con matcher type' do
    mat = Matches_1.new #esto tiene que ser x = 2

    expect(mat.matches?(2) do
             with(type Integer){ 2 +2 }
           end).to be(4)
  end

  # it 'Test punto 3 con matcher list' do
  #   mat = Matches_1.new #esto tiene que ser x = [ 1 , 2 , 3 ]
  #   expect(mat.matches?([ 1 , 2 ]) do
  #            with(list([:a, val(2)])){ 2 +2 }
  #            # with(list([ 1 , 2 , 3 ])){true}
  #          end).to be([ 1 , 2 ])
  # end
=end

  # it 'Test punto 3 con matcher list' do
  #   # mat = Matches_1.new #esto tiene que ser x = [ 1 , 2 , 3 ]
  #   expect(matches?([1 , 2]) do
  #            with1(list([ 5 , 4 , 3 ],true)){true}
  #            with1(list([:a, 2], true)){ a + 2 }
  #            with1(list([:a, 2], true)){ a + 3 }
  #            with1(list([ 1 , 2 , 3 ],true)){true}
  #          end).to be(3)
  # end
  #
  # it 'Test punto 3 con matcher list' do
  #   # mat = Matches_1.new #esto tiene que ser x = [ 1 , 2 , 3 ]
  #   expect(matches?([1 , 2]) do
  #            with1(list([ 5 , 4 , 3 ],true), type(Integer)){true}
  #            with1(list([:a, 2], true)){ a + 2 }
  #            with1(list([:a, 2], true)){ a + 3 }
  #            with1(list([ 1 , 2 , 3 ],true)){true}
  #          end).to be(3)
  # end
  #
  #
  # it 'Test punto 3 con matcher list' do
  #   # mat = Matches_1.new #esto tiene que ser x = [ 1 , 2 , 3 ]
  #   expect(matches?([1 , 2]) do
  #            with1(list([ 5 , 4 , 3 ],true)){true}
  #            with1(list([:a, 3], true)){ a + 2 }
  #            with1(list([ 1 , 2 , 3 ],true)){true}
  #            otherwise { 'aca si llego' }
  #          end).to eq('aca si llego')
  # end
  #
  #
  # it 'Test punto 3 con matcher list' do
  #   # mat = Matches_1.new #esto tiene que ser x = [ 1 , 2 , 3 ]
  #   expect(matches?([1 , 2]) do
  #            with1(list([ 5 , 4 , 3 ],true)){true}
  #            with1(list([:a, 2], true)){ a + 2 }
  #            with1(list([ 1 , 2 , 3 ],true)){true}
  #            otherwise { 'aca no llego' }
  #          end).to be(3)
  # end


  # it 'Test punto 3 con matcher list' do
  #   # mat = Matches_1.new #esto tiene que ser x = [ 1 , 2 , 3 ]
  #   expect(matches?([1 , 2, 3]) do
  #            with1(list([ :a, val(2), duck(:+) ],true)) { a + 2 }
  #            with1(list([ 1, 2, 3], true)) { 'aca no llego' }
  #            otherwise { 'aca no llego' }
  #          end).to be(3)
  # end
  # it 'Test punto 3 con matcher list' do
  #   # mat = Matches_1.new #esto tiene que ser x = [ 1 , 2 , 3 ]
  #   expect(list([ :a, val(2)],true).call [1 , 2]).to be(true)
  #   # expect(val(2).call 2 ).to be(true)
  # end

  #
  it 'Test punto 3 con matcher list' do
    expect(matches?([1 , 2, 3]) do
             with1(list([ :a, val(2), 3],true)) { a + 2 }
             with1(list([ 1, 2, 3], true)) { 'aca no llego' }
             otherwise { 'aca no llego otherwise' }
           end).to be(3)
  end

  it 'Test punto 3 con matcher object x' do
    x = Object.new
    x.send( :define_singleton_method, :hola) { 'hola' }
    expect(matches?(x) do
             with1(duck( :hola)) { 'chau!' }
             with1(list([ 1, 2, 3], true)) { 'aca no llego' }
           end).to eq('chau!')
  end

  it 'Test punto 3 con matcher x = 2 ' do
    x = 2
    expect(matches?(x) do
             with1(list([ 1, 2, 3], true)) { 'aca no llego' }
           end).to eq('chau!')
  end

end