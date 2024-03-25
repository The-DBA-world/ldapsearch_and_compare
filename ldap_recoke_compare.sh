#!/bin/bash

# Change directory to /u01/app/revoke
cd /u01/app/revoke

# List all files without .log extension and save the output in output_ls.out file
ls | grep -v '.log$' > output_ls.out

# Read the ldap_dbaas_entries.input file line by line
while IFS= read -r line
do
    # Extract the first word after 'UBS_' and before the next '_'
    first_word=$(echo $line | awk -F 'UBS_' '{print $2}' | awk -F'_' '{print $1}')
    
    # Extract the word after the second '_' and before the next ','
    second_word=$(echo $line | awk -F '_' '{print $3}' | awk -F',' '{print $1}')
    
    # Extract the word after '|cn=' and before the next ','
    t_word=$(echo $line | sed -n -e 's/^.*|cn=//p' | sed -n -e 's/,.*//p')
    
    # Print the extracted words separated by TAB and append them to ldap_dbaas_entries.out file
    echo -e "$first_word\t$second_word\t$t_word" >> ldap_dbaas_entries.out
done < ldap_dbaas_entries.input
