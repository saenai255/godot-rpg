class_name ItemTemplateQuantity

var item: ItemTemplate
var quantity: int

func _init(_item: ItemTemplate, _quantity: int):
    self.item = _item
    self.quantity = _quantity

func _to_string() -> String:
    return "ItemQuantity(item_template: {item}, quantity: {quantity})".format({
        "item": item,
        "quantity": quantity
    })