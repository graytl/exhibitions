xquery version "3.1";

declare namespace vra = "http://www.vraweb.org/vracore4.htm";

declare function local:build-records($collection as xs:string) as element(record)*
 {
  for $doc in fn:collection($collection)
  let $id := fn:base-uri($doc)
  let $name := $doc//vra:work//vra:titleSet/vra:title/text()
  let $rights := fn:data($doc//vra:work//vra:rightsSet/vra:rights/@type)
  let $display := $doc//vra:work//vra:rightsSet/vra:rights/vra:text/text()
  order by $rights
  where fn:count($rights) = 1 and fn:not(fn:empty($name))
  return
   element record {
     element id {$id},
     element name {$name},
     element rights {$rights},
     element display {$display},
     element rationale {"Fair Use, Licensed, or Public Domain"}
   }
};

let $xml := element csv {local:build-records("exhibits")}
let $csv := csv:serialize($xml, map { 'header': true() })
return file:write("Desktop/rights.csv", $csv)