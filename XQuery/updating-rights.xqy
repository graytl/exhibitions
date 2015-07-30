xquery version "3.1";

declare namespace vra = "http://www.vraweb.org/vracore4.htm";

(: Updates rights metadata according to information :)
(: from a separate document with rights information :)

let $db := "Metadata" (: substitute the name of your local database :)
for $doc in fn:collection($db)
for $record in fn:collection($db)//record
let $id := fn:replace($record/id/text(), "database", $db)
let $rationale :=
    if ($record/rationale/text() = "Fair Use") then
        "Copyright; use considered fair according to the ARL Code of Best Practices in Fair Use"
    else
    if ($record/rationale/text() = "Public Domain") then
        "Public Domain"
    else
    if ($record/rationale/text() = "Licensed") then
        "Copyright; licensed to Vanderbilt University"
    else
        "unknown" (: i.e. requires additional analysis :)
where fn:base-uri($doc) = $id
for $node in $doc//vra:image/vra:rightsSet/vra:rights/vra:text/text()
return
    replace value of node $node
        with $rationale