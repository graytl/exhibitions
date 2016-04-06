xquery version "3.0";
 
declare namespace vra="http://www.vraweb.org/vracore4.htm";
import module namespace functx = "http://www.functx.com" at "libraries/functx-1.0-nodoc-2007-01.xq";

let $field_delimiter := "&#09;" (: delimiter for fields -- tab :)
(: let $field_delimiter := ","  :)(: delimiter for fields -- comma :)
let $value_delimiter := "|" (: delimiter for values within a field, NOT the field delimiter :)
let $imageShare := "http://libexh.library.vanderbilt.edu/impomeka/2015-exhibit/"
(: let $head := fn:string-join(("BASE_URI", "Title", "Date", "Format", "Contributor", "Subject", "Description", "Source", "Rights", "FILE_PATH", "FILE_NAME", "TAGS"), $field_delimiter) :)
let $head := fn:string-join(("BASE_URI", "Title", "Date", "Format", "Contributor", "Subject", "Description", "Source", "Rights", "FILE_PATH", "TAGS"), $field_delimiter)

return
($head,
let $records := fn:collection("Metadata")/vra:vra
for $individual in $records

(:WORK DATA:
  Title
  Date
  Agents
  Type
  Description :)

(:Work Title:)
let $workTitlePath := $individual/vra:work/vra:titleSet/vra:title/text()

let $workTitle :=
    if (fn:empty($workTitlePath))
    then ("")
    else if ((count($workTitlePath)) > 1)
    then (fn:string-join(($workTitlePath), $value_delimiter))
    else ($workTitlePath)
    
(:Work Date -- Creation and Publication earliestDate, individually labelled :)
let $datePathC := $individual/vra:work/vra:dateSet/vra:date[@type="creation"]/vra:earliestDate/text()

let $dateC :=
    if (fn:empty($datePathC))
    then ("")
    else if ((count($datePathC)) > 1)
    then (fn:string-join(concat("Creation: ", $datePathC), $value_delimiter))
    else (concat("Creation: ", $datePathC))
    
let $datePathP := $individual/vra:work/vra:dateSet/vra:date[@type="publication"]/vra:earliestDate/text()

let $dateP :=
    if (fn:empty($datePathP))
    then ("")
    else if ((count($datePathP)) > 1)
    then (fn:string-join(concat("Publication: ", $datePathP), $value_delimiter))
    else (concat("Publication: ", $datePathP))
    
let $date :=
    if (functx:all-whitespace($dateC) and functx:all-whitespace($dateP))
    then ("")
    else if (functx:all-whitespace($dateC) and not(functx:all-whitespace($dateP)))
    then ($dateP)
    else if (not(functx:all-whitespace($dateC)) and functx:all-whitespace($dateP))
    then ($dateC)
    else (fn:string-join(($dateC, $dateP), $value_delimiter))
    
(:WorkAgents -- CONTRIBUTORS:)
let $workAgentsPath := $individual/vra:work/vra:agentSet/vra:agent/vra:name/text()

let $workAgents :=
    if (fn:empty($workAgentsPath))
    then ("")
    else if ((count($workAgentsPath)) > 1)
    then (fn:string-join(($workAgentsPath), $value_delimiter))
    else ($workAgentsPath)

(:WorkType -- FORMAT:)
let $workTypePath := $individual/vra:work/vra:worktypeSet/vra:worktype/text()

let $workType :=
    if (fn:empty($workTypePath))
    then ("")
    else if ((count($workTypePath)) > 1)
    then (fn:string-join(($workTypePath), $value_delimiter))
    else ($workTypePath)
    
(: Subject! :)
let $subjectPath := $individual//vra:work//vra:subject/vra:term/text()

let $subject :=
    if (fn:empty($subjectPath))
    then ("")
    else if ((count($subjectPath)) > 1)
    then (fn:string-join(($subjectPath), $value_delimiter))
    else ($subjectPath)
    
(:Work Description -- Line breaks replaced with --:)
let $workDescriptionPath := for $each in $individual/vra:work/vra:descriptionSet//vra:description/text()
return replace($each, "&#10;", " -- ")

let $workDescription :=
    if (fn:empty($workDescriptionPath))
    then ("")
    else if ((count($workDescriptionPath)) > 1)
    then (fn:string-join(($workDescriptionPath), $value_delimiter))
    else ($workDescriptionPath)
    
(:Work Source:)
let $sourcePath := $individual//vra:work//vra:location/vra:refid/text()

let $source :=
    if (fn:empty($sourcePath))
    then ("")
    else if ((count($sourcePath)) > 1)
    then (fn:string-join(($sourcePath), $value_delimiter))
    else ($sourcePath)
       
    
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
    then (fn:string-join(($imageTitlePath), $value_delimiter))
    else ($imageTitlePath)
    
    
(:File Name and  Path (Image Location REFID):)
let $fileNamePath := $individual/vra:image/vra:locationSet/vra:location/vra:refid/text()

let $fileName :=
    if (fn:empty($fileNamePath))
    then ("")
    else if ((count($fileNamePath)) > 1)
    then (fn:string-join(($fileNamePath), $value_delimiter))
    else ($fileNamePath)

let $filePath :=
    if (fn:empty($fileNamePath))
    then ("")
    else if ((count($fileNamePath)) > 1)
    then (fn:string-join(for $file in $fileNamePath return (string-join(($imageShare, $file), "")), $value_delimiter))
    else (fn:string-join(($imageShare, $fileNamePath), ""))


(:Image Rights:)
let $imageRightsPath := for $each in $individual//vra:image/vra:rightsSet/vra:rights/vra:text/text()
return replace(functx:capitalize-first($each), "&#10;", " -- ")

let $imageRights :=
    if (fn:empty($imageRightsPath))
    then ("")
    else ($imageRightsPath[1])


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
    else concat($category, $value_delimiter, $subcategory)
let $tags := functx:replace-multi(concat($tags, $value_delimiter, "2015 Exhibits"), ("-", "Satellite "), (" ", ""))

(: let $line := fn:string-join((fn:base-uri($individual),$workTitle, $date, $workType, $workAgents, $subject, $workDescription, $source, $imageRights, $filePath, $fileName, $tags), $field_delimiter) :)
let $line := fn:string-join((fn:base-uri($individual), $workTitle, $date, $workType, $workAgents, $subject, $workDescription, $source, $imageRights, $filePath, $tags), $field_delimiter)

return
 $line)

