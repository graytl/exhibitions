xquery version "3.0";
 
declare namespace vra="http://www.vraweb.org/vracore4.htm";

let $records := fn:collection("Metadata")/vra:vra

return fn:distinct-values($records//vra:image/vra:rightsSet/vra:rights/vra:text/text())