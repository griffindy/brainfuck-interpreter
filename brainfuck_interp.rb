# Hi = 72.chr + 105.chr
class BrainfuckInterpreter
  attr_accessor :pointer, :program, :cell, :output, :input, :open_bracket, :program_counter
  def initialize(program, input=STDIN, output=STDOUT)
    @program = program.gsub(/\s+/, "")
    @pointer = 0
    @cell = [0]*255
    @input = input
    @program_counter = 0
    @open_bracket = []
  end

  def run
    while command = @program[@program_counter]
      case command
        when '>'
          @pointer += 1
          @program_counter += 1
        when '<'
          @pointer -= 1
          @program_counter += 1
        when '+'
          @cell[@pointer] += 1
          @program_counter += 1
        when '-'
          @cell[@pointer] -= 1
          @program_counter += 1
        when '.'
          print @cell[@pointer].chr
          @program_counter += 1
        when ','
          @cell[@pointer] = @input.getc.ord
          @program_counter += 1
        when '['
          @program_counter += 1
          @open_bracket << @program_counter
        when ']'
          if @cell[@pointer] == 0
            @open_bracket.pop
            @program_counter += 1
          else
            @program_counter = @open_bracket.last
          end
        else
          @program_counter += 1
      end
    end
    print @open_bracket
  end
end

# program = ',>,>++++++++[<------<------>>-]<<[>[>+>+<<-]>>[<<+>>-]<<<-]>>>++++++[<++++++++>-],<.>.'
program = '++++++++++[>+++++++>++++++++++>+++>+<<<<-]>++.>+.+++++++..+++.>++.<<+++++++++++++++.>.+++.------.--------.>+.>.'
BrainfuckInterpreter.new(program).run
