Return-Path: <rtc-linux+bncBDS7HNEFSALRBNVZW6VQKGQEQFSAN6A@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id bc3si697031wib.2.2015.06.02.09.41.26
        for <rtc-linux@googlegroups.com>;
        Tue, 02 Jun 2015 09:41:26 -0700 (PDT)
Date: Tue, 2 Jun 2015 18:41:25 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: pang.xunlei@zte.com.cn
Cc: Alessandro Zummo <a.zummo@towertech.it>, Arnd Bergmann <arnd@arndb.de>,
	John Stultz <john.stultz@linaro.org>, linux-kernel@vger.kernel.org,
	Xunlei Pang <pang.xunlei@linaro.org>, rtc-linux@googlegroups.com
Subject: [rtc-linux] Re: [PATCH v2 1/4] drivers/rtc/pcf8563: Replace
 deprecated rtc_time_to_tm() and rtc_tm_to_time()
Message-ID: <20150602164125.GF1715@piout.net>
References: <1433235862-1638-1-git-send-email-xlpang@126.com>
 <20150602102639.GC1715@piout.net>
 <OFC9CF9873.31308A95-ON48257E58.0053C0BA-C8257E58.00548ECE@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <OFC9CF9873.31308A95-ON48257E58.0053C0BA-C8257E58.00548ECE@zte.com.cn>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

On 03/06/2015 at 00:23:40 +0900, pang.xunlei@zte.com.cn wrote :
> Apologies for the spamming, please ignore all those former 27 pending 
> patches.
> 
> I'll re-organize them with a cover letter, will resend them as new ones 
> tomorrow.
> 

Or maybe, instead of resending, you can give me the status of those
patches:
415468 [RFC,2/4] rtc: Convert rtc_class_ops.set_mmss() to use time64_t
415470 [RFC,3/4] rtc/lib: Provide interfaces to map between 32bit hardware and 64bit time
428475 [RFC,v2,2/9] time: Provide y2106 safe get_seconds() replacement
431162 [1/3] time: Don't bother to run rtc_resume() for nonstop clocksource
431649 [1/5] drivers/rtc/interface.c: Update code to use y2038-safe time interfaces
431650 [2/5] drivers/rtc/rtc-dev.c: Update code to use y2038-safe time interfaces
431798 [v2,3/3] time: clocksource: Add a comment to CLOCK_SOURCE_SUSPEND_NONSTOP
434592 [v3,1/2] time: Don't bother to run rtc_resume() for the nonstop clocksource
448780 [5/8] ARM: tegra: clock: Provide y2038-safe tegra_read_persistent_clock() replacement
448782 [6/8] ARM: time: Provide read_boot_clock64() and read_persistent_clock64()
448781 [7/8] s390: time: Provide read_boot_clock64() and read_persistent_clock64()
448783 [8/8] time: Remove read_boot_clock()

You just sent those so I guess I still have to review them:
477947 [RESEND,1/3] drivers/rtc/pcf8563: Replace deprecated rtc_time_to_tm() and rtc_tm_to_time()
477949 [RESEND,2/3] drivers/rtc/isl1208: Replace deprecated rtc_tm_to_time()
477948 [RESEND,3/3] drivers/rtc/sunxi: Replace deprecated rtc_tm_to_time()
479350 [v2,1/4] drivers/rtc/pcf8563: Replace deprecated rtc_time_to_tm() and rtc_tm_to_time()
479348 [v2,2/4] rtc/lib: Introduce rtc_tm_subtract() helper function
479351 [v2,3/4] drivers/rtc/isl1208: Replace deprecated rtc_tm_to_time()
479349 [v2,4/4] drivers/rtc/sunxi: Replace deprecated rtc_tm_to_time()
479360 [v2,1/4] NTP: rtc: Add CONFIG_RTC_SYSTOHC_DEVICE for NTP synchronization
479359 [v2,2/4] sparc: time: Replace update_persistent_clock() with CONFIG_RTC_SYSTOHC
479358 [v2,3/4] drivers/rtc/interface.c: Remove rtc_set_mmss()
479357 [v2,4/4] cris: time: Cleanup of persistent clock stuff

Many thanks for your work.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

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
