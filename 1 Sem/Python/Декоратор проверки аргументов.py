from __future__ import print_function
from functools import wraps


def takes(*typ):
    def decorator(f):
        @wraps(f)
        def wrapper(*args):
            for a, t in zip(args, typ):
                if not isinstance(a, t):
                    raise TypeError
            return f(*args)
        return wrapper
    return decorator

@takes(int, str)
def f(a, b):
    print(a, b)

try:
    f(1, 'abcd')
except Exception as e:
    print(type(e).__name__)
