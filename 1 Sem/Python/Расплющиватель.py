from collections import Iterable

def flatit(s):
    if type(s)==str and len(s)==1:
        yield s
        return
    if isinstance(s, Iterable):
        for i in s:
            for j in flatit(i):
                yield j
    else:
        yield s

print(list(flatit([[1, [[2, [5, [6, [2, "test"]]]], 3], range(-5, -3, 1)]])))