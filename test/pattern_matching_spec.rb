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



  it 'test para verificar si se cumple si el objeto es una lista' do
    an_array= [1,2,3,4]
    other_array= [1,2,3]

    myBlock= lambda do
              |lista,condicion|

              if condicion
                lista.equal?an_array
              else
                an_array.include?lista
              end

            end

    puts(myBlock.call(an_array,true))
    puts(myBlock.call(an_array,false))
    #puts(myBlock.call(other_array,true))


  end



end


