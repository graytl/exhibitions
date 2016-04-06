xquery version "3.1";

declare namespace vra = "http://www.vraweb.org/vracore4.htm";

(: Update rights statements in VRA documents :)

for $doc in fn:collection("metadata")
let $rights := $doc//vra:image/vra:rightsSet/vra:rights/vra:text/text()
where $rights = "Copyright; use considered fair according to the ACRL Code of Best Practices in Fair Use"
for $right in $rights
let $new-right := "Copyright; use considered fair according to the ARL Code of Best Practices in Fair Use"
return replace node $right with $new-right