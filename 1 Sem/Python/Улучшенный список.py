from __future__ import print_function

class ExtendedList(list):
    def __init__(self, data):
        list.__init__(self, data)

    def __setattr__(self, key, value):
        if key == 'F' or key == 'first':
            self[0] = value
        elif key == 'L' or key == 'last':
            self[len(self)-1] = value
        elif key == 'S' or key == 'size':
            if value > len(self):
                for i in range(value-len(self)):
                    self.append(None)
            if value < len(self):
                del(self[value:])
        else:
            super().__setattr__(key, value)

    def __getattr__(self, key):
        if key == 'F' or key == 'first':
            return self[0]
        if key == 'L' or key == 'last':
            return self[len(self)-1]
        if key == 'R' or key == 'reversed':
            return list(reversed(self))
        if key == 'S' or key == 'size':
            return len(self)
        return super().__getattr__(self, key)


l = ExtendedList([])
print(l.reversed)
print(l.first)
l.F = 0
print(l)
l.append(4)
print(l.L)
l.size = 7
print(l)