import itertools

def transpose(l):
    return list(zip(*l))

def uniq(l):
    res = []
    s = set()
    for i in l:
        if i not in s:
            res.append(i)
            s.add(i)
    return res

def product(a, b):
    return sum(itertools.starmap(lambda x, y: x*y, zip(a, b)))

def dict_merge(*l):
    return dict(list(itertools.chain(*[list(i.items()) for i in l])))