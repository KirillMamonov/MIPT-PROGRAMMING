def strings(filename, min_str_len=4):
    res = []
    with open(filename, 'rb') as f:
        l = []
        while True:
            c = f.read(1000)
            if c == b'':
                break
            for k in c:
                if k == -1:
                    break
                if k <= 126 and k >= 9 and (k <= 13 or k >= 32):
                    l.append(chr(k))
                else:
                    if min_str_len < len(l):
                        res.append(''.join(l))
                    l.clear()
        if min_str_len < len(l):
            res.append(''.join(l))
    return res

print(strings('b.bin'))