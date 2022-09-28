# nhdl
Simple bash script to download doujins from nhentai without an account

## usage
just run 
./nhdl
followed by the id you want to download (the 6 digit number at the end of the url)

example:
./nhdl 123456

your downloads will appear in a folder called "doujins".


NOTE!
this script is designed to convert your downloads automatically into a .PDF file using img2pdf (which needs to be installed).
if you don't want this, just open the script with a text editor and remove everything after "#Converting Images to PDF".
this will cause your images to be in the "images" folder instead of "doujins".
