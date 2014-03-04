class BrandAid::CssParser

rule

rulesets :
    rulesets ruleset {
      result.push val[1]
    }
  | {
      result = []
    }

ruleset :
    words '{' rules '}' {
      result = [val[0], val[2]]
    }


words :
    WORD {
      result = val
    }
  | words ',' WORD {
      result.push val[2]
    }

rule :
    WORD ':' words ';' {
      result = [val[0], val[2]]
    }

rules : 
    rules rule {
      result.push val[1]
    }
  | {
      result = []
  }

---- inner

  def parse str
    str = str.strip
    @q = []
    until str.empty?
      case str
      when /^\s+/
        str = $'
      when /^(\w+\s*)+/
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
