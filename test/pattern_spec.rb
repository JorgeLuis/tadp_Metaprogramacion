require 'rspec'
require_relative '../scr/borrador'
require_relative '../scr/matches_1'

context 'Test de los patrones' do


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

  it 'Test punto 3 con matcher list' do
    mat = Matches_1.new #esto tiene que ser x = [ 1 , 2 , 3 ]
    expect(mat.matches?([ 1 , 2 ]) do
             with(list([:a, 2])){ a +2 }
             # with(list([ 1 , 2 , 3 ])){true}
           end).to be(3)
  end


end