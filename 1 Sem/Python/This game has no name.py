class Player(object):
    def __init__(self):
        self.m = "ready"
        self.gamemethod = "start"

    def __getattribute__(self, name):
        if name == object.__getattribute__(self, "m"):
            return object.__getattribute__(self, "temp")
        return object.__getattribute__(self, name)

    def temp(self, com, act):
        self.m = act
        self.gamemethod = com

def play(Game):
    player = Player()
    while True:
        getattr(Game, player.gamemethod)(player)
