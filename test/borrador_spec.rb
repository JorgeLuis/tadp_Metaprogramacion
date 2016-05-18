require 'rspec'
require_relative '../scr/borrador'
require_relative '../scr/matches_1'

describe 'pruebas de borrador' do

  it 'Matcher 1.a Variable' do
    expect(:a.call(5)).to eq(true)
    # expect(a).to eq(5)
  end

  it 'Matcher 1.b Valor' do
    expect(val(5).call(5)).to be(true)
    expect(val('aaa').call('aab')).to eq(false)
  end

  it 'Test: verifica si un objeto es del tipo indicado' do
    expect(type(Integer).call 5).to be(true)
    expect(type(Symbol).call ':5').to be(false)
    expect(type(Symbol).call (:g)).to be(true)
  end

  # it 'Test: sobre el punto 3' do
  #   mat = Matches_1.new
  #
  #   expect(mat.matches?(type(Integer)){ 2 + 2 }).to be(4)
  # end

  it 'Test: sobre el punto 3' do
    mat = Matches_1.new

    expect(mat.matches?(2) do
      with(type Integer){ 2 +2 }
    end).to be(4)
  end

end
