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
| source | location[@type="repository"]/refid |

| OMEKA | VRA |
| ----- | --- |
| File | image//location/refid |
| Tags | directory structure where XML file is located |
| Collection | a manually-entered form of location[@type="repository"]/refid |


location @type = (repository, creation, other). not mapping to DC right now.

After CSV has been generated from BaseX but before import into Omeka:

* Remove all entries without a filename
* Remove all entries in the Metadata/Templates directory
* Create new column for Collection and manually put in the Omeka collection where the item should go (based on the Omeka Source field, VRA location[@type="repository"]/refid field)
