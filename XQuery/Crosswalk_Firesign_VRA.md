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

#### Steps to load the exhibits XML into BaseX and create the spreadsheet
This must be redone before beginning work each time to catch any changes that might have been made to any of the XML files in Github.

1. Pull from Github.
   * Open your Github client of choice, navigate to the exhibitions repo, and pull to get any new changes. *If there are no new changes and you have set up the BaseX database before, you can stop here. If there are changes, or if this is the first time you are setting up the BaseX database, proceed to Step 2.*

2. Load into BaseX and execute XQuery script to create the CSV/TXT file.
   * Open BaseX.
   * If you have loaded the BaseX database previously, go to **Database > Open &amp; Manage...**. Make make sure your Metadata database is highlighted in the list, and click the **Drop...** button. Click **Yes** to confirm.
   * Go to **Database > New...** to create a new database with the exhibits data. In the dialog box that comes up, keep all default options, but make sure the **Input file or directory** path is set to wherever you have the exhibitions repo cloned onto your local machine from Github. Click **OK** to create the database.
   * Go to **Editor > Open...** and navigate to the needed XQuery file: *[path to exhibitions repo]/XQuery/VRA-CSV-Firesign.xq*.
   * Click the green arrow icon in the Editor pane to execute the XQuery script.
   * In the Results pane, you will see a tab-delimited set of data. Click on the Save (disk) icon and give the file a name. I use **.txt** for the file extension, since the file is tab-delimited, but **.csv** would probably work too.

3. Load into Excel to create spreadsheet (plus additional steps to preserve diacritics).
   * Open the TXT/CSV file (resulting from the XQuery script) in an advanced text editor (Notepad++, Sublime Text, or similar).
   * Save the file with encoding **UTF-8 with BOM**.
   * Open the file in Excel.
   * Use the Save As option (*not* Save) to save the file as **xlsx**. If you simply hit Save, the diacritics will be lost.
   * Use the xlsx file to your heart's content.

#### Questions
* Rights (rightsSet in VRA) and Subjects (subjectSet in VRA) have not been input into Firesign in the past. Will they be now?
* Do we need to do any further cleanup on any of the fields to aid in copy/paste?
    - inverted names
    - names with birth/death dates
    - dates in different formats
    - capitalize all Format entries (first word)
    - remove call numbers from Donor entries

