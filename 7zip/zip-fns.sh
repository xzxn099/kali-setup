
# setup zip function 
encrypt() {
    # Check if an argument was provided
  if [ "$#" -ne 1 ]; then
      echo "Usage: $0 <directory-to-archive>"
      exit 1
  fi

  # Get the directory to archive from the first script argument
  DIRECTORY_TO_ARCHIVE="$1"

  # Extract the folder name from the directory path
  FOLDER_NAME=$(basename "$DIRECTORY_TO_ARCHIVE")

  # Get current date in YYYYMMDD format
  DATE=$(date +%Y%m%d)

  # Name of the archive, including the date
  ARCHIVE_NAME="$FOLDER_NAME.$DATE.7z"

  # Temporary folder for testing the unzip
  TEMP_DIR="uziptest.$DATE"

  # Command to create an encrypted archive
  7z a -p -mhe=on "$ARCHIVE_NAME" "$DIRECTORY_TO_ARCHIVE"

  # Check if the archive was created successfully
  if [ $? -eq 0 ]; then
      echo "Archive $ARCHIVE_NAME created successfully."
      # Create temporary directory for unzipping
      mkdir "$TEMP_DIR"
      # Unzip the archive to the temporary directory
      7z x "$ARCHIVE_NAME" -o"$TEMP_DIR"
      if [ $? -eq 0 ]; then
          echo "Unzip test passed: Archive contents are verified."
      else
          echo "Unzip test failed: Error in unpacking the archive."
      fi
      # Remove the temporary directory and its contents
      rm -rf "$TEMP_DIR"
  else
      echo "Failed to create archive."
  fi
}

decrypt() {
  # Check if an argument was provided
  if [ "$#" -ne 1 ]; then
      echo "Usage: $0 <path-to-archive>"
      exit 1
  fi

  # Path to the archive
  ARCHIVE_PATH="$1"

  # Extract the directory where the archive is located
  ARCHIVE_DIR=$(dirname "$ARCHIVE_PATH")

  # Extract the base name of the archive without the extension
  ARCHIVE_BASENAME=$(basename "$ARCHIVE_PATH" .7z)

  # Full path for the directory to extract to
  EXTRACT_PATH="$ARCHIVE_DIR/$ARCHIVE_BASENAME"

  # Command to unzip the archive, assuming it's a .7z file
  7z x "$ARCHIVE_PATH" -o"$EXTRACT_PATH"

  # Check if the unzipping was successful
  if [ $? -eq 0 ]; then
      echo "Archive extracted successfully to $EXTRACT_PATH"
  else
      echo "Failed to extract archive."
  fi
}

