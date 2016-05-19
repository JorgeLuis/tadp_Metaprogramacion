require 'rspec'
require_relative '../scr/Pattern_Matching_v2'

describe 'Pruebas de Patterns' do

  it 'Test punto 3 con matcher list' do
    # mat = Matches_1.new #esto tiene que ser x = [ 1 , 2 , 3 ]
    expect(matches?([1 , 2]) do
             with(list([ 5 , 4 , 3 ],true)){true}
             with(list([:a, 2], true)){ a + 2 }
             # with(list([ 1 , 2 , 3 ],true)){true}
           end).to eq(3)
  end
end