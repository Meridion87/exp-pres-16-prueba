cosas = "este, es, un, ejemplo, de, arreglo, separado, con, comas"

arr = []
i = 0
until cosas.split(', ')[i] == nil
  arr.push(cosas.split(', ')[i])
  i += 1
end


print arr
