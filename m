Return-Path: <rtc-linux+bncBCQJP74GSUDRBCXBUK4QKGQER5PO3XQ@googlegroups.com>
Received: from mail-io0-x241.google.com (mail-io0-x241.google.com. [2607:f8b0:4001:c06::241])
        by gmr-mx.google.com with ESMTPS id au10si1241644igc.3.2016.05.03.07.07.06
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 May 2016 07:07:06 -0700 (PDT)
Received: by mail-io0-x241.google.com with SMTP id d62so2381616iof.1
        for <rtc-linux@googlegroups.com>; Tue, 03 May 2016 07:07:06 -0700 (PDT)
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <1708606.ou3btFVZ5o@wuerfel>
References: <1462178783-29294-1-git-send-email-geert@linux-m68k.org>
	<20160503134034.GK2335@piout.net>
	<1708606.ou3btFVZ5o@wuerfel>
Date: Tue, 3 May 2016 16:07:05 +0200
Message-ID: <CAMuHMdVmfMbnNpUGvdVWa4fxOZjN5Dip0coaikUanCgdH+8fqw@mail.gmail.com>
Subject: [rtc-linux] Re: [PATCH 0/2] m68k RTC fixes
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Alessandro Zummo <a.zummo@towertech.it>, RTCLINUX <rtc-linux@googlegroups.com>,
	linux-m68k <linux-m68k@lists.linux-m68k.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On Tue, May 3, 2016 at 3:49 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Tuesday 03 May 2016 15:40:34 Alexandre Belloni wrote:
>> > Queue strategy:
>> >   1. These are queued together with Arnd's series,
>> >   1. I queue them for v4.7 myself, but then the RTC tree must be mergest
>> >      after the m68k tree,
>> >   2. I queue them for v4.6.
>> >
>> > As I currently don't have any m68k patches queued for v4.7, perhaps it's
>> > easiest if these are included with Arnd's series?
>> >
>>
>> I suggest you take them for 4.7 anyway. I don't think I am confident
>> enough to merge Arnd's series for 4.7. Also, I doubt I'll get many acks
>> from some architecture maintainers.
>>
>> So, my plan is to apply it on top of 4.7-rc1 and let it sit in
>> linux-next for a while.
>
> Good idea. It's getting a bit late for 4.7 now, and there is nothing
> urgent in my series.

OK, I've applied the m68k preparatory fixes and pushed them out.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

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
