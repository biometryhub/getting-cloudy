# getting_cloudy
A repo with a simple bash script to run an R script, email a result and shutdown

## Setup
There are a few steps of setup required before running this script:

1. Install mail server
2. Set up mail server
2. Install R + required packages
4. Install `screen` to enable long running processes to continue on SSH disconnect (optional).

### 1. Install mail server packages

Assuming an Ubuntu/Debian based distribution, run the following:

```
sudo apt install ssmtp mailutils
```

### 2. Set up mail server

Once these are installed, you will need to configure the SMTP server to allow sending of mail. The easiest way is to use a gmail account, but due to updated security settings, you will need to have [2FA](https://myaccount.google.com/signinoptions/two-step-verification) enabled, and set up an [app password](https://myaccount.google.com/apppasswords) for the mail server to use.

Then you need to edit `/etc/ssmtp/ssmtp.conf` and add the following lines at the bottom, replacing the parts in `<>` with your values.
```
UseSTARTTLS=YES
FromLineOverride=YES
root=admin@example.com
mailhub=smtp.gmail.com:587
AuthUser=<username>@gmail.com
AuthPass=<your app password here>
```

### 3. Install R and required packages

If R is not already installed (check by running `R` at the bash shell), I recommend installing the latest version available, unless there is a very good reason not to. You can do this by following the instructions on [CRAN](https://cran.r-project.org/bin/linux/ubuntu/README.html).

Once R is installed, run it and install packages in the normal way. Some of them may need additional linux packages installed (e.g. libcurl, libssl, etc), but they will usually give an indication of what's missing during the installation. They can be installed globally (by running R as root - `sudo R`, or locally for a user by just running `R`).

### 4. Install `screen`

Screen is a very useful utility, especially for long running processes. It enables you to start a process running on the shell, then close the shell without killing the process, and pick it up later. Full documentation is available [here](http://www.gnu.org/software/screen/manual/).

```
sudo apt install screen
```

## Running the script

Once all packages are installed, you can run a script on the console (using `screen` in this example), download the script in this repository, and make sure it has execute permissions:

```
chmod +x run_script.sh
```

Then modify the relevant parts within the script and run it like so:

```
screen
```

This will enter a "shell within a shell" of sorts, and you can start your script running there:

```
./run_script.sh
```

Press `Ctrl+a, d` to send `screen` to the background (keep it running, but enable you to disconnect). At any point you can reconnect and bring up the `screen` shell by running `screen -r` on a regular shell of the same machine to check progress. When it finishes, it will email you that it has finished, and optionally shutdown the server.
