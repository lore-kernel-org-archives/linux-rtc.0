Return-Path: <rtc-linux+bncBDULZYNR2QMRBB5GYGYAKGQEIC6VZUA@googlegroups.com>
Received: from mail-io0-x236.google.com (mail-io0-x236.google.com. [2607:f8b0:4001:c06::236])
        by gmr-mx.google.com with ESMTPS id x8si492242igx.2.2015.10.03.15.13.27
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 03 Oct 2015 15:13:27 -0700 (PDT)
Received: by mail-io0-x236.google.com with SMTP id i196so152497681ioi.3
        for <rtc-linux@googlegroups.com>; Sat, 03 Oct 2015 15:13:27 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1443909258-24914-1-git-send-email-harald@ccbib.org>
References: <1443909258-24914-1-git-send-email-harald@ccbib.org>
Date: Sat, 3 Oct 2015 19:13:26 -0300
Message-ID: <CAOMZO5A=dUVUXh+-zYBq6F9FGwk2rRiqS2PXfOLrsAqHKpDyBA@mail.gmail.com>
Subject: [rtc-linux] Re: [PATCHv2] watchdog: stmp3xxx: Implement GETBOOTSTATUS
From: Fabio Estevam <festevam@gmail.com>
To: Harald Geyer <harald@ccbib.org>
Cc: Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>, Wim Van Sebroeck <wim@iguana.be>,
	rtc-linux@googlegroups.com, linux-watchdog@vger.kernel.org,
	Sascha Hauer <kernel@pengutronix.de>, Wolfram Sang <wsa@the-dreams.de>
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

Hi Harald,

On Sat, Oct 3, 2015 at 6:54 PM, Harald Geyer <harald@ccbib.org> wrote:
> When the watchdog is enabled, we set a persitent bit. After booting
> we query the bit and see if the system was reset by the watchdog.
>
> This is somewhat similar to what the legacy driver from freescale
> does. However we use STMP3XXX_RTC_PERSISTENT2 instead of
> STMP3XXX_RTC_PERSISTENT1. I tried that first, but it seems I can't
> clear the bit there once it is set. I didn't find any documentation
> what this register does - only vague hints that it is meant to
> control the boot ROM.
>
> Part of the code from the legacy driver touching this register
> is still included. Maybe this is stale, but this patch doesn't
> touch any of it because I don't know what it really does or is
> meant to do.
>
> Signed-off-by: Harald Geyer <harald@ccbib.org>

I read your commit log, but it is not clear for me what is the real
issue you are trying to solve with this patch.

Please clarify.

Regards,

Fabio Estevam

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
