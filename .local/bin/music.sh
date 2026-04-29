#!/usr/bin/env bash


# exit on error, undefined variables etc
set -euo pipefail

usage() {
    cat << EOF
Usage: $0 [URL]
Description:
    Script that downloads music and organises it based on artist/album/music_title
OPTIONS:
    -h, --help          Show this help message
Examples:
	"https://youtube.com/watch?v=..."
	"https://youtu.be/..."
Notes:
    - Import process is interactive (you'll be prompted to select matches): select a match if found, otherwise select u
EOF
}

log_info() {
    echo "[INFO] $*"
}
log_error() {
    echo "[ERROR] $*" >&2
}

die() { echo "$*" 1>&2 ; exit 1; }

# Call usage if no arguments or -h flag
if [[ $# -eq 0 ]] || [[ "$1" == "-h" ]] || [[ "$1" == "--help" ]]; then
    usage
    exit 0
fi

# check if valid url given
[[ "$1" =~ ^https?:// ]] || die "Invalid URL format: $1"


# Check dependencies
log_info "Checking dependencies..."
for cmd in beet yt-dlp yq; do
    command -v "$cmd" &>/dev/null || die "Required command not found: $cmd"
done

die_no_config() {
    cat >&2 << 'EOF'
[ERROR] Failed to read beets config.
Solution: Create a beets configuration file at: ~/.config/beets/config.yaml
Minimal configuration example:
---
disabled_plugins: []

# !!! Set here the directory name for the music installation
directory: <directory_name>

# NOTE: you can add plugins here for more accurate predictions
plugins: fromfilename

musicbrainz:
    searchlimit: 10
    search_limit: 10
    data_source_mismatch_penalty: 0.5
    host: musicbrainz.org
    https: no
    ratelimit: 1
    ratelimit_interval: 1
    genres: no
    external_ids:
        discogs: no
        bandcamp: no
        spotify: no
        deezer: no
        tidal: no
    extra_tags: []

---
To create this file, run:
    mkdir -p ~/.config/beets
    $EDITOR ~/.config/beets/config.yaml
EOF
    exit 1
}

# find the beet config directory
music_directory=$(beet config | yq -r '.directory') || die_no_config
[[ -z "$music_directory" ]] && die "Could not determine music directory from beets config"

# create the downloads directory for raw downloads
downloads_dir=${music_directory}/downloads
mkdir -p ${downloads_dir} || die "Failed to create downloads directory"

yt-dlp -x --audio-format mp3 --embed-thumbnail --add-metadata -o "${downloads_dir}/%(title)s.%(ext)s" "$1"

# if import ok, remove the elements from the downloads_dir
if beet import "${downloads_dir}"; then
    log_info "Import successful!"
    log_info "Cleaning up downloads directory..."
    rm -rf "${downloads_dir}/"
else
    log_error "Import failed or was canceled."
    log_error "Downloaded files preserved in: ${downloads_dir}"
    exit 1
fi

