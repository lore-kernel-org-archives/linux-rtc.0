Return-Path: <rtc-linux+bncBCQJP74GSUDRBBX73K3AKGQENKQBISY@googlegroups.com>
Received: from mail-ig0-x241.google.com (mail-ig0-x241.google.com. [2607:f8b0:4001:c05::241])
        by gmr-mx.google.com with ESMTPS id k15si281516igt.3.2016.03.02.02.25.10
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 02 Mar 2016 02:25:10 -0800 (PST)
Received: by mail-ig0-x241.google.com with SMTP id xg9so4393983igb.3
        for <rtc-linux@googlegroups.com>; Wed, 02 Mar 2016 02:25:10 -0800 (PST)
MIME-Version: 1.0
Sender: rtc-linux@googlegroups.com
In-Reply-To: <1456912137-1578635-2-git-send-email-arnd@arndb.de>
References: <1456912137-1578635-1-git-send-email-arnd@arndb.de>
	<1456912137-1578635-2-git-send-email-arnd@arndb.de>
Date: Wed, 2 Mar 2016 11:25:10 +0100
Message-ID: <CAMuHMdVRBLd0hhBLC_pxbzCv3qwjPWhHyvVV3+ikgqytiaLqfQ@mail.gmail.com>
Subject: [rtc-linux] Re: [PATCH 2/2] char: genrtc: replace blacklist with whitelist
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	RTCLINUX <rtc-linux@googlegroups.com>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
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

On Wed, Mar 2, 2016 at 10:48 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> Every new architecture has to add itself to the growing list of those
> that do not support the old "generic" RTC driver.
>
> This replaces the long list of architectures that don't support it
> with a shorter list of those that do.
>
> The list is taken from those architectures that have a non-empty
> asm/rtc.h header file and were not explicitly blacklisted.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

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
