# DWR Modeling Grind (dwr-grid)

California's Department of Water Resoources (DWR) uses a number of grids, covering California for various modeling efforts.  Two of these are regular grids using the California Albers [EPSG:3310](http://spatialreference.org/ref/epsg/3310/) projection, and aligned so that the origin of that projection falls on the corners of the grid.  

## DWR 4km Grid

The most standard DWR grid has 4km grid points. The individual pixels in this grid, are given identifiers by DWR.  Rows in the grid are numbered from the top down, and columns from the left to the rigtht. The DWR identifer is then simply ```row_col```.   The numbering system covers a square from ```(south,west)=(-400000,-602000)``` to ```(east,north)=(540000,454000)```.  That's 236 columns and 265 rows, making 62540 cell. Given the ```(east,north)``` of any point in EPSG:3310, you can determine the grid point with ```(col,row) = ((east+402000)/4000,(456000-north)/4000)```.  Similarly, you can get the centroid from any dwr_id with ```(east,north)=((col*4000-402000),(456000-row*4000))```. 

## CalSIMETAW 

*calsimetaw* data includes only grid points used in DWR water balance models.  This grid points are over California's land.  Because these models use weather information supplied by two different systems; Spatial CIMIS, and PRISM, and because neither weather model includes all the dwr modeling points, there are two columns identifing if the weather data exists for this cell.  Previously, there were many missing data from the CIMIS program, but in 2013, the Spatial CIMIS data was recalculated, and now there is only one missing cell (1_13).  This is outside the range of the data saved from the GOES satellite imagery, required to calculate weather in the Spatial CIMIS program.

## Spatial CIMIS

The [CIMIS](http://www.cimis.water.ca.gov/) program uses a similar grid pattern, but instead at a 2(km)x2(km) grid size.  CIMIS has a program of delivering evapotranspiration estimates, and in that process also predict weather parameters; minimum, maximum and dew point temperatures solar radiation, cloud cover, and wind speed. 

In 2014, the amount of data captured by the GOES satellite was marginally increased to capture more of the boundary for California.  This allows for radation calculations to extend over a slightly larger region.  The new GOES regions is shown below.

start | end | west | south | east | north | rows | cols 
--- | --- | --- | --- | --- | ---  | --- | ---
2003-02-20 | 2013-12-31 | -400000 | -650000 | 600000 | 454000 | 552 | 500
2014-01-01 | present | -410000 | -660000 | 610000 | 460000 | 560 | 510

The standard CIMIS mask did not change however, and so the default data available via the cimis website did not change with this update.

## Calculation

The dwr_grid.sql file is a set postgis instructions used to create the data distributed here.  An additional set of csv files describe the points included in the various models.



