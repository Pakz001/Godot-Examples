A basic flood fill function for filling a map[][] array. floods with 4 way direction u/d/l/r.

Update:

I have used the floodfill function in another project and discovered it was really slow. This was caused by the pop_front and push_front methods. This causes goto to have to shift the entire list every time you use this. I changed it to use append to add to the list and pop_back to remove the last item.
