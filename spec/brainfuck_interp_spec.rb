require 'spec_helper'

describe BrainfuckInterpreter do
  it '> should increment pointer' do
    test = BrainfuckInterpreter.new('>', 'one')
    test.run
    test.pointer.should equal(1)
  end

  it '< should decrement pointer'do
    test = BrainfuckInterpreter.new('>><', 'one')
    test.run
    test.pointer.should equal(1)
  end

  it '+ should increase the cell at register pointer' do
    test = BrainfuckInterpreter.new('+', 'one')
    test.run
    test.cell[0].should equal(1)
  end

  it '- should decrease the cell at register pointer' do
    test = BrainfuckInterpreter.new('++-', 'one')
    test.run
    test.cell[0].should equal(1)
  end

  it '. should print the ascii code for the cell at register pointer' do
    fake_out = StringIO.new('G')
    test = BrainfuckInterpreter.new('+'*?G.ord+'.', STDIN, fake_out)
    test.run
    fake_out.rewind
    fake_out.read.should == 'G'
  end

  it ', should accept and store the ascii code of the input' do
    test = BrainfuckInterpreter.new('++,.', StringIO.new('h'))
  end

  it '[ should mark the beginning of a loop' do
    test = BrainfuckInterpreter.new('+[', 'one')
    test.run
    test.open_bracket.should == [1]
  end

  it '] should reset the program_counter back to the open bracket' do
    test = BrainfuckInterpreter.new('+++[>+<-]', 'one')
    test.run
    test.cell[1].should equal(3)
  end
end
