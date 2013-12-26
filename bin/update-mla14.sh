#!/bin/bash

# update-mla14.sh
# ---------------------
# Chris Zarate, 2013-10

# EXPECTS $scripts_dir to be defined by your environment.


###############################
### BEGIN REUSABLE PROLOGUE ###
###############################


## Usage

  usage_text="[OPTIONS] -i [INPUT_DIRECTORY]

  This script looks for updated Program XML in the input directory. If files
  differ from the previous version, it outputs new HTML files and uploads them
  to staging.mla14.org.

  OPTIONS:
    -i dir    Input directory (required)
    -n email  E-mail address for notification
    -s        Enable logging (no console output)
    -h        Show this message
"


## Command-line options

  flags=i:n:sh

  options () {
    case $opt in
      i) resources_dir="$OPTARG";;
      n) notify_email="$OPTARG";;
      s) enable_log="y";;
      h) usage;;
      :) usage;;
      *) usage;;
    esac
  }

  # Required options
  required_options="resources_dir"


## Configuration

  # Get current directory
  current_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

  # Project directory
  project_dir="$current_dir/.."

  # Archive directory
  archive_dir="$project_dir/xml/archive"

  # XML directory
  xml_dir="$project_dir/xml"

  # XSL directory
  xsl_dir="$project_dir/xsl"

  # Grunt directory
  grunt_dir="$project_dir/app"

  # Data directory
  json_dir="$grunt_dir/data"

  # Resources (space-separated)
  resources="conv_prog_participant.xml conv_part_prog.xml"

  # Requirements
  require_dirs="archive_dir xml_dir xsl_dir grunt_dir json_dir"


## Bash

  # Source the Bash helper script
  source $scripts_dir/Tools/bash-helper.sh

  # Source the Bash functions script
  source $scripts_dir/Tools/bash-functions.sh


## Safety

  # Exit if bash helper has not been loaded
  if [[ -z "$tools_dir" ]]; then
    echo "Could not connect to $scripts_dir."
    exit
  fi


#############################
### END REUSABLE PROLOGUE ###
#############################


## Program

# Compare INCOMING XML with PREVIOUS XML
if `diff -q "$resource1" "$archive_dir/program_latest.xml" >/dev/null`; then
	echo "The program XML has not been updated."
else

	echo "UPDATED program XML has been detected!"
	updated_files=YES

	# Keep a copy of the updated XML.
	cp $resource1 "$archive_dir/program_latest.xml"

	# Transform Oracle output.
	transform_saxon8 "$resource1" "$xsl_dir/program.xsl" "xml-dir=${xml_dir} json-dir=${json_dir}"

fi


## People

# Compare INCOMING XML with PREVIOUS XML
if `diff -q "$resource2" "$archive_dir/people_latest.xml" >/dev/null`; then
	echo "The participant XML has not been updated."
else

	echo "UPDATED participant XML has been detected!"
	updated_files=YES

	# Keep a copy of the updated XML.
	cp $resource2 "$archive_dir/people_latest.xml"

	# Transform Oracle output.
	transform_saxon8 "$resource2" "$xsl_dir/people.xsl" "xml-dir=${xml_dir} json-dir=${json_dir}"

fi


## Grunt

if [ -n "$updated_files" ]; then

  # Commit updated XML and JSON.
  cd "$xml_dir" && git commit *.xml -m "Updated program XML (${current_date}_${current_time})."
  cd "$json_dir" && git commit *.json -m "Updated program JSON (${current_date}_${current_time})."

	# Deploy to staging.
	cd "$grunt_dir" && grunt deploy

  # Notify
  if [ -n "$notify_email" ]; then
    echo "New files were successfully copied to the staging site. Time stamp: ${current_date}_${current_time}." | mail -s "MLA Program updated" $notify_email
  fi

fi
