
It took me a while to discover why the world_to_map and the bullets were not finding the right tiles. I think I solved it for now by dividing the bullet position by the tilemap.scale. I still have to modify the cell positions a bit and am not sure why I need to do this.

The next thing I can concentrate on is to add pickups when a tile is destroyed. I need a couple of new sprites and need to fix the pickup floating towards player problem.
