# DWR Modeling Grind (dwr-grid)

California's Department of Water Resoources (DWR) uses a number of grids, covering California for various modeling efforts.  Two of these are regular grids using the California Albers [EPSG:3310](http://spatialreference.org/ref/epsg/3310/) projection, and aligned so that the origin of that projection falls on the corners of the grid.  

## DWR 4km Grid

The most standard DWR grid has 4km grid points. The individual pixels in this grid, are given identifiers by DWR.  Rows in the grid are numbered from the top down, and columns from the left to the rigtht. The DWR identifer is then simply ```row_col```.   The numbering system covers a square from ```(south,west)=(-400000,-602000)``` to ```(east,north)=(540000,454000)```.  That's 236 columns and 265 rows, making 62540 cell. Given the ```(east,north)``` of any point in EPSG:3310, you can determine the grid point with ```(col,row) = ((east+402000)/4000,(456000-north)/4000)```.  Similarly, you can get the centroid from any dwr_id with ```(east,north)=((col*4000-402000),(456000-row*4000))```. 

The *calsimetaw* data includes only grid points used in DWR water balance models.  Because these models use weather information supplied 

### Postgres / PostGIS

The dwr_grid.sql file is a set postgis instructions used to create the data distributed here.

## Spatial CIMIS

The [CIMIS](http://www.cimis.water.ca.gov/) program uses a similar grid 

