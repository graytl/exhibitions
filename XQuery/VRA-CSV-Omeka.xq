xquery version "3.0";
 
declare namespace vra="http://www.vraweb.org/vracore4.htm";

let $head := "BASE_URI|TITLE|DATE|FORMAT|CONTRIBUTOR|SUBJECT|DESCRIPTION|SOURCE|RIGHTS|FILE_PATH"


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
    
(:WorkAgents -- CONTRIBUTORS:)
let $workAgentsPath := $individual/vra:work/vra:agentSet/vra:agent/vra:name/text()

let $workAgents :=
    if (fn:empty($workAgentsPath))
    then ("NULL")
    else if ((count($workAgentsPath)) > 1)
    then (fn:string-join(($workAgentsPath), "; "))
    else ($workAgentsPath)

(:WorkType -- FORMAT:)
let $workTypePath := $individual/vra:work/vra:worktypeSet/vra:worktype/text()

let $workType :=
    if (fn:empty($workTypePath))
    then ("NULL")
    else if ((count($workTypePath)) > 1)
    then (fn:string-join(($workTypePath), "; "))
    else ($workTypePath)
    
(: Subject! :)
let $subjectPath := $individual//vra:work//vra:subject/vra:term/text()

let $subject :=
    if (fn:empty($subjectPath))
    then ("NULL")
    else if ((count($subjectPath)) > 1)
    then (fn:string-join(($subjectPath), "; "))
    else ($subjectPath)
    
(:Work Description -- Line breaks replaced with --:)
let $workDescriptionPath := for $each in $individual/vra:work/vra:descriptionSet//vra:description/text()
return replace($each, "&#10;", " -- ")

let $workDescription :=
    if (fn:empty($workDescriptionPath))
    then ("NULL")
    else if ((count($workDescriptionPath)) > 1)
    then (fn:string-join(($workDescriptionPath), "; "))
    else ($workDescriptionPath)
    
(:Work Source:)
let $sourcePath := $individual//vra:work//vra:location[@type="repository"]/vra:refid/text()

let $source :=
    if (fn:empty($sourcePath))
    then ("NULL")
    else if ((count($sourcePath)) > 1)
    then (fn:string-join(($sourcePath), "; "))
    else ($sourcePath)

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
    
(:File Path (Image Location REFID):)
let $fileNamePath := $individual/vra:image/vra:locationSet/vra:location/vra:refid/text()

let $imageShare := "PATH TO IMAGES/"

let $filePath :=
    if (fn:empty($fileNamePath))
    then ("NULL")
    else if ((count($fileNamePath)) > 1)
    then (fn:string-join(for $file in $fileNamePath return (string-join(($imageShare, $file), "")), "; "))
    else (string-join(($imageShare, $fileNamePath), ""))

(:Image Rights:)
let $imageRightsPath := for $each in $individual//vra:image/vra:rightsSet/vra:rights/vra:text/text()
return replace($each, "&#10;", " -- ")

let $imageRights :=
    if (fn:empty($imageRightsPath))
    then ("NULL")
    else if ((count($imageRightsPath)) > 1)
    then (fn:string-join(($imageRightsPath), "; "))
    else ($imageRightsPath)
    
(:Rights:)
let $rights := $workRights||$imageRights

let $line := fn:string-join((fn:base-uri($individual),$workTitle, $date, $workType, $workAgents, $subject, $workDescription, $source, $rights, $imageRights, $filePath), '|')

return
 $line)

