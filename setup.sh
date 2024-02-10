#!/bin/bash

# Get the path of the current folder
special_folder="$(pwd)"

# Loop through dot files in the special folder
for file in "$special_folder"/.*; do
    # Extract filename without leading path
    filename=$(basename "$file")
    # Check if the file is a regular file (not . or ..) and starts with a dot
    if [[ -f "$file" && "$filename" != "." && "$filename" != ".." && "$filename" == .* ]]; then
        # Check if the file already exists in the home folder
        if [ -e "$HOME/$filename" ]; then
            # Ask the user if they want to replace the existing file
            read -p "File '$filename' already exists in your home folder. Do you want to replace it? (y/n): " choice
            case "$choice" in
                y|Y )
                    # Replace existing file by creating a symbolic link
                    ln -sf "$special_folder/$filename" "$HOME/$filename"
                    echo "Replaced existing file with $filename"
                    ;;
                * )
                    echo "Skipped $filename"
                    ;;
            esac
        else
            # Create symbolic link in the home folder
            ln -sf "$special_folder/$filename" "$HOME/$filename"
            echo "Created symbolic link for $filename"
        fi
    fi
done
