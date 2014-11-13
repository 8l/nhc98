#include <haskell2c.h>
#include "cLowBinary.h"

int hs_copyBytes (BinHandle sbh,BinHandle dbh,int bytes)
{ unsigned int destptr;
  /* The source bitstream is assumed to be aligned to a */
       /* byte boundary (at both ends) */
   destptr  = (dbh->file ? vtell(dbh) : mtell(dbh));
   if ((destptr+(bytes*8)) > dbh->highwater) dbh->highwater = destptr+(bytes*8);
   closecache(sbh);
   closecache(dbh);
   if (sbh->file) {
     vsync(sbh);
     if (dbh->file) {
       /*FILE->FILE*/
       char buf[BUFSIZ];
       vsync(dbh);
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
       read(sbh->loc.fd,
            (void*)(stableRef(dbh->loc.sp)+1+EXTRA)+dbh->adjust.here, bytes);
       dbh->adjust.here += bytes;
       if (dbh->adjust.here > dbh->attrib.size)
         dbh->attrib.size = dbh->adjust.here;
       /*fprintf(stderr,"directPut: %d bytes from file to mem at 0x%x\n", bytes,
            (void*)(stableRef(dbh->loc.sp)+1+EXTRA)+dbh->adjust.here);*/
     }
   } else {
     if (dbh->file) {
       /*MEM->FILE*/
       vsync(dbh);
       write(dbh->loc.fd,
             (void*)(stableRef(sbh->loc.sp)+1+EXTRA)+sbh->adjust.here, bytes);
       /*fprintf(stderr,"directPut: %d bytes from mem at 0x%x to file\n", bytes,
             (void*)(stableRef(sbh->loc.sp)+1+EXTRA)+sbh->adjust.here);*/
     } else {
       /*MEM->MEM*/
       memcheck(dbh,bytes);
       memcpy((void*)(stableRef(dbh->loc.sp)+1+EXTRA)+dbh->adjust.here,
              (void*)(stableRef(sbh->loc.sp)+1+EXTRA)+sbh->adjust.here, bytes);
       dbh->adjust.here += bytes;
       if (dbh->adjust.here > dbh->attrib.size)
         dbh->attrib.size = dbh->adjust.here;
     }
   }
   opencache(sbh);
   opencache(dbh);
  return destptr;
}
