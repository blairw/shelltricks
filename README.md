# shelltricks

This is just my notebook of useful tricks for the UNIX/Linux shell.

* [shelltricks](#shelltricks)
   * [(1) Documents and Multimedia](#1-documents-and-multimedia)
      * [Convert DOCX to PDF](#convert-docx-to-pdf)
      * [Remove the first 15 minutes of a video file](#remove-the-first-15-minutes-of-a-video-file)
      * [Merge audio and video streams](#merge-audio-and-video-streams)
   * [(2) System Admin](#2-system-admin)
      * [List of folders by size](#list-of-folders-by-size)
      * [Use rsync with specific SSH port](#use-rsync-with-specific-ssh-port)
      * [Find details for currently-running process](#find-details-for-currently-running-process)
   * [(3) Specific to macOS](#3-specific-to-macos)
      * [Copy the current directory](#copy-the-current-directory)
      * [Remove all the .DS_Store](#remove-all-the-ds_store)

Created by [gh-md-toc](https://github.com/ekalinin/github-markdown-toc)

------

## (1) Documents and Multimedia

### Convert DOCX to PDF

The use of `soffice` requires LibreOffice, but then this should work:

```bash
soffice --headless --convert-to pdf:writer_pdf_Export "Blair Wang PhD Thesis rev03.docx"
```

### Remove the first 15 minutes of a video file

```bash
ffmpeg -ss 00:15:00.000 \
	-i /Users/blair/Desktop/oneheartsunday200503_original.mp4 \
	-to 01:14:50.000 \
	-c copy ~/Desktop/oneheartsunday200503_shaved.mp4
```

### Merge audio and video streams

The use of ``ffmpeg`` requires one to install it first (e.g., on Mac, ``brew install ffmpeg``), but then this should work:

```bash
ffmpeg -i video_only.mp4 -i audio_only.m4a -c:v libx264 -c:a aac output_merged.mp4
```

## (2) System Admin

### List of folders by size

This can either be done in one step:

```bash
du -h -d1 | sort -hr
```

Or in two steps:

```bash
du -h -d1 > du-h-d1.txt
cat du-h-d1.txt | sort -hr
```

The latter is handy on network drives where it may be useful to keep that record of the folder sizes. It's the `du` that takes a long time to run (cataloguing all your files and folders); the `sort` is very quick as it just reads the text output of the `du`.

### Use rsync with specific SSH port

Handy to use in conjunction with SSHelper on Android, e.g.,

```bash
rsync -e 'ssh -p 2222' -av 192.168.1.221:/data/data/com.arachnoid.sshelper/files/home/SDCard/DCIM/Camera/ /Users/blair/Desktop/PhotosFromPhone
```

### Find details for currently-running process

For example, to search for currently-running instances of rclone:

```bash
ps -ef | grep rclone
```

## (3) Specific to macOS

### Copy the current directory

Simply:

```bash
pwd | tr -d '\n' | pbcopy
```

Then you can <kbd>Command</kbd>+<kbd>Shift</kbd>+<kbd>G</kbd> to it in Finder.

### Remove all the .DS_Store

Configuration:

```bash
defaults write com.apple.desktopservices DSDontWriteNetworkStores true
```

Ad hoc removal:

```bash
find . -type f -name '.DS_Store' -exec rm -rfv {} \;
```
