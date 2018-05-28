from __future__ import print_function
from functools import wraps
from time import clock

def profiler(f):
    rec = False
    @wraps(f)
    def wrapper(*args, **kwargs):
        nonlocal rec
        crec = rec
        if not crec:
            wrapper.calls = 0
            rec = True
            wrapper.last_time_taken = clock()
        res = f(*args, **kwargs)
        wrapper.calls += 1
        if crec is False:
            wrapper.last_time_taken = clock() - wrapper.last_time_taken
            rec = False
        return res
    return wrapper


@proﬁler
def f(m,n):
 if m==0:
  return (n+1)
 if m>0 and n==0:
  return f(m-1,1)
 if m>0 and n>0:
  return f(m-1,f(m,n-1))


print(f(3, 4),f.last_time_taken, f(3, 3), f.last_time_taken)
