#!/bin/bash


#------------------------------------------
# Homebrew
#------------------------------------------
mv -f ./Brewfile ./Brewfile.bk
brew bundle dump --file "tmp_Brewfile"

input_file="tmp_Brewfile"
output_file="./Brewfile"

mas_start_flag=false
mas_end_flag=false

while IFS= read -r line; do
  if [[ $line == *"mas "* ]]; then
    if [[ $mas_start_flag == false ]]; then
      echo "if OS.mac?" >> "$output_file"
      echo "  $line" >> "$output_file"
      mas_start_flag=true
    else
      echo "  $line" >> "$output_file"
      mas_end_flag=true
    fi
  else
    if [[ $mas_end_flag == true ]]; then
      echo "end" >> "$output_file"
      echo "$line" >> "$output_file"
      mas_end_flag=false
    else
      echo "$line" >> "$output_file"
    fi
  fi
done < "$input_file"

rm -rf ./tmp_Brewfile
