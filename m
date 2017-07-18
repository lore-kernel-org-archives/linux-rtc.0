Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from smtprelay0143.hostedemail.com ([216.40.44.143]:59598 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751543AbdGRScx (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Tue, 18 Jul 2017 14:32:53 -0400
Message-ID: <1500402768.25934.29.camel@perches.com>
Subject: Re: [PATCH v1 00/25] lib, rtc: Print rtc_time via %pt[dt][rv]
From: Joe Perches <joe@perches.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        linux-rtc@vger.kernel.org
Cc: Mark Salyzyn <salyzyn@android.com>
Date: Tue, 18 Jul 2017 11:32:48 -0700
In-Reply-To: <1500400523.29303.92.camel@linux.intel.com>
References: <20170608134811.60786-1-andriy.shevchenko@linux.intel.com>
         <1500400205.25934.27.camel@perches.com>
         <1500400523.29303.92.camel@linux.intel.com>
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On Tue, 2017-07-18 at 20:55 +0300, Andy Shevchenko wrote:
> On Tue, 2017-07-18 at 10:50 -0700, Joe Perches wrote:
> > On Thu, 2017-06-08 at 16:47 +0300, Andy Shevchenko wrote:
> > > Recently I have noticed too many users of struct rtc_time that
> > > printing
> > > its content field by field.
> > > 
> > > In this series I introduce %pt[dt][rv] specifier to make life a bit
> > > easier.
> > 
> > Hey Andy.
> > 
> > I just saw a patch with a printk for rtc time from Mark Salyzyn.
> > https://lkml.org/lkml/2017/7/18/885
> 
> Same!
> 
> > Any idea if you want to push this extension?
> 
> Yes, just really lack of time for everything.
> 
> I like the idea to make it conditional (config BLABLABLA). It will
> address some comments about footprint for no users.

Only one of the other %p<foo> extensions is conditional
and that
conditional is probably not too useful.

I think the code size is relatively small and not
particularly valuable for the additional complexity.

For instance, all of the code that emits MAC and
IP[46] addresses %pM and %pI variants is 2.5K.
(x86 allnoconfig)

There are lots more code size savings than that
lying about.

And auditing all the code that might emit a MAC
address when CONFIG_NET is not set is probably
not worth the effort for the size reduction.

$ size lib/vsprintf.o*
   text	   data	    bss	    dec	    hex	
filename
  12140	      4	      0	  12144	   2f70	
lib/vsprintf.o.allnoconfig.new
  14785	      4	      0	  14789	   39c5	
lib/vsprintf.o.allnoconfig.old
---
 lib/vsprintf.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index 86c3385b9eb3..de95e78ca5f0 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -933,6 +933,7 @@ char *bitmap_list_string(char *buf, char *end, unsigned long *bitmap,
 	return buf;
 }
 
+#ifdef CONFIG_NET
 static noinline_for_stack
 char *mac_address_string(char *buf, char *end, u8 *addr,
 			 struct printf_spec spec, const char *fmt)
@@ -1241,6 +1242,7 @@ char *ip4_addr_string_sa(char *buf, char *end, const struct sockaddr_in *sa,
 
 	return string(buf, end, ip4_addr, spec);
 }
+#endif
 
 static noinline_for_stack
 char *escaped_string(char *buf, char *end, u8 *addr, struct printf_spec spec,
@@ -1741,6 +1743,7 @@ char *pointer(const char *fmt, char *buf, char *end, void *ptr,
 		default:
 			return bitmap_string(buf, end, ptr, spec, fmt);
 		}
+#ifdef CONFIG_NET
 	case 'M':			/* Colon separated: 00:01:02:03:04:05 */
 	case 'm':			/* Contiguous: 000102030405 */
 					/* [mM]F (FDDI) */
@@ -1777,6 +1780,7 @@ char *pointer(const char *fmt, char *buf, char *end, void *ptr,
 			}}
 		}
 		break;
+#endif
 	case 'E':
 		return escaped_string(buf, end, ptr, spec, fmt);
 	case 'U':
