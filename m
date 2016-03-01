Return-Path: <rtc-linux+bncBCQJP74GSUDRBWFU2W3AKGQEVBCI2GA@googlegroups.com>
Received: from mail-io0-x22d.google.com (mail-io0-x22d.google.com. [2607:f8b0:4001:c06::22d])
        by gmr-mx.google.com with ESMTPS id iq8si1204445igb.0.2016.03.01.01.01.12
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 Mar 2016 01:01:12 -0800 (PST)
Received: by mail-io0-x22d.google.com with SMTP id g203so215534630iof.2
        for <rtc-linux@googlegroups.com>; Tue, 01 Mar 2016 01:01:12 -0800 (PST)
MIME-Version: 1.0
Sender: rtc-linux@googlegroups.com
In-Reply-To: <1456788518-31420-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1456788518-31420-1-git-send-email-alexandre.belloni@free-electrons.com>
Date: Tue, 1 Mar 2016 10:01:12 +0100
Message-ID: <CAMuHMdW52X2y3t+oHt3Uvax_ihBxr2F7j9xCzWSqfn0RRC+Yfw@mail.gmail.com>
Subject: [rtc-linux] Re: [PATCH] rtc: enable COMPILE_TEST
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: RTCLINUX <rtc-linux@googlegroups.com>, Alessandro Zummo <a.zummo@towertech.it>,
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

On Tue, Mar 1, 2016 at 12:28 AM, Alexandre Belloni
<alexandre.belloni@free-electrons.com> wrote:
> There are several arch-specific RTC drivers that can be successfully
> compiled on other platforms. Add a COMPILE_TEST dependency for those.
>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

BTW, no additional dependencies needed on sun3-allmodconfig.
One new warning seen, patch sent.

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
