#
# DO NOT MODIFY!!!!
# This file is automatically generated by Racc 1.4.11
# from Racc grammer file "".
#

require 'racc/parser.rb'
module BrandAid
  class CssParser < Racc::Parser

module_eval(<<'...end css.y/module_eval...', 'css.y', 48)

  def parse str
    str = str.strip
    @q = []
    until str.empty?
      case str
      when /\A(\s)+/
        str = $'
      when /\A[-A-Za-z0-9#.<]+/, /\A"[^"]*"/, /\A'[^']'/
        @q.push [:WORD, $&]
        str = $'
      else
        c = str[0,1]
        @q.push [c, c]
        str = str[1..-1]
      end
    end
    do_parse
  end
  def next_token
    @q.shift
  end
...end css.y/module_eval...
##### State transition tables begin ###

racc_action_table = [
     2,     9,     8,    18,     6,     9,    13,    14,    10,     7,
     6,    16,     6,    10 ]

racc_action_check = [
     1,    17,     4,    17,     1,     4,    11,    11,    12,     2,
     9,    14,    16,     5 ]

racc_action_pointer = [
   nil,     0,     9,   nil,     0,     9,   nil,   nil,   nil,     6,
   nil,     3,     4,   nil,     5,   nil,     8,    -4,   nil ]

racc_action_default = [
    -2,   -11,   -11,    -1,   -11,    -6,    -5,    19,   -10,   -11,
    -4,   -11,    -7,    -3,   -11,    -9,   -11,   -11,    -8 ]

racc_goto_table = [
     4,    11,     1,     3,    12,    15,   nil,   nil,   nil,   nil,
   nil,   nil,   nil,   nil,   nil,    17 ]

racc_goto_check = [
     3,     4,     1,     2,     5,     6,   nil,   nil,   nil,   nil,
   nil,   nil,   nil,   nil,   nil,     3 ]

racc_goto_pointer = [
   nil,     2,     2,    -1,    -7,    -5,    -6 ]

racc_goto_default = [
   nil,   nil,   nil,   nil,   nil,     5,   nil ]

racc_reduce_table = [
  0, 0, :racc_error,
  2, 9, :_reduce_1,
  0, 9, :_reduce_2,
  4, 10, :_reduce_3,
  2, 13, :_reduce_4,
  1, 13, :_reduce_5,
  1, 11, :_reduce_6,
  3, 11, :_reduce_7,
  4, 14, :_reduce_8,
  2, 12, :_reduce_9,
  0, 12, :_reduce_10 ]

racc_reduce_n = 11

racc_shift_n = 19

racc_token_table = {
  false => 0,
  :error => 1,
  "{" => 2,
  "}" => 3,
  :WORD => 4,
  "," => 5,
  ":" => 6,
  ";" => 7 }

racc_nt_base = 8

racc_use_result_var = true

Racc_arg = [
  racc_action_table,
  racc_action_check,
  racc_action_default,
  racc_action_pointer,
  racc_goto_table,
  racc_goto_check,
  racc_goto_default,
  racc_goto_pointer,
  racc_nt_base,
  racc_reduce_table,
  racc_token_table,
  racc_shift_n,
  racc_reduce_n,
  racc_use_result_var ]

Racc_token_to_s_table = [
  "$end",
  "error",
  "\"{\"",
  "\"}\"",
  "WORD",
  "\",\"",
  "\":\"",
  "\";\"",
  "$start",
  "rulesets",
  "ruleset",
  "words",
  "rs",
  "word",
  "r" ]

Racc_debug_parser = false

##### State transition tables end #####

# reduce 0 omitted

module_eval(<<'.,.,', 'css.y', 6)
  def _reduce_1(val, _values, result)
          result.push val[1]
    
    result
  end
.,.,

module_eval(<<'.,.,', 'css.y', 9)
  def _reduce_2(val, _values, result)
          result = []
    
    result
  end
.,.,

module_eval(<<'.,.,', 'css.y', 14)
  def _reduce_3(val, _values, result)
          result = [val[0], val[2]]
    
    result
  end
.,.,

module_eval(<<'.,.,', 'css.y', 19)
  def _reduce_4(val, _values, result)
          result << " " + val[1]
    
    result
  end
.,.,

module_eval(<<'.,.,', 'css.y', 22)
  def _reduce_5(val, _values, result)
          result = val[0]
    
    result
  end
.,.,

module_eval(<<'.,.,', 'css.y', 27)
  def _reduce_6(val, _values, result)
          result = val
    
    result
  end
.,.,

module_eval(<<'.,.,', 'css.y', 30)
  def _reduce_7(val, _values, result)
          result.push val[2]
    
    result
  end
.,.,

module_eval(<<'.,.,', 'css.y', 35)
  def _reduce_8(val, _values, result)
          result = [val[0], val[2]]
    
    result
  end
.,.,

module_eval(<<'.,.,', 'css.y', 40)
  def _reduce_9(val, _values, result)
          result.push val[1]
    
    result
  end
.,.,

module_eval(<<'.,.,', 'css.y', 43)
  def _reduce_10(val, _values, result)
          result = []
    
    result
  end
.,.,

def _reduce_none(val, _values, result)
  val[0]
end

  end   # class CssParser
  end   # module BrandAid
