Return-Path: <rtc-linux+bncBDEKVJM7XAHRB4WYUK4QKGQERIKYR2A@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mout.kundenserver.de (mout.kundenserver.de. [212.227.126.131])
        by gmr-mx.google.com with ESMTPS id a65si1530724wma.0.2016.05.03.06.49.37
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 May 2016 06:49:38 -0700 (PDT)
From: Arnd Bergmann <arnd@arndb.de>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, a.zummo@towertech.it, rtc-linux@googlegroups.com, linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Subject: [rtc-linux] Re: [PATCH 0/2] m68k RTC fixes
Date: Tue, 03 May 2016 15:49:31 +0200
Message-ID: <1708606.ou3btFVZ5o@wuerfel>
In-Reply-To: <20160503134034.GK2335@piout.net>
References: <1462178783-29294-1-git-send-email-geert@linux-m68k.org> <20160503134034.GK2335@piout.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On Tuesday 03 May 2016 15:40:34 Alexandre Belloni wrote:
> > Queue strategy:
> >   1. These are queued together with Arnd's series,
> >   1. I queue them for v4.7 myself, but then the RTC tree must be mergest
> >      after the m68k tree,
> >   2. I queue them for v4.6.
> > 
> > As I currently don't have any m68k patches queued for v4.7, perhaps it's
> > easiest if these are included with Arnd's series?
> > 
> 
> I suggest you take them for 4.7 anyway. I don't think I am confident
> enough to merge Arnd's series for 4.7. Also, I doubt I'll get many acks
> from some architecture maintainers.
> 
> So, my plan is to apply it on top of 4.7-rc1 and let it sit in
> linux-next for a while.
> 

Good idea. It's getting a bit late for 4.7 now, and there is nothing
urgent in my series.

	Arnd

-- 
-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
