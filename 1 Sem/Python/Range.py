class Range:
    def __init__(self, i=0, j=0, k=1):
        self.start = i
        self.end = j
        self.step = k
        self.cur = i
        if self.end == 0:
            self.end = self.start
            self.start = 0
            self.cur = 0


    def __repr__(self):
        if self.end != 0 and self.step == 0:
            return ('Range({}, {})'.format(self.start, self.end))
        elif self.end == 0:
            return ('Range({})'.format(self.start))
        elif self.step != 0:
            return  ('Range({}, {}, {})'.format(self.start, self.end, self.step))

    def __iter__(self):
        return self

    def __next__(self):
        temp = self.cur
        self.cur += self.step
        if temp < self.end:
            return temp
        else:
            self.cur = self.start
            raise StopIteration()

    def __len__(self):
        return (self.end - self.start)//self.step

    def __contains__(self, item):
        return item>=self.start and item < self.end and (item-self.start)%self.step == 0

    def __getitem__(self, item):
        return self.start+item*self.step


print(Range(1, 10, 3)[2])