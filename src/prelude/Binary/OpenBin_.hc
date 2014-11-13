#include <haskell2c.h>
#include "cLowBinary.h"
#include <fcntl.h>
#include <stdlib.h>

void * hs_openBin (int f,char* fp,int m)
{ BinHandle bh;
  
   bh = (BinHandle)malloc(sizeof(BinState));       /* assume unfailing */
   bh->mode = m; 
   bh->file = f;
   bh->cptr = 0;
   if (bh->file) {
     switch (bh->mode) {
       case RO:  bh->loc.fd = open(fp,O_RDONLY); break;		/* ditto */
       case WO:  bh->loc.fd = open(fp,(O_WRONLY|O_CREAT|O_TRUNC),0644); break;
       case RW:  bh->loc.fd = open(fp,(O_RDWR|O_CREAT),0644); break;
       default:  exit(1);
     }					/* permissions 0644=-rw-r--r-- */
     bh->attrib.eof  = 0;
     bh->adjust.vptr = 0;
     switch (bh->mode) {
       case WO:  bh->highwater = 0;
                 break;
       default:  bh->highwater = 8 * lseek(bh->loc.fd,0,SEEK_END);
                 if (bh->highwater>0) {
                   char c=0;
                   lseek(bh->loc.fd,-1,SEEK_END);
                   read(bh->loc.fd,&c,1);
                   bh->highwater -= (int)c;
                 }
                 break;
     }
     lseek(bh->loc.fd,0,SEEK_SET);
   } else {
     NodePtr n = C_ALLOC(1+EXTRA);
     n[0] = CONSTRW(0,EXTRA);
     bh->loc.sp = stableInsert(n);
     bh->attrib.size = 0;
     bh->adjust.here = 0;
     bh->highwater   = 0;
   }
   opencache(bh);
  return nhc_mkCInt((int)allocForeignObj((void*)bh,(gcCval)finaliseBH,gcNow));
}
