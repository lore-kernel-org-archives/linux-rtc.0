Return-Path: <rtc-linux+bncBAABBCVMXGVQKGQEVUJBAJQ@googlegroups.com>
Received: from mx6.zte.com.cn (mx6.zte.com.cn. [95.130.199.165])
        by gmr-mx.google.com with ESMTP id ha2si487055wib.1.2015.06.02.18.19.06
        for <rtc-linux@googlegroups.com>;
        Tue, 02 Jun 2015 18:19:06 -0700 (PDT)
Received: from zte.com.cn (unknown [192.168.168.119])
	by Websense Email Security Gateway with ESMTP id 9A57A3CBD84A9
	for <rtc-linux@googlegroups.com>; Wed,  3 Jun 2015 09:17:57 +0800 (CST)
In-Reply-To: <20150602164125.GF1715@piout.net>
References: <1433235862-1638-1-git-send-email-xlpang@126.com> <20150602102639.GC1715@piout.net> <OFC9CF9873.31308A95-ON48257E58.0053C0BA-C8257E58.00548ECE@zte.com.cn> <20150602164125.GF1715@piout.net>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>, Arnd Bergmann <arnd@arndb.de>,
        John Stultz <john.stultz@linaro.org>, linux-kernel@vger.kernel.org,
        Xunlei Pang <pang.xunlei@linaro.org>, rtc-linux@googlegroups.com
Subject: [rtc-linux] Re: [PATCH v2 1/4] drivers/rtc/pcf8563: Replace
 deprecated rtc_time_to_tm() and rtc_tm_to_time()
MIME-Version: 1.0
Message-ID: <OFC41C6D99.FB9C3A21-ON48257E59.0005C8A9-48257E59.00073A3F@zte.com.cn>
From: pang.xunlei@zte.com.cn
Date: Wed, 3 Jun 2015 09:19:01 +0800
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

Hi Alexandre,

Alexandre Belloni <alexandre.belloni@free-electrons.com> wrote 2015-06-03=
=20
AM 12:41:25:
> Re: [PATCH v2 1/4] drivers/rtc/pcf8563: Replace deprecated=20
> rtc_time_to_tm() and rtc_tm_to_time()
>=20
> On 03/06/2015 at 00:23:40 +0900, pang.xunlei@zte.com.cn wrote :
> > Apologies for the spamming, please ignore all those former 27 pending=
=20
> > patches.
> >=20
> > I'll re-organize them with a cover letter, will resend them as new=20
ones=20
> > tomorrow.
> >=20
>=20
> Or maybe, instead of resending, you can give me the status of those
> patches:

Ok, I'll use a cover letter in future ones like so.

> 415468 [RFC,2/4] rtc: Convert rtc_class_ops.set_mmss() to use time64_t
> 415470 [RFC,3/4] rtc/lib: Provide interfaces to map between 32bit=20
> hardware and 64bit time
> 428475 [RFC,v2,2/9] time: Provide y2106 safe get_seconds() replacement
> 431162 [1/3] time: Don't bother to run rtc_resume() for nonstop=20
clocksource
> 431649 [1/5] drivers/rtc/interface.c: Update code to use y2038-safe=20
> time interfaces
> 431650 [2/5] drivers/rtc/rtc-dev.c: Update code to use y2038-safe=20
> time interfaces
> 431798 [v2,3/3] time: clocksource: Add a comment to=20
> CLOCK_SOURCE_SUSPEND_NONSTOP
> 434592 [v3,1/2] time: Don't bother to run rtc_resume() for the=20
> nonstop clocksource
> 448780 [5/8] ARM: tegra: clock: Provide y2038-safe=20
> tegra_read_persistent_clock() replacement
> 448782 [6/8] ARM: time: Provide read_boot_clock64() and=20
> read_persistent_clock64()
> 448781 [7/8] s390: time: Provide read_boot_clock64() and=20
> read_persistent_clock64()
> 448783 [8/8] time: Remove read_boot_clock()

The above had already been merged into upstream, at least I can see them
in tip/master now.

>=20
> You just sent those so I guess I still have to review them:
> 477947 [RESEND,1/3] drivers/rtc/pcf8563: Replace deprecated=20
> rtc_time_to_tm() and rtc_tm_to_time()
> 477949 [RESEND,2/3] drivers/rtc/isl1208: Replace deprecated=20
rtc_tm_to_time()
> 477948 [RESEND,3/3] drivers/rtc/sunxi: Replace deprecated=20
rtc_tm_to_time()


Patch series below is about replacing deprecated=20
rtc_tm_to_time()/rtc_time_to_tm()
mostly in rtc drivers with their y2038-safe substitutes=20
rtc_tm_to_time64()/
rtc_time64_to_tm() which were merged into upstream last year.

> 479350 [v2,1/4] drivers/rtc/pcf8563: Replace deprecated=20
> rtc_time_to_tm() and rtc_tm_to_time()
> 479348 [v2,2/4] rtc/lib: Introduce rtc_tm_subtract() helper function
> 479351 [v2,3/4] drivers/rtc/isl1208: Replace deprecated rtc_tm_to_time()
> 479349 [v2,4/4] drivers/rtc/sunxi: Replace deprecated rtc_tm_to_time()

And in the following one, I want to replace all the xxx_persistent_clock()
architecture implementations with xxx_persistent_clock64() or simply=20
remove
it if can(mainly for rtc-related persistent clock).

> 479360 [v2,1/4] NTP: rtc: Add CONFIG_RTC_SYSTOHC_DEVICE for NTP=20
> synchronization
> 479359 [v2,2/4] sparc: time: Replace update_persistent_clock() with=20
> CONFIG_RTC_SYSTOHC
> 479358 [v2,3/4] drivers/rtc/interface.c: Remove rtc_set_mmss()
> 479357 [v2,4/4] cris: time: Cleanup of persistent clock stuff
>=20
> Many thanks for your work.

I think you can only review the two v2 series :-)

-Xunlei

--------------------------------------------------------
ZTE Information Security Notice: The information contained in this mail (an=
d any attachment transmitted herewith) is privileged and confidential and i=
s intended for the exclusive use of the addressee(s).  If you are not an in=
tended recipient, any disclosure, reproduction, distribution or other disse=
mination or use of the information contained is strictly prohibited.  If yo=
u have received this mail in error, please delete it and notify us immediat=
ely.
--------------------------------------------------------
ZTE Information Security Notice: The information contained in this mail (an=
d any attachment transmitted herewith) is privileged and confidential and i=
s intended for the exclusive use of the addressee(s).  If you are not an in=
tended recipient, any disclosure, reproduction, distribution or other disse=
mination or use of the information contained is strictly prohibited.  If yo=
u have received this mail in error, please delete it and notify us immediat=
ely.

--=20
--=20
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
---=20
You received this message because you are subscribed to the Google Groups "=
rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
