from __future__ import print_function
from functools import wraps
from collections import OrderedDict


def cache(n):
    def decorator(f):
        cach = OrderedDict()
        k = 0
        @wraps(f)
        def wrapper(*args):
            nonlocal k
            arg = str(args)
            if arg not in cach:
                if k == n:
                    cach.popitem()
                    k -= 1
                k += 1
                cach.update({arg: f(*args)})
            else:
                cach.move_to_end(arg, False)
            return cach[arg]
        return wrapper
    return decorator


@cache(3)
def foo(n):
    if n==1 or n==2:
        return 1
    else:
        return foo(n-1)+foo(n-2)


print (foo(50))