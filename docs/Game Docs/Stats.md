## Minor Stats
### Health
```python
health = 90 + value + level * 10
```
### Mana
```python
mana = 90 + value + level * 10
```
### Physical Power
Increases base physical damage. Skills use it in their damage formula.
```python
damage = random(weapon_min, weapon_max) + value
```
### Magic Power
Increases magic damage and healing. Skills use it in their damage and healing formula.
### Physical Armor
Reduces incoming physical damage.
```python
chance = (5 + value / 20 + level / 3) / 100

# example results
# level 10, value 150 => 15.83%
# level 1, value 0 => 5.33%
# level 50, value 500 => 46.66%
# level 30, valiue 300 => 30%
```
### Magic Armor
Reduces incoming magic damage.
```python
chance = (5 + value / 20 + level / 3) / 100

# example results
# level 10, value 150 => 15.83%
# level 1, value 0 => 5.33%
# level 50, value 500 => 46.66%
# level 30, valiue 300 => 30%
```
### Dodge
Reduces the chance that the [[Unit]] will be hit.
```python
chance = (5 + value / 20 + level / 3) / 100

# example results
# level 10, value 150 => 15.83%
# level 1, value 0 => 5.33%
# level 50, value 500 => 46.66%
# level 30, valiue 300 => 30%
```
### Critical
Increases the chance that the next hit will be a critical hit.
```python
chance = (5 + value / 20 + level / 3) / 100

# example results
# level 10, value 150 => 15.83%
# level 1, value 0 => 5.33%
# level 50, value 500 => 46.66%
# level 30, valiue 300 => 30%
```
### Critical Power
The amount by which the hit is multiplied.
```python
multiplier = (50 + value / 10 + level * 2) / 100

# example results
# level 50, crit power 500 => 200%
# level 50, crit power 300 => 180%
# level 1, crit power 0 => 52%
# level 10, crit power 150 => 85%
```
## Major Stats
### Strength 
```python
1 strength = 2 physical power + 2 armor
```
### Intellect
```python
1 intellect = 2 magic power + 2 mana
```
### Dexterity
```python
1 dexterity = 1 physical power + 1 dodge + 1 crit + 1 crit power 
```
### Stamina
```python
1 stamina = 10 health
```