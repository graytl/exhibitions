xquery version "3.0";
 
declare namespace vra="http://www.vraweb.org/vracore4.htm";

let $head := "BASE_URI&#09;WORK_TITLE&#09;CREATION_DATE&#09;PUBLICATION_DATE&#09;WORK_TYPE&#09;AGENT_NAMES&#09;RIGHTS_TYPE&#09;WORK_RIGHTS&#09;IMAGE_TITLE&#09;FILE_NAME"

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
    then (fn:string-join(($workTitlePath), "|| "))
    else ($workTitlePath)
    
(:WorkAgents:)
let $workAgentsPath := $individual/vra:work/vra:agentSet/vra:agent/vra:name/text()

let $workAgents :=
    if (fn:empty($workAgentsPath))
    then ("NULL")
    else if ((count($workAgentsPath)) > 1)
    then (fn:string-join(($workAgentsPath), "|| "))
    else ($workAgentsPath)

(:Work Publication Date - Earliest:)
let $workPublicationDateEarlyPath := $individual/vra:work/vra:dateSet/vra:date[@type="publication"]/vra:earliestDate/text()

let $workPublicationDateEarly :=
    if (fn:empty($workPublicationDateEarlyPath))
    then ("NULL")
    else if ((count($workPublicationDateEarlyPath)) > 1)
    then (fn:string-join(($workPublicationDateEarlyPath), "|| "))
    else ($workPublicationDateEarlyPath)

(:Work Creation Date - Earliest:)
let $workCreationDateEarlyPath := $individual/vra:work/vra:dateSet/vra:date[@type="creation"]/vra:earliestDate/text()

let $workCreationDateEarly :=
    if (fn:empty($workCreationDateEarlyPath))
    then ("NULL")
    else if ((count($workCreationDateEarlyPath)) > 1)
    then (fn:string-join(($workCreationDateEarlyPath), "|| "))
    else ($workCreationDateEarlyPath)
    
(:WorkType:)
let $workTypePath := $individual/vra:work/vra:worktypeSet/vra:worktype/text()

let $workType :=
    if (fn:empty($workTypePath))
    then ("NULL")
    else if ((count($workTypePath)) > 1)
    then (fn:string-join(($workTypePath), "|| "))
    else ($workTypePath)
    
(:Work Rights -- Newlines replaced with " -- ":)
let $workRightsPath := for $each in $individual/vra:work/vra:rightsSet/vra:rights/vra:text/text()
return replace($each, "&#10;", " -- ")

let $workRights :=
    if (fn:empty($workRightsPath))
    then ("NULL")
    else if ((count($workRightsPath)) > 1)
    then (fn:string-join(($workRightsPath), "|| "))
    else ($workRightsPath)

(:RightsType:)
let $rightsTypePath := $individual/vra:work/vra:rightsSet/vra:rights/@type/data()

let $rightsType :=
    if (fn:empty($rightsTypePath))
    then ("NULL")
    else if ((count($rightsTypePath)) > 1)
    then (fn:string-join(($rightsTypePath), "|| "))
    else ($rightsTypePath)        
    
(:IMAGE DATA:)
(:Image Title:)
let $imageTitlePath := $individual/vra:image/vra:titleSet/vra:title/text()

let $imageTitle := 
    if (fn:empty($imageTitlePath))
    then ("NULL")
    else if ((count($imageTitlePath)) > 1)
    then (fn:string-join(($imageTitlePath), "|| "))
    else ($imageTitlePath)
    
(:Image Location REFID:)
let $imageLocationRefidPath := $individual/vra:image/vra:locationSet/vra:location/vra:refid/text()

let $imageLocationRefid :=
    if (fn:empty($imageLocationRefidPath))
    then ("NULL")
    else if ((count($imageLocationRefidPath)) > 1)
    then (fn:string-join(($imageLocationRefidPath), "|| "))
    else ($imageLocationRefidPath)    

let $line := fn:string-join((fn:base-uri($individual),$workTitle, $workCreationDateEarly,$workPublicationDateEarly, $workType, $workAgents, $rightsType, $workRights, $imageTitle, $imageLocationRefid), '&#09;')

return
 $line)

