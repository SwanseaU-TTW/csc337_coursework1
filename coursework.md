---
elm:
  dependencies:
    gicentre/elm-vegalite: latest

narrative-schemas:
  - coursework
---

uthor: Your name (student number)

Before using these sets of documents, make sure you have everything installed
correctly. Installation instructions are here:
<https://github.com/gicentre/litvis/blob/main/documents/tutorials/introduction/installingLitvis.md>.

These files serve two purposes: 1) to give you some templates that can help you prepare your submission and 2) examples of using elm-vegalite on the Pleiades dataset. **When preparing your submission remember to delete my code/text and replace it with your own!** If I submitted these visualizations as this coursework I wouldn't get a very good mark. They are far too basic :)

# Ancient civilizations

```elm {l=hidden}
import VegaLite exposing (..)
```

There are 3 data files from [Pleiades](https://pleiades.stoa.org/). These
need to be loaded into the interpreter. For reference, there is a separate file
for the places, names, and locations in the database.

```elm {l}
names : Data
names = dataFromUrl "./pleiades-names-latest.csv" []
locs : Data
locs = dataFromUrl "./pleiades-locations-latest.csv" []
places : Data
places = dataFromUrl "./pleiades-places-latest.csv" []
```

## Getting started

Looking at the CSV and [documentation](http://atlantides.org/downloads/pleiades/dumps/README.txt), we decide that maybe we'll start with a simple bar chart/histogram.

{(aim|}
This chart shows that certain categories occur much more frequently than others and that
some data processing is needed to split the `featureType` column up by the delimeter.
Many locations have multiple types.
{|aim)}

```elm {v}
histo : Spec
histo =
  let
    --trans = transform
    enc =
      encoding
        << position Y [ pName "featureType"]
        << position X [ pAggregate opCount ]
  in
  toVegaLite [ locs, enc [], bar [] ]
```

{(vistype|}
bar chart
{|vistype)}

{(vismapping|}

**Note**: this should be a list of some type (here I'm using a dictionary list)

y position
: featureType category

length
: count of location

{|vismapping)}

{(dataprep|}
Data were aggregated by category to generate counts
{|dataprep)}

{(limitations|}
This is a very simple visualization and it's not clear what it yields.
{|limitations)}
