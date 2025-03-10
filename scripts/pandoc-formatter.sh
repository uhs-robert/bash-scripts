#!/bin/bash

INPUT_DIR="$(pwd)"           # Change this to your folder path
OUTPUT_DIR="sanitized_notes" # Folder for cleaned files
mkdir -p "$OUTPUT_DIR"

# Month conversion (3-letter to number)
declare -A month_map=(["Jan"]="01" ["Feb"]="02" ["Mar"]="03" ["Apr"]="04" ["May"]="05" ["Jun"]="06"
  ["Jul"]="07" ["Aug"]="08" ["Sep"]="09" ["Oct"]="10" ["Nov"]="11" ["Dec"]="12")

for file in "$INPUT_DIR"/*.md; do

  filename=$(basename -- "$file" .md)

  # Extract "Sep 24, 2024" format from filename
  date_part=$(echo "$filename" | grep -oE '^[A-Za-z]{3} [0-9]{1,2}, [0-9]{4}')

  if [[ -z "$date_part" ]]; then
    echo "⚠️ No date found in $filename, skipping..."
    continue
  fi

  # Convert "Sep 24, 2024" -> "2024-09-24"
  month_str=$(echo "$date_part" | awk '{print $1}')
  day=$(echo "$date_part" | awk '{print $2}' | tr -d ',')
  year=$(echo "$date_part" | awk '{print $3}')
  month="${month_map[$month_str]}"
  created_date="$year-$month-$day"
  formatted_date="${year}${month}$(printf "%02d" "$day")00"
  new_filename="${formatted_date}.md"

  # Default company (Change this logic if needed)
  company="[[Civil Communicator]]"

  # Generate the YAML frontmatter
  {
    echo "---"
    echo "file_name: \"$new_filename\""
    echo "created: $created_date"
    echo "modified: $(date --iso-8601=seconds)"
    echo "year: $year"
    echo "month: $((10#$month))" # Remove leading zero
    echo "company: \"$company\""
    echo "tags:"
    echo "  - meeting"
    echo "---"
    echo ""
    echo "# $date_part | [UpHill Solutions / Civil Communicator - Meeting Notes]()"
    echo "- Attendees: [Robert Hill](mailto:robert.hill@uphillsolutions.tech), [Leslie Breisch](mailto:lbreisch@data-engineering.com)"
    echo ""
    echo "## :LiChartLine: Progress Updates"
    echo "---"
    cat <<EOF
### :LiBadgeCheck: Completed
\`\`\`tasks
done
(path includes Work/Projects) OR (path includes Work/Meetings)
filter by function task.file.property('company').includes(query.file.property('company'))
(done on or after $created_date) AND (done on or before $(date -d "$created_date -1 days" '+%Y-%m-%d'))
group by function task.status.name
sort by due ascending
\`\`\`
### :LiClock: In Progress
\`\`\`tasks
not done
(path includes Work/Projects) OR (path includes Work/Meetings)
filter by function task.file.property('company').includes(query.file.property('company'))
(created on or after $created_date) AND (created on or before $(date -d "$created_date -1 days" '+%Y-%m-%d'))
status.type is IN_PROGRESS
group by function task.status.name
sort by due ascending
\`\`\`
### :LiHourglass: Pending
\`\`\`tasks
not done
(path includes Work/Projects) OR (path includes Work/Meetings)
filter by function task.file.property('company').includes(query.file.property('company'))
(created on or after $created_date) AND (created on or before $(date -d "$created_date -1 days" '+%Y-%m-%d'))
status.type is TODO
group by function task.status.name
sort by due ascending
\`\`\`
EOF
    echo ""
    echo "## :LiDatabase: Projects"
    echo "---"
    cat <<EOF
\`\`\`dataview
TABLE without id 
link(file.link, file_name) AS "Project", created as "Created", due_date as "Due", tags as "Tags" 
FROM "Work/Projects"
WHERE contains(company, this.company)
\`\`\`
EOF
  } >"$OUTPUT_DIR/$new_filename"

  # Ensure Notes and Action Items sections exist before appending content
  {
    echo ""
    echo "## 🗒 Notes"
    echo "---"
  } >>"$OUTPUT_DIR/$new_filename"

  in_notes_section=false
  in_action_items_section=false

  while IFS= read -r line; do
    # Detect Sections (Handles "Notes" and "Action Items" without `##`)
    if [[ "$line" =~ ^[[:space:]]*Notes[[:space:]]*$ ]]; then
      echo "" >>"$OUTPUT_DIR/$new_filename"
      in_notes_section=true
      in_action_items_section=false
      continue
    elif [[ "$line" =~ ^[[:space:]]*Action\ Items[[:space:]]*$ ]]; then
      echo "" >>"$OUTPUT_DIR/$new_filename"
      echo "## :LiActivity: Action Items" >>"$OUTPUT_DIR/$new_filename"
      echo "---" >>"$OUTPUT_DIR/$new_filename"
      in_notes_section=false
      in_action_items_section=true
      continue
    fi

    # Convert bullets to tasks in Action Items
    if $in_action_items_section; then
      if [[ "$line" =~ ^-\s+~~(.*)~~$ ]]; then
        # Convert strikethrough to completed task (- [x] Task)
        echo "- [x] ${BASH_REMATCH[1]}" >>"$OUTPUT_DIR/$new_filename"
      elif [[ "$line" =~ ^-\s+(.*)$ ]]; then
        # Convert regular bullets to incomplete tasks (- [ ] Task)
        echo "- [ ] ${BASH_REMATCH[1]}" >>"$OUTPUT_DIR/$new_filename"
      else
        echo "$line" >>"$OUTPUT_DIR/$new_filename"
      fi
    elif $in_notes_section; then
      # Append general notes
      echo "$line" >>"$OUTPUT_DIR/$new_filename"
    fi
  done <"$file"

  echo "✅ Processed: $new_filename"
done

echo "✅ All files cleaned and saved in $OUTPUT_DIR"
