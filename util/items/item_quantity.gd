class_name ItemQuantity

var item: Item
var quantity: int

func _init(_item: Item, _quantity: int):
    self.item = _item
    self.quantity = _quantity

func _to_string() -> String:
    return "ItemQuantity(item: {item}, quantity: {quantity})".format({
        "item": item,
        "quantity": quantity
    })