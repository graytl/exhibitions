## Firesign to VRA Core mapping + HowTo

This mapping is intended to aid in the process of copying/pasting VRA Core data into Firesign for the 2015 exhibits.

Example metadata in the table below comes from \Metadata\1941\The_Holy_Bible-1613.xml.

| Firesign       | VRA Core                        | Example from VRA XML |
|----------------|---------------------------------|----------------------|
| artist_name                         | work > titleSet > title         | The Holy Bible, Containing the Old testament and the New...Appointed To Be Read in Churches |
| active_dates                        | work > agentSet > agent > name (repeatable)  | Barker, Robert |
| title                               | ---  | |
| release_date                        | work > dateSet > date[@type="publication"] > earliestDate, work > dateSet > date[@type="publication"] > latestDate (if different)   | 1613 |
| format                              | work > worktypeSet > worktype   | Bibles |
| dimensions                          | ---  | 
| donor                               | work > locationSet > location > refid   | Memorabilia Collection/BS185 1613 .L6 |
| location                            | work > locationSet > location[@type="repository"] > name   | Vanderbilt University. Special Collections |
| description                         | work > descriptionSet > description   | Commissioned by King James I in 1604 for the Church of England, this is the third translation of the Christian Bible into English. Robert Barker, the King's Printer, first published the book in 1611; this edition contains printing errors that were eventually eliminated in a later edition of 1613. This folio depicts the offspring of Adam and Eve as a tree form, with text, "As by one man’s disobedience many were made sinners, so by the obedience of one shall many also be made righteous." |
| entry_title **(audio/video only)**  | ---   |  |
| media_type  **(audio/video only)**  | ---   |  |
| length **(audio/video only)**       | ---   |  |
| genre **(audio/video only)**        | ---   |  |
| catalognum **(audio/video only)**   | ---   |  |


#### Questions
* Rights (rightsSet in VRA) and Subjects (subjectSet in VRA) have not been input into Firesign in the past. Will they be now? *No, we will likely continue to keep Firesign simple and not add these fields.*
* Do we need to do any further cleanup on any of the fields to aid in copy/paste?
    - invert agent names to Firstname Lastname (from Lastname, Firstname) -- maybe?
    - ~~names with birth/death dates~~ 
    - ~~dates in different formats~~ 
    - [done 6/25/15 jg] capitalize first word of all Format entries
    - ~~remove call numbers from Donor entries~~ 
    - [done 6/25/15 jg] add Creation Date field and relabel current date field to Publication Date (so that both dates are available to choose from)
    - [done 6/25/15 jg] add Image Filename field
    - [done--none found 6/25/15 jg] check for other VRA fields that might state the manuscript collection/source and add the field(s) if applicable

