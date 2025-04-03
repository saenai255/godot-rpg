class_name Profession

var name := "<unnamed>"
var skill: int
const MAX_SKILL := 300
var all_recipes: Array[Recipe] = []
var known_recipes: Array[Recipe] = []


static func from(fn: Callable) -> Profession:
    var it := new()
    fn.call(it)
    return it