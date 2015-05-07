xquery version "3.0";
 
declare namespace vra="http://www.vraweb.org/vracore4.htm";

let $head := "BASE_URI|WORK_TITLE|DATE|AGENT_NAMES|DESCRIPTION|WORK_RIGHTS"

return
($head,
let $records := fn:collection("Metadata")/vra:vra
for $individual in $records

(:WORK DATA:
  Title
  Date
  Agents
  Type
  Description
  Rights:)

(:Work Title:)
let $workTitlePath := $individual/vra:work/vra:titleSet/vra:title/text()

let $workTitle :=
    if (fn:empty($workTitlePath))
    then ("NULL")
    else if ((count($workTitlePath)) > 1)
    then (fn:string-join(($workTitlePath), "; "))
    else ($workTitlePath)
    
(:Work Date -- Creation and Publication earliestDate as Date:)
let $datePath := $individual/vra:work/vra:dateSet/vra:date/vra:earliestDate/text()

let $date :=
    if (fn:empty($datePath))
    then ("NULL")
    else if ((count($datePath)) > 1)
    then (fn:string-join(($datePath), "; "))
    else ($datePath)
    
(:WorkAgents:)
let $workAgentsPath := $individual/vra:work/vra:agentSet/vra:agent/vra:name/text()

let $workAgents :=
    if (fn:empty($workAgentsPath))
    then ("NULL")
    else if ((count($workAgentsPath)) > 1)
    then (fn:string-join(($workAgentsPath), "; "))
    else ($workAgentsPath)

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
    
(:IMAGE DATA:
  Title
  FileName
  Image Title (.../vra:image/vra:locationSet/vra:location/vra:refid
File Path)
  :)
let $imageTitlePath := $individual/vra:image/vra:titleSet/vra:title/text()

let $imageTitle := 
    if (fn:empty($imageTitlePath))
    then ("NULL")
    else if ((count($imageTitlePath)) > 1)
    then (fn:string-join(($imageTitlePath), "; "))
    else ($imageTitlePath)
    
(:FileName (Image Location REFID):)
let $fileNamePath := $individual/vra:image/vra:locationSet/vra:location/vra:refid/text()

let $fileName :=
    if (fn:empty($fileNamePath))
    then ("NULL")
    else if ((count($fileNamePath)) > 1)
    then (fn:string-join(($fileNamePath), "; "))
    else ($fileNamePath)    

(: Path to File on server:)
  let $imageShare := "PATH TO IMAGES/"
  let $filePath := $imageShare||$fileName

let $line := fn:string-join((fn:base-uri($individual),$workTitle, $imageTitle, $filePath, $date, $workType, $workAgents, $workDescription, $workRights), '|')

return
 $line)

