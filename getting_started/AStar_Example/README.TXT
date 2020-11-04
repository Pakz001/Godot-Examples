
Pathfinding is build in. In this example here the 2d Astar is used. There is also a 3d version.

Note that you need to create connections between the cells once you have set up the pathing. These connections can be of any kind. Here I connected each cell to the above and below and left and right ones. This except for the edges of the map.

The id's for the cells in the Astar map need to be unique for each cell.

In the example I created a array (y,x) and put some random obstacles on them(weight of 99 with the astar algo)
