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
    words '{' rs '}' {
      result = [val[0], val[2]]
    }

word :
    word WORD {
      result << " " + val[1]
    }
  | WORD {
      result = val[0]
    }

words :
    word {
      result = val
    }
  | words ',' word {
      result.push val[2]
    }

r :
    WORD ':' words ';' {
      result = [val[0], val[2]]
    }

rs :
    rs r {
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
      when /\A(\s)+/
        str = $'
      when /\A[-A-Za-z0-9#.<]+/, /\A"[^"]*"/, /\A'[^']*'/
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
