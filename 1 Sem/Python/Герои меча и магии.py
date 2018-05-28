import json

max_health = {'Barbarian': 120, 'Knight': 100, 'Sorceress': 50, 'Warlock': 70}
max_attack = {'Barbarian': 180, 'Knight': 150, 'Sorceress': 90, 'Warlock': 100}
max_defence = {'Knight': 170, 'Barbarian': 150, 'Warlock': 50, 'Sorceress': 42}
max_mana = {'Sorceress': 200, 'Knight': 0, 'Barbarian': 0, 'Warlock': 180}

persons = {}


class Quality:
    def __init__(self, data):
        self.race = data['race']
        self.health = min(data['health'], max_health[self.race])
        self.defence = min(data['defence'], max_defence[self.race])
        self.attack = min(data['attack'], max_attack[self.race])
        self.experience = data['experience']
        self.mana = 0
        self.lord = data['lord']
        if('mana' in data):
            self.mana = min(data['mana'], max_mana[self.race])


def attack(attacker, protection, power):
    if attacker.health <= 0 or protection.health <= 0:
        return
    else:
        attacker.attack = max(0, attacker.attack - power)
        if protection.defence >= power:
            protection.defence -= power
        else:
            protection.defence = 0
            protection.health -= (power - protection.defence)
        if protection.health <= 0:
            attacker.experience += 5
            return
        else:
            attacker.experience += 1
            protection.experience += 1
            return


def cast(attacker, protection, power):
    if attacker.health <= 0 or protection.health <= 0:
        return
    else:
        if attacker.mana < power:
            return
        attacker.mana -= power
        if protection.health <= 0:
            attacker.experience += 5
        else:
            attacker.experience += 1
            protection.experience += 1
        if protection.defence >= power:
            protection.defence -= power
        else:
            protection.health -= power - protection.defence
            protection.defence = 0
        return


def heal(attacker, protection, power):
    if attacker.health <= 0 or protection.health <= 0:
        return
    else:
        if attacker.mana < power:
            return
        attacker.mana -= power
        new_health = protection.health + power
        protection.health = min(new_health, max_health[protection.race])
        return


def battle(step):
    if step['action'] == 'attack':
        attack(persons[step['id_from']], persons[step['id_to']], step['power'])
    if step['action'] == 'cast_damage_spell':
        cast(persons[step['id_from']], persons[step['id_to']], step['power'])
    if step['action'] == 'cast_health_spell':
        heal(persons[step['id_from']], persons[step['id_to']], step['power'])


def count_win(persons):
    res = {}
    points = {}
    points['Archibald'] = 0
    res['Archibald'] = 0
    res['Ronald'] = 0
    points['Ronald'] = 0
    for id in persons:
        hero = persons[id]
        if(hero.health > 0):
            points[hero.lord] += 1
            temp1 = hero.experience + 2 * hero.defence
            temp2 = 3 * hero.attack + 10 * hero.mana
            res[hero.lord] += temp1 + temp2
    if points['Archibald'] == points['Ronald'] == 0:
        return 'unknown'
    elif points['Archibald'] == 0:
        return 'Ronald'
    elif points['Ronald'] == 0:
        return 'Archibald'
    if(res['Ronald'] > res['Archibald']):
        return 'Ronald'
    if(res['Archibald'] > res['Ronald']):
        return 'Archibald'
    if (res['Archibald'] == res['Ronald']):
        return 'unknown'

data = json.loads(input())
for arm in data['armies']:
    persons[arm] = Quality(data['armies'][arm])
for bat in data['battle_steps']:
    battle(bat)

print(count_win(persons))
