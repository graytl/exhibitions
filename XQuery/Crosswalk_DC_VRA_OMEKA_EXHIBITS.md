#DC/VRA Crosswalk


| DC | VRA |
|----|-----|
| title | title |
| creator | -- |
| contributor | agent |
| publisher | -- |
| description | description |
| subject | subject |
| language | -- |
| rights | rights/text |
| type | -- |
| relation | -- |
| format | worktype |
| coverage | -- |
| identifier | -- |
| date | date/earliestDate |
| source | location/refid |

| OMEKA | VRA |
| ----- | --- |
| File | image//location/refid |
| Tags | directory structure where XML file is located |
| Collection | a manually-entered form of location/refid |

###Omeka import prep, post-BaseX
After the CSV has been generated from BaseX but before import into Omeka:

* Remove all entries without a filename
* Create new column for Collection and manually put in the Omeka collection where the item should go (based on the Omeka Source field, VRA location/refid field)
