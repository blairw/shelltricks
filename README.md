# shelltricks

This is just my notebook of useful tricks for the UNIX/Linux command line shell / terminal.

## (1) Documents and Multimedia

### Convert HEIC to JPEG

```bash
sudo apt install libheif-examples
heif-convert -q 60 IMG_1234.HEIC IMG_1234.jpeg
```

### Add 2px border

```
convert -border 2x2 -bordercolor '#999999' example.png example_border.png
```

From https://github.com/arp242/border/

### Convert DOCX to PDF

The use of `soffice` requires LibreOffice, but then this should work:

```bash
soffice --headless --convert-to pdf:writer_pdf_Export "Blair Wang PhD Thesis rev03.docx"
```

If you need to catch multiple files, sometimes you cannot put the wildcard in that end part there, try this instead:

```bash
find . -type f -name "*.doc" -exec soffice --headless --convert-to pdf:writer_pdf_Export {} \;
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

### Mass unzip zip files each into their own folder/directory

```bash
for file in *.zip; do unzip "$file" -d "${file%.zip}"; done
```

Credits to Jeff Fisher and Peter Flynn: https://stackoverflow.com/a/49856874


### List all files (including hidden files) in current directory

```bash
# bash/zsh (Mac/Linux)
ls -lah

# Windows Powershell
gci -fo
```

### Copy the current directory

```bash
# Mac
pwd | tr -d '\n' | pbcopy

# Linux
pwd | tr -d '\n' | xclip -selection clipboard

# Windows
$pwd.Path | Set-Clipboard
```

### Find all files smaller than 16KB

```zsh
find . -type f -size -16k
```

More info: https://superuser.com/a/204571


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


### Remove all the .DS_Store

Configuration:

```bash
defaults write com.apple.desktopservices DSDontWriteNetworkStores true
```

Ad hoc removal:

```bash
find . -type f -name '.DS_Store' -exec rm -rfv {} \;
```
