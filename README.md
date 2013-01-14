# GistDrop

OS X application for developer-friendly file/text/screenshots sharing

## Usage

### Settings & accounts

On first launch application will ask to login into [Gist](https://gist.github.com/) account. Later these settings are available in preferences window.

Also you can edit or add snippets for sharing. Default snippets are:

 * Text:
   * Markdown link to gist - `[$NAME]($LINK)`
   * HTML link to gist - `<a href="$LINK">$NAME</a>`
   * Raw link - `$RAW_LINK`
   * Octopress gist tag - `{% gist $GIST_ID %}`
 * Image
   * Markdown link to image - `![$NAME]($RAW_LINK)`
   * HTML link to image - `<img src="$RAW_LINK" alt="$NAME">`
   * Raw link - `$RAW_LINK`
   * Octopress image tag - `{% img $RAW_LINK $NAME %}`
 * Other file
   * Markdown link to file - `[$NAME]($RAW_LINK)`
   * HTML link to file - `<a href="$RAW_LINK">$NAME</a>`
   * Raw link - `$RAW_LINK`

   
Difference between `$RAW_LINK` and `$LINK` is that `$RAW_LINK` points directly to file, and `$LINK` points to gist containing this file.

### Sharing

You can share file just by drag-n-dropping it to GistDrop's dock icon. Also screen capturing options are available from dock icons's menu. Also text services are provided for sharing of selected text. There is system-wide hotkeys.

Before file upload window pops up, you can enter the name of gist or leave it blank. Optionaly you can specify filetype if GistDrop got it wrong. After upload you can choose a snippet to copy into buffer.


#### Service

You can send selected text to Gist from any application with `cmd+shift+"`