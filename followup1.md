---
follows: coursework
---

Put your initial followup design concept here

## Making maps

For this, the [map tutorials](https://github.com/gicentre/litvis/blob/main/documents/tutorials/geoTutorials/) are very helpful. The idea here is to show settlements as points on a map.

### Map itself

To get map background, you need a shape file which contains the different
areas you want to draw on screen. In this case we're looking for a world map
so the different "shapes" are different contries. If you look at the json
file, you'll have a shape for each contry which consists of a set of points
describing the outline of each country. Note that I'm "stealing" the map data
from the [vega site](https://vega.github.io).

```elm {l}
mapData = dataFromUrl "https://vega.github.io/vega/data/world-110m.json"
                      [ topojsonFeature "countries" ]
```

Then we need to create a vega-lite layer to show the geographic data.
`maFill` is a function to set the fill of marks to a constant.

```elm {l}
mapSpec : Spec
mapSpec =
  asSpec
    [ mapData, geoshape [ maFill "#4c566a" ] ]
```

### Settlement positions

There are a number of feature types in the dataset so we need to set up a
vega lite filter to only show those types. Think of this operation by itself
as a kind of function that runs over the dataset.

```elm {l}
settlementTrans =
  transform
    << filter (fiExpr "datum.featureType == 'settlement'")
```

Then we can bring in the settlements which you can put on the map by basically making
a scatterplot but using the latitude and longitude.

```elm {l}
settlementEnc =
  encoding
    << position Latitude [ pName "reprLat" ]
    << position Longitude  [ pName "reprLong" ]
```

And then we can put it all together. Ideally this map should zoom or at least
cut off north and south america and antarctica but that's left as an exercise
to the reader :)

{(aim|}
This chart shows that the dataset mostly contains locations from the Roman
and Greek empires.
{|aim)}

{(vistype|}
map
{|vistype)}

```elm {v}
map : Spec
map =
  let
    settlementSpec =
      asSpec
        [ locs
        , settlementTrans []
        , settlementEnc []
        , point [ maStroke "", maFill "#a3be8c", maSize 2.9 ]
        ]
  in
  toVegaLite [width 700, height 500, layer [ mapSpec, settlementSpec ] ]
```

{(vismapping|}

x position
: latitude of location

y position
: longitude of location

{|vismapping)}

{(dataprep|}
Only settlements were included.
{|dataprep)}

{(limitations|}
This is a very simple visualization. Interaction (esp zooming) would help greatly.
{|limitations)}
