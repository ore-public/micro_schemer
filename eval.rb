$primitive_fun_env = {
  :+ => [:prim, lambda{|x, y| x + y}],
  :- => [:prim, lambda{|x, y| x - y}],
  :* => [:prim, lambda{|x, y| x * y}]
}

def list?(exp)
  exp.is_a?(Array)
end

def lookup_primitive_fun(exp)
  $primitive_fun_env[exp]
end

def car(list)
  list[0]
end

def cdr(list)
  list[1..-1]
end

def eval_list(exp)
  exp.map{|e| _eval(e)}
end

def num?(exp)
  exp.is_a?(Numeric)
end

def immediate_val?(exp)
  num?(exp)
end

def apply_primitive_fun(fun, args)
  fun_val = fun[1]
  fun_val.call(*args)
end

def apply(fun, args)
  apply_primitive_fun(fun, args)
end

def _eval(exp)
  if list?(exp)
    fun = _eval(car(exp))
    args = eval_list(cdr(exp))
    apply(fun, args)
  else
    if immediate_val?(exp)
      exp
    else
      lookup_primitive_fun(exp)
    end
  end
end

puts _eval([:*, 4, [:+, 1, 2]])