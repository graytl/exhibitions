xquery version "3.0";
 
declare namespace vra="http://www.vraweb.org/vracore4.htm";
import module namespace functx = "http://www.functx.com" at "libraries/functx-1.0-nodoc-2007-01.xq";

let $head := "BASE_URI&#09;TITLE&#09;DATE&#09;FORMAT&#09;CONTRIBUTOR&#09;SUBJECT&#09;DESCRIPTION&#09;SOURCE&#09;RIGHTS&#09;FILE_PATH&#09;FILE_NAME&#09;TAGS"

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
    then ("")
    else if ((count($workTitlePath)) > 1)
    then (fn:string-join(($workTitlePath), "|"))
    else ($workTitlePath)
    
(:Work Date -- Creation and Publication earliestDate as Date:)
let $datePath := $individual/vra:work/vra:dateSet/vra:date/vra:earliestDate/text()

let $date :=
    if (fn:empty($datePath))
    then ("")
    else if ((count($datePath)) > 1)
    then (fn:string-join(($datePath), "|"))
    else ($datePath)
    
(:WorkAgents -- CONTRIBUTORS:)
let $workAgentsPath := $individual/vra:work/vra:agentSet/vra:agent/vra:name/text()

let $workAgents :=
    if (fn:empty($workAgentsPath))
    then ("")
    else if ((count($workAgentsPath)) > 1)
    then (fn:string-join(($workAgentsPath), "|"))
    else ($workAgentsPath)

(:WorkType -- FORMAT:)
let $workTypePath := $individual/vra:work/vra:worktypeSet/vra:worktype/text()

let $workType :=
    if (fn:empty($workTypePath))
    then ("")
    else if ((count($workTypePath)) > 1)
    then (fn:string-join(($workTypePath), "|"))
    else ($workTypePath)
    
(: Subject! :)
let $subjectPath := $individual//vra:work//vra:subject/vra:term/text()

let $subject :=
    if (fn:empty($subjectPath))
    then ("")
    else if ((count($subjectPath)) > 1)
    then (fn:string-join(($subjectPath), "|"))
    else ($subjectPath)
    
(:Work Description -- Line breaks replaced with --:)
let $workDescriptionPath := for $each in $individual/vra:work/vra:descriptionSet//vra:description/text()
return replace($each, "&#10;", " -- ")

let $workDescription :=
    if (fn:empty($workDescriptionPath))
    then ("")
    else if ((count($workDescriptionPath)) > 1)
    then (fn:string-join(($workDescriptionPath), "|"))
    else ($workDescriptionPath)
    
(:Work Source:)
let $sourcePath := $individual//vra:work//vra:location[@type="repository"]/vra:refid/text()

let $source :=
    if (fn:empty($sourcePath))
    then ("")
    else if ((count($sourcePath)) > 1)
    then (fn:string-join(($sourcePath), "|"))
    else ($sourcePath)

(:Work Rights -- Newlines replaced with " -- ":)
let $workRightsPath := for $each in $individual/vra:work/vra:rightsSet/vra:rights/vra:text/text()
return concat("Work: ", replace(functx:capitalize-first($each), "&#10;", " -- "))

let $workRights :=
    if (fn:empty($workRightsPath))
    then ("")
    else if ((count($workRightsPath)) > 1)
    then (fn:string-join(($workRightsPath), "|"))
    else ($workRightsPath)
       
    
(:IMAGE DATA:
  Title
  FileName
  Image Title
  File Path
   FileName
  :)
(:Imagetitle:)
let $imageTitlePath := $individual/vra:image/vra:titleSet/vra:title/text()

let $imageTitle := 
    if (fn:empty($imageTitlePath))
    then ("")
    else if ((count($imageTitlePath)) > 1)
    then (fn:string-join(($imageTitlePath), "|"))
    else ($imageTitlePath)
    
    
(:File Name and  Path (Image Location REFID):)
let $fileNamePath := $individual/vra:image/vra:locationSet/vra:location/vra:refid/text()

let $imageShare := "http://libexh.library.vanderbilt.edu/impomeka/2015-exhibit/"

let $fileName :=
    if (fn:empty($fileNamePath))
    then ("")
    else if ((count($fileNamePath)) > 1)
    then (fn:string-join(($fileNamePath), "|"))
    else ($fileNamePath)

let $filePath :=
    if (fn:empty($fileNamePath))
    then ("")
    else if ((count($fileNamePath)) > 1)
    then (fn:string-join(for $file in $fileNamePath return (string-join(($imageShare, $file), "")), "|"))
    else (string-join(($imageShare, $fileNamePath), ""))

(:Image Rights:)
let $imageRightsPath := for $each in $individual//vra:image/vra:rightsSet/vra:rights/vra:text/text()
return concat("Image: ", replace(functx:capitalize-first($each), "&#10;", " -- "))

let $imageRights :=
    if (fn:empty($imageRightsPath))
    then ("")
    else if ((count($imageRightsPath)) > 1)
    then (fn:string-join(($imageRightsPath), "|"))
    else ($imageRightsPath)
    
(:Rights:)
let $rights := 
    if (functx:all-whitespace($workRights))
    then ($imageRights)
    else (replace(fn:string-join(($workRights, $imageRights), "|"), functx:escape-for-regex(".."), "."))

(: TAGS: exhibit item categories/subcategories :)
 (: assumes the metadata directory structure is no more than 2 levels deep
    i.e. [main category]/[subcategory **optional**]/[filename.xml]
 :)
let $file_path := tokenize(fn:base-uri($individual), '/')
let $category := functx:capitalize-first($file_path[2])
let $subcategory := 
    if (fn:matches($file_path[3], '\.xml$'))
    then ""
    else (functx:capitalize-first($file_path[3]))
let $tags := 
    if (functx:all-whitespace($subcategory))
    then ($category)
    else concat($category, "|", $subcategory)
let $tags := functx:replace-multi(concat($tags, "|", "2015 Exhibits"), ("-", "Satellite "), (" ", ""))

let $line := fn:string-join((fn:base-uri($individual),$workTitle, $date, $workType, $workAgents, $subject, $workDescription, $source, $rights, $filePath, $fileName, $tags), '&#09;')

return
 $line)

