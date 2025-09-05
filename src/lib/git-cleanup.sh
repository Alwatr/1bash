# git-cleanup - Cleans up Git repositories by running garbage collection,
#               pruning remote-tracking branches, and removing .yarn directories.
git-cleanup() {

  START_DIR="$(pwd)"

  echo "Starting Git cleanup process in directory: ${START_DIR}"
  echo "Searching for Git repositories..."

  # Find all .git directories recursively, excluding those within other .git directories
  # Use -print0 and read -d $'\0' for safe handling of filenames with special characters
  # Use a subshell (...) to isolate 'cd' commands within the loop,
  # ensuring the find command's context isn't affected.
  find "${START_DIR}" -name ".git" -type d -prune -print0 | while IFS= read -r -d $'\0' git_dir; do
    # Get the parent directory (the root of the Git repository)
    repo_dir=$(dirname "$git_dir")

    # Process each repository in a subshell to isolate directory changes
    (
      echoStep "Processing repository: ${repo_dir}"

      # Change directory to the repository root
      if ! cd "${repo_dir}"; then
        echoWarn "Could not change directory to ${repo_dir}. Skipping."
        exit 1 # Exit subshell for this repo
      fi

      du -hd0 .git

      echo "Running 'git remote prune origin'..."
      if git remote prune origin; then
        echo "Pruned stale remote-tracking branches for 'origin' in ${repo_dir}."
      else
        # This might fail if the remote 'origin' doesn't exist, which is okay.
        echoWarn "Could not prune remote 'origin' in ${repo_dir}."
      fi

      echo "Running 'git gc --prune=now --aggressive'..."

      if git gc --prune=now --aggressive; then
        echo "Git garbage collection successful in ${repo_dir}."
        du -hd0 .git
      else
        echoWarn "Git garbage collection failed in ${repo_dir}."
      fi

      du -hd0 .git

      yarn_dir=".yarn" # Relative path within the repo dir
      if [ -d "${yarn_dir}" ]; then
        echo "Removing '${repo_dir}/${yarn_dir}'..."
        du -hd0 "${yarn_dir}"
        if rm -rf "${yarn_dir}"; then
          echo "Successfully removed ${repo_dir}/${yarn_dir}."
          git restore "${yarn_dir}"
          du -hd0 "${yarn_dir}"
        else
          error "Failed to remove ${repo_dir}/${yarn_dir}."
        fi
      else
        echo "No .yarn directory found in ${repo_dir}."
      fi

      # No need to explicitly cd back; the subshell handles this.
      # When the subshell exits, we are automatically back in the directory
      # where the 'find' command was iterating.

    ) # End of subshell for repository processing

    # Check the exit status of the subshell
    if [ $? -ne 0 ]; then
      echoWarn "Processing failed for repository originally found at ${repo_dir}. Continuing..."
    fi

    echoGap

  done

  cd "${START_DIR}"

  echoDone "Git cleanup process finished."
}