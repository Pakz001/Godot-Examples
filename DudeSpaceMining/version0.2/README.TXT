
Here I added the ability of the bullets destroying the tiles. This took me a while to get working to this point.

When the bullet collides I now start a loop where I use the last bullet its position and go in a circle that increases
in size. Eventually a tile is found and removed, then the loop is exited. I needed to do this since I was not able
to figure out how to find the right tile near the bullet.

Also the world_to_map seems off. I have no idea what I am doing wrong but I need to offset the x and y coordinates a
bit for it to remove the right tile.

Another not is that I use a function to find the tile that can be removed. Here I am using a tile atlas and the
method of finding the tile on the map is that you get returned the position of the tile in that atlas. I created
a function that returns true if the x,y spot on the atlas may be removed.

Bugs :
The bullets seem to fly off the screen and fly back into the screen from the other side.
