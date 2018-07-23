# KhanAcademyBG_scripts
Scripts for improving process at Khan Academy BG

## Video Length Calculator

0. Extract urls for videos from sheet (TL;DR: this can happen with a text editor like Visual Studio Code, Atom, Emacs etc); a useful way to select all urls is by using a regular expression (`href="(.*?)"` works in our case)

    In our process, we have the links copied from the Khan Academy portal to a Google Sheet.

    Because saving the sheet as a .csv file drops the url values of the links, a workaround would be to:
    1. download the file as Web page
    2. unzip the files
    3. open the .html file containing the links in a text editor (like Visual Studio Code, Atom, Emacs etc) that supports looking by regular expression

    After we have opened the file, we can look for all links by using a regular expression (I am using `href="(.*?)"` which works for our case), mass-select them, and paste them in the links.txt file.

1. Copy urls to videos from Khan Academy portal (example in the links.txt file)

2. Run `ruby video_length_calculator.rb`

#### Disclaimers
Script is at v.0.0.1. It works, but its code still needs to be optimized. In the next version I will address the manual extraction of urls by regular expression.
