xquery version "3.0";
 
declare namespace vra="http://www.vraweb.org/vracore4.htm";

let $records := fn:collection("Metadata")/vra:vra
for $each in $records
let $locName := $each/vra:work//vra:location[@type="repository"]/vra:name
let $locRefID := $each/vra:work//vra:locationSet/vra:location/vra:refid

return
string-join(($locName, $locRefID), "|")
