xquery version "3.0";
 
declare namespace vra="http://www.vraweb.org/vracore4.htm";
 
let $records := fn:collection("Metadata")
<<<<<<< HEAD

for $each in $records//@refid 

return 

=======
 
for $each in $records//@refid 
 
return 
 
>>>>>>> origin/EJW_April2015
replace value of node $each with fn:normalize-space($each)