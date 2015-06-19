xquery version "3.0";
 
declare namespace vra="http://www.vraweb.org/vracore4.htm";

let $field_delimiter := "&#09;" (: delimiter for fields :)
let $value_delimiter := ", " (: delimiter for values within a field, NOT the field delimiter :)

let $head := string-join(("Exhibit Category", "Exhibit Subcategory (if applicable)", "Filename", "Artist Name", "Active Dates", "Release Date", "Format", "Donor", "Location", "Description"), $field_delimiter)

return
($head,
let $records := fn:collection("Metadata")/vra:vra
for $individual in $records

(: exhibit item categories/subcategories :)
let $file_path := tokenize(fn:base-uri($individual), '/')
let $category := $file_path[2]
let $subcategory := 
    if (fn:matches($file_path[3], '\.xml$'))
    then ""
    else ($file_path[3])
 (: assumes the metadata directory structure is no more than 2 levels deep
    i.e. [main category]/[subcategory **optional**]/[filename.xml]
 :)
let $filename :=
    if (fn:matches($file_path[3], '\.xml$'))
    then ($file_path[3])
    else ($file_path[4])

(: artist_name => work > titleSet > title :)
let $workTitlePath := $individual/vra:work/vra:titleSet/vra:title/text()

let $workTitle :=
    if (fn:empty($workTitlePath))
    then ("")
    else if ((count($workTitlePath)) > 1)
    then (fn:string-join(($workTitlePath), $value_delimiter))
    else ($workTitlePath)
    
(: active_dates => work > agentSet > agent > name (repeatable) :)
let $workAgentsPath := $individual/vra:work/vra:agentSet/vra:agent/vra:name/text()

let $workAgents :=
    if (fn:empty($workAgentsPath))
    then ("")
    else if ((count($workAgentsPath)) > 1)
    then (fn:string-join(($workAgentsPath), $value_delimiter))
    else ($workAgentsPath)
    
(: release_date => work > dateSet > date[@type="publication"] > earliestDate, work > dateSet > date[@type="publication"] > latestDate (if different) :)
let $datePath := $individual/vra:work/vra:dateSet/vra:date[@type="publication"]/vra:earliestDate/text()
let $datePathL := $individual/vra:work/vra:dateSet/vra:date[@type="publication"]/vra:latestDate/text()

let $date :=
    if (fn:empty($datePath))
    then ("")
    else ($datePath)
    
let $dateL := 
    if ($datePath = $datePathL)
    then ("")
    else (concat("-",$datePathL))

let $date := concat($date,$dateL)

(: format => work > worktypeSet > worktype :)
let $workTypePath := $individual/vra:work/vra:worktypeSet/vra:worktype/text()

let $workType :=
    if (fn:empty($workTypePath))
    then ("")
    else if ((count($workTypePath)) > 1)
    then (fn:string-join(($workTypePath), $value_delimiter))
    else ($workTypePath)
    
(: donor => work > locationSet > location > refid :)
let $donorPath := $individual//vra:work//vra:location[@type="repository"]/vra:refid/text()

let $donor :=
    if (fn:empty($donorPath))
    then ("")
    else if ((count($donorPath)) > 1)
    then (fn:string-join(($donorPath), $value_delimiter))
    else ($donorPath)   
   
    
(: location => work > locationSet > location[@type="repository"] > name :)
let $locationPath := $individual//vra:work//vra:location[@type="repository"]/vra:name/text()

let $location :=
    if (fn:empty($locationPath))
    then ("")
    else if ((count($locationPath)) > 1)
    then (fn:string-join(($locationPath), $value_delimiter))
    else ($locationPath)    
    
(: description => work > descriptionSet > description -- Line breaks replaced with --:)
let $workDescriptionPath := for $each in $individual/vra:work/vra:descriptionSet//vra:description/text()
return replace($each, "&#10;", " -- ")

let $workDescription :=
    if (fn:empty($workDescriptionPath))
    then ("")
    else if ((count($workDescriptionPath)) > 1)
    then (fn:string-join(($workDescriptionPath), $value_delimiter))
    else ($workDescriptionPath)

let $line := fn:string-join(($category, $subcategory, $filename, $workTitle, $workAgents, $date, $workType, $donor, $location, $workDescription), $field_delimiter)

return
 $line)

