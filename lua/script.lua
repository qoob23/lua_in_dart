function print_sum()
  local a, b = 10, 33
  print('[lua] calling dart:_sum')
  -- функция _sum предоставляется нашим dart api
  local sum = _sum(a, b)
  print('[lua] ' .. sum)
end
