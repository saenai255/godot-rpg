class_name Recipe

var name := "<unnamed>"
var required_skill: int
var generates_items: Array[ItemTemplateQuantity]
var required_items: Array[ItemTemplateQuantity]

static func from(fn: Callable) -> Recipe:
    var it := new()
    fn.call(it)
    return it