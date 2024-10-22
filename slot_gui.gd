extends Panel
@onready var backgroundSprite: Sprite2D = $background
@onready var itempSprite: Sprite2D = $CenterContainer/Panel/item

func update(item: InventoryItem):
	if !item:
		backgroundSprite.frame = 0
		itempSprite.visible = false
	else:
		backgroundSprite.frame = 1
		itempSprite.visible = true
		itempSprite.texture = item.texture
		
