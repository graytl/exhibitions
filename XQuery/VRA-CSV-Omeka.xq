xquery version "3.0";
 
declare namespace vra="http://www.vraweb.org/vracore4.htm";

let $head := "BASE_URI|WORK_TITLE|IMAGE_TITLE|FILE_NAME|CREATION_DATE|PUBLICATION_DATE|WORK_TYPE|AGENT_NAMES|DESCRIPTION|WORK_RIGHTS"

return
($head,
let $records := fn:collection("Metadata")/vra:vra
for $individual in $records

(:WORK DATA:)
(:Work Title:)
let $workTitlePath := $individual/vra:work/vra:titleSet/vra:title/text()

let $workTitle :=
    if (fn:empty($workTitlePath))
    then ("NULL")
    else if ((count($workTitlePath)) > 1)
    then (fn:string-join(($workTitlePath), "; "))
    else ($workTitlePath)
    
(:WorkAgents:)
let $workAgentsPath := $individual/vra:work/vra:agentSet/vra:agent/vra:name/text()

let $workAgents :=
    if (fn:empty($workAgentsPath))
    then ("NULL")
    else if ((count($workAgentsPath)) > 1)
    then (fn:string-join(($workAgentsPath), "; "))
    else ($workAgentsPath)

(:Work Publication Date - Earliest:)
let $workPublicationDateEarlyPath := $individual/vra:work/vra:dateSet/vra:date[@type="publication"]/vra:earliestDate/text()

let $workPublicationDateEarly :=
    if (fn:empty($workPublicationDateEarlyPath))
    then ("NULL")
    else if ((count($workPublicationDateEarlyPath)) > 1)
    then (fn:string-join(($workPublicationDateEarlyPath), "; "))
    else ($workPublicationDateEarlyPath)

(:Work Creation Date - Earliest:)
let $workCreationDateEarlyPath := $individual/vra:work/vra:dateSet/vra:date[@type="creation"]/vra:earliestDate/text()

let $workCreationDateEarly :=
    if (fn:empty($workCreationDateEarlyPath))
    then ("NULL")
    else if ((count($workCreationDateEarlyPath)) > 1)
    then (fn:string-join(($workCreationDateEarlyPath), "; "))
    else ($workCreationDateEarlyPath)
    
(:WorkType:)
let $workTypePath := $individual/vra:work/vra:worktypeSet/vra:worktype/text()

let $workType :=
    if (fn:empty($workTypePath))
    then ("NULL")
    else if ((count($workTypePath)) > 1)
    then (fn:string-join(($workTypePath), "; "))
    else ($workTypePath)
    
(:Work Description -- Line breaks replaced with space:)
let $workDescriptionPath := for $each in $individual/vra:work/vra:descriptionSet//vra:description/text()
return replace($each, "&#10;", " ")

let $workDescription :=
    if (fn:empty($workDescriptionPath))
    then ("NULL")
    else if ((count($workDescriptionPath)) > 1)
    then (fn:string-join(($workDescriptionPath), "; "))
    else ($workDescriptionPath)

(:Work Rights -- Newlines replaced with " -- ":)
let $workRightsPath := for $each in $individual/vra:work/vra:rightsSet/vra:rights/vra:text/text()
return replace($each, "&#10;", " -- ")

let $workRights :=
    if (fn:empty($workRightsPath))
    then ("NULL")
    else if ((count($workRightsPath)) > 1)
    then (fn:string-join(($workRightsPath), "; "))
    else ($workRightsPath)    
    
(:IMAGE DATA:)
(:Image Title:)
let $imageTitlePath := $individual/vra:image/vra:titleSet/vra:title/text()

let $imageTitle := 
    if (fn:empty($imageTitlePath))
    then ("NULL")
    else if ((count($imageTitlePath)) > 1)
    then (fn:string-join(($imageTitlePath), "; "))
    else ($imageTitlePath)
    
(:Image Location REFID:)
let $imageLocationRefidPath := $individual/vra:image/vra:locationSet/vra:location/vra:refid/text()

let $imageLocationRefid :=
    if (fn:empty($imageLocationRefidPath))
    then ("NULL")
    else if ((count($imageLocationRefidPath)) > 1)
    then (fn:string-join(($imageLocationRefidPath), "; "))
    else ($imageLocationRefidPath)    

let $line := fn:string-join((fn:base-uri($individual),$workTitle, $imageTitle, $imageLocationRefid, $workCreationDateEarly,$workPublicationDateEarly, $workType, $workAgents, $workDescription, $workRights), '|')

return
 $line)

