#include <haskell2c.h>
#include "cLowBinary.h"

void hs_copyBinAux (BinHandle sbh,BinHandle dbh,int bytes)
{ 
   closecache(sbh);
   closecache(dbh);
   if (sbh->file) {
     lseek(sbh->loc.fd,0,SEEK_SET);
     if (dbh->file) {
       /*FILE->FILE*/
       char buf[BUFSIZ];
       lseek(dbh->loc.fd,0,SEEK_SET);
       while (bytes>BUFSIZ) {
         read(sbh->loc.fd,buf,BUFSIZ);
         write(dbh->loc.fd,buf,BUFSIZ);
         bytes -= BUFSIZ;
       }
       if (bytes) {
         read(sbh->loc.fd,buf,bytes);
         write(dbh->loc.fd,buf,bytes);
       }
     } else {
       /*FILE->MEM*/
       memcheck(dbh,bytes);
       read(sbh->loc.fd, (void*)(stableRef(dbh->loc.sp)+1+EXTRA), bytes);
       /*fprintf(stderr,"copyBin: %d bytes from file to mem at 0x%x\n", bytes,
                       (void*)(stableRef(dbh->loc.sp)+1+EXTRA));*/
       dbh->adjust.here = bytes;
     }
   } else {
     if (dbh->file) {
       /*MEM->FILE*/
       lseek(dbh->loc.fd,0,SEEK_SET);
       write(dbh->loc.fd, (void*)(stableRef(sbh->loc.sp)+1+EXTRA), bytes);
       /*fprintf(stderr,"copyBin: %d bytes from mem at 0x%x to file\n", bytes,
             (void*)(stableRef(sbh->loc.sp)+1+EXTRA));*/
     } else {
       /*MEM->MEM*/
       memcheck(dbh,bytes);
       memcpy((void*)(stableRef(dbh->loc.sp)+1+EXTRA),
              (void*)(stableRef(sbh->loc.sp)+1+EXTRA), bytes);
       dbh->adjust.here = bytes;
     }
     sbh->adjust.here = bytes;
   }
   dbh->highwater = sbh->highwater;
   opencache(sbh);
   opencache(dbh);
   /* POSTCONDITION: current pointer at *end* in both source and destination */
  return;
}
