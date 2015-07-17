#Using XQuery with Exhibitions Metadata

##Mappings
* [VRA <-> Firesign](https://github.com/HeardLibrary/exhibitions/blob/master/XQuery/Crosswalk_Firesign_VRA.md) (proprietary schema)
* [VRA <-> Omeka](https://github.com/HeardLibrary/exhibitions/blob/master/XQuery/Crosswalk_DC_VRA_OMEKA_EXHIBITS.md) (Dublin Core)

##HowTo (from Ed)
*These instructions assume you might be editing the XML data within BaseX.*

#####Github
* Fork, clone and create a working branch of the exhibitions repository at [https://github.com/HeardLibrary/exhibitions](https://github.com/HeardLibrary/exhibitions).

#####BaseX
* Create New database in BaseX from the Metadata directory at [GitHubRepos]/exhibitions/Metadata.
* Query the data.
* Push changes back to repository by exporting the DB to the Metadata directory at [GitHubRepos]/exhibitions/Metadata.

#####Github
* Commit changes to working branch


## HowTo (from Jodie)
*These instruction are geared more toward loading the XML data for saving into a spreadsheet format for separate review. This assumes no editing of the XML data is taking place in BaseX.*

*This series of steps must be redone before beginning work each time to catch any changes that might have been made to any of the XML files in Github.*

1. Pull from Github.
   * Open your Github client of choice, navigate to the exhibitions repo, and pull to get any new changes. *If there are no new changes and you have set up the BaseX database before, you can stop here. If there are changes, or if this is the first time you are setting up the BaseX database, proceed to Step 2.*

2. Load into BaseX and execute XQuery script to create the CSV/TXT file.
   * Open BaseX.
   * If you have loaded the BaseX database previously, go to **Database > Open &amp; Manage...**. Make make sure your Metadata database is highlighted in the list, and click the **Drop...** button. Click **Yes** to confirm.
   * Go to **Database > New...** to create a new database with the exhibits data. In the dialog box that comes up, keep all default options, but make sure the **Input file or directory** path is set to wherever you have the exhibitions repo cloned onto your local machine from Github. Click **OK** to create the database.
   * Go to **Editor > Open...** and navigate to the appropriate XQuery file.
   * Click the green arrow icon in the Editor pane to execute the XQuery script.
   * In the Results pane, you will see a tab-delimited set of data. Click on the Save (disk) icon and give the file a name. I use **.txt** for the file extension, since the file is tab-delimited.

3. Load into Excel to create spreadsheet (plus additional steps to preserve diacritics).
   * Open the TXT/CSV file (resulting from the XQuery script) in an advanced text editor (Notepad++, Sublime Text, or similar).
   * Save the file with encoding **UTF-8 with BOM**.
   * Open the file in Excel. Make sure the Text Import Wizard pops up; sometimes it does not. In the Wizard, you can leave everything as defulat except for Step 2, Text Qualifier: change to **{none}**.
   * Use the Save As option (*not* Save) to save the file as **xlsx**. If you simply hit Save, the diacritics will be lost.
   * Use the xlsx file to your heart's content. **Make any changes to the spreadsheet content in the original XML files.**


