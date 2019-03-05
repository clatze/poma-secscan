# poma-secscan
a poor man's security scan

# Requirements
* python3
* geckodriver from https://github.com/mozilla/geckodriver/releases
* python3-selenium


# Config File

You can write a config file called poma.config which must be placed in
the same directory as poma.sh. Currently there is only one option to
be set in there:

* geckodriver=/full/path/to/geckodriver/incl/binary (default: in the same directory as poma.sh)

If there is no config file, the script will fall back to defaults