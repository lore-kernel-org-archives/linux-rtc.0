Return-Path: <rtc-linux+bncBDEKVJM7XAHRBBGW7CWAKGQE4YID5VQ@googlegroups.com>
Received: from mout.kundenserver.de (mout.kundenserver.de. [212.227.17.13])
        by gmr-mx.google.com with ESMTPS id t6si93469wiz.0.2015.07.09.01.04.20
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Jul 2015 01:04:20 -0700 (PDT)
From: Arnd Bergmann <arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
Cc: Roman Yeryomin <roman@advem.lv>, Felix Fietkau <nbd@openwrt.org>, rtc-linux@googlegroups.com, Linus Walleij <linus.walleij@linaro.org>, linux-kernel@vger.kernel.org, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Russell King <rmk+kernel@arm.linux.org.uk>, Hans Ulli Kroll <ulli.kroll@googlemail.com>
Subject: [rtc-linux] Re: [1/2] RTC: Add core rtc support for Gemini Soc devices
Date: Thu, 09 Jul 2015 10:04:14 +0200
Message-ID: <1781580.JRD7b0UrJA@wuerfel>
In-Reply-To: <f22e65faa7d86074cda27973f83d7a52@advem.lv>
References: <1292339307-14336-2-git-send-email-ulli.kroll@googlemail.com> <2131951.l0j0CIttAZ@wuerfel> <f22e65faa7d86074cda27973f83d7a52@advem.lv>
MIME-Version: 1.0
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

On Thursday 09 July 2015 01:29:39 Roman Yeryomin wrote:
> 
> OK, here are the minimal changes required (see attachment). Tested on 
> 4.1.1
> Let me know if you want me to submit it in some other way.
> 

The changes look ok to me. Please submit them as two separate
patches (1. set up and use timer3, 2. register sched_clock) according
to the Documentation/SubmittingPatches description.

Thanks,

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
