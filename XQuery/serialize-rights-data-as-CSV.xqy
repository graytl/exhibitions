xquery version "3.1";

declare namespace vra = "http://www.vraweb.org/vracore4.htm";

(: Serializes the rights metadata for images in the VRA records as CSV :)

declare function local:build-records($collection as xs:string) as element(record)*
 {
  for $doc in fn:collection($collection)
  let $id := fn:base-uri($doc)
  for $image in $doc//vra:image
  let $name := $image//vra:refid/text()
  let $rights := fn:data($image//vra:rights/@type)
  let $display := $image//vra:rights/vra:text/text()
  return
   element record {
     element id {$id},
     element name {$name},
     element rights {$rights},
     element display {$display}
   }
};

let $xml := element csv {local:build-records("exhibits")}
let $csv := csv:serialize($xml, map { 'header': true() })
return file:write("Desktop/rights.csv", $csv)