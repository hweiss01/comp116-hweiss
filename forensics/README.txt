Forensics Hayley Weiss and Tyler Lubeck

Image Differences
    First look at size differences, image A is the odd one out
Use ImageMagick’s compare tool to compare and there is a very obvious visual
difference
Use Steghide
Try lots of passwords
try it with no password
SUCCESS
Another image of Norman - “prado.jpg”
It’s Norman all the way down.



SD Card
    1) It has both a FAT16 and an ext file system.
        We used disktype (http://disktype.sourceforge.net/doc/) to check this. It showed the first partition on the system as FAT16.
        fsutils shows the filesystems of all partitions on the disk image.
        Autopsy also shows the filesystem of all partitions on the image when the image is added to the case.
    2) We don’t think there is a phone carrier because it is a raspberry pi, which isn’t a phone. We actually ran the card on a raspberry pi!
    3) Linux kali 3.6.11-cutdown is the operating system. We used uname -a to find out the more particular version. And we knew it was Linux kali because that was shown on the display screen when we booted our Raspberry pi.
    4) Looking through the /home folder, we found these and many more. We also ran the sdcard.dd on a raspberry pi and just searched through the applications. Basically anything that comes with Kali Linux.
        BeEF - Browser Exploitation Framework
        Cisco-torch
        darkstat
        iceweasel - a more secure firefox derivitive
        john
        kismet
        logcheck
        lynis
        nikto
        openvas
        pkcs11
        scalpel
        security
        siege
        stunnel
        wireshark
        aircrack
        armitage
        autopsy
        baksmali
        blindelephant.py
        cowpatty
        creepy****
        ophcrack
        
        
5) Yes, the root password is toor.
6) There are additional system accounts but nothing that you can log in to.
7) There is a software called creepy installed that allows you to stalk people. He has a folder of images of Celine Dion. He has a list of her upcoming tour dates. HE clears his internet history. In his bash-history, he deleted a ton of folders and files. There is a photo of celine waiting to be encrypted by TrueCrypt. He’s seen her in concert! He uses tor, which is a web browser specifically used if you want to remain anonymous. 
8)Yes he did. He deleted a few pictures, new1.jpg, new2.jpg and new3.jpg (all pictures of Celine). He deleted a file called receipt.pdf which turns out to be an email of a receipt from ticketmaster for a Celine concert. He deleted documents, downloads, music, pictures, public, templates and videos from the root directory. He deleted some files to do with his dropbox files. He deleted pretty much his entire home folder, which contains a lot of security applications. 
9) We found a file called .Dropbox.zip that had been deleted and recovered and we are unable to read it, so we think it is encrypted. And when we ran f
    file .Dropbox.zip 
it returned that thi was of type data, not a zip file. INTERESTING! We ran 
truecrack -t .Dropbox.zip -w wordlist -v to try and crack the password, using the built in unix wordlist, but alas it took too long so after 24 hours we stopped it. Then we tried using some buzz words and couldn’t break in.
10) Yes Ming did. We found that there was a deleted file called receipt.pdf, so we ran 
foremost -t pdf -i sdcard.dd to see if we could find this file, thinking it would be a ticketmaster receipt, as we noticed there was a ticketmaster icon when we did an image search. We found an email confirming the ticketmaster order to Ming Chow to see Celine Dion at the Colosseum at Ceasar’s Palace in Las Vegas NEvada on July 28, 2012 at 7:30 pm.
11) Yes, there are peculiar files. 
We found an image of a lady with a gag in her mouth…
When we ran foremost on the pdfs, there were quite a few that were reported as “damaged” and thus we couldn’t view them. That’s peculiar.
A lot of the files are recorded as having been created in 1970. That’s peculiar.


    12) He’s stalking Celine Dion. We ran foremost on sdcard.dd to get all of the jpegs and when we went through the resulting images we found a lot of images of Celine Dion. And when we searched for pdfs we found a receipt for her concert.

foremost -t jpg -i sdcard.dd
