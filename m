Return-Path: <rtc-linux+bncBCQJP74GSUDRBYXTQ24QKGQEOZ4C5XI@googlegroups.com>
Received: from mail-io0-x244.google.com (mail-io0-x244.google.com. [2607:f8b0:4001:c06::244])
        by gmr-mx.google.com with ESMTPS id d2si772772igx.2.2016.04.28.00.21.06
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Apr 2016 00:21:06 -0700 (PDT)
Received: by mail-io0-x244.google.com with SMTP id u185so11481745iod.2
        for <rtc-linux@googlegroups.com>; Thu, 28 Apr 2016 00:21:06 -0700 (PDT)
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <20160427232122.GW21636@brightrain.aerifal.cx>
References: <1461796470-1291527-1-git-send-email-arnd@arndb.de>
	<1461796470-1291527-5-git-send-email-arnd@arndb.de>
	<20160427232122.GW21636@brightrain.aerifal.cx>
Date: Thu, 28 Apr 2016 09:21:05 +0200
Message-ID: <CAMuHMdVP3QWvyY11sw-Y440MFpxtjcZRQ+pAP76p35qFvcye6g@mail.gmail.com>
Subject: [rtc-linux] Re: [PATCH v3 04/16] rtc: sh: provide rtc_class_ops directly
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Rich Felker <dalias@libc.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Helge Deller <deller@gmx.de>, Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Michael Ellerman <mpe@ellerman.id.au>, David Howells <dhowells@redhat.com>,
	alpha <linux-alpha@vger.kernel.org>, Alessandro Zummo <a.zummo@towertech.it>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Parisc List <linux-parisc@vger.kernel.org>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, Linux-sh list <linux-sh@vger.kernel.org>,
	linux-m68k <linux-m68k@lists.linux-m68k.org>, RTCLINUX <rtc-linux@googlegroups.com>,
	Linux-Arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Hi Rich,

On Thu, Apr 28, 2016 at 1:21 AM, Rich Felker <dalias@libc.org> wrote:
> Not a complaint about your patch, but I'd like to get rid of this
> platform device and abstraction layer completely since it doesn't seem
> like something that can be modeled correctly in device tree. When
> you're done cleaning this up, will it be possible to just have rtc
> drivers that use whatever generic framework is left, where the right
> driver is automatically attached to compatible DT nodes? I'm trying to
> move all of arch/sh over to device tree and remove hard-coded platform
> devices.

If you describe the RTC in DT, it can bound to a hardware-specific driver
in drivers/rtc/rtc-*.c.

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
