#!/bin/bash

# A simple script to run an R script, and email a success or failure, then optionally shutdown the machine


#run the script and create a file called success if it succeeds. 
#If there is any error, the file will not be created, and the email will have subject "Failed"
Rscript script.R && touch "success"


# Email completion with a success or fail

if test -f "success"
then
    # R script succeeded
    mail -s "Success" < /dev/null "your_email_here@example.com"
else
    # R script failed
    mail -s "Failed" < /dev/null "your_email_here@example.com"
fi

# Uncomment if you want to shutdown on completion
# sudo shutdown -h now