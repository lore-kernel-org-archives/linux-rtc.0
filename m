Return-Path: <rtc-linux+bncBC4L3MVYV4CBBHHJ223QKGQEFX7GPDY@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from smtp.natisbad.org (2a02-8428-026f-b200-0221-70ff-fe55-8f78.rev.sfr.net. [2a02:8428:26f:b200:221:70ff:fe55:8f78])
        by gmr-mx.google.com with ESMTP id 185si25665wml.0.2016.03.25.14.58.51
        for <rtc-linux@googlegroups.com>;
        Fri, 25 Mar 2016 14:58:51 -0700 (PDT)
From: arno@natisbad.org (Arnaud Ebalard)
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: rtc-linux@googlegroups.com,  Jason Cooper <jason@lakedaemon.net>,  Sudeep Holla <Sudeep.Holla@arm.com>
Subject: [rtc-linux] Re: Intersil ISL12057 driver
References: <20160323171003.GE2570@piout.net> <878u18hp79.fsf@natisbad.org>
	<87lh57ldgv.fsf@natisbad.org> <20160324225251.GK2570@piout.net>
Date: Fri, 25 Mar 2016 22:58:40 +0100
Message-ID: <87y496rzhr.fsf@natisbad.org>
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

Hi Alexandre,

Alexandre Belloni <alexandre.belloni@free-electrons.com> writes:

> On 24/03/2016 at 23:26:24 +0100, Arnaud Ebalard wrote :
>> 1) Handling of the century bit
>> 
>
> This indeed needs fixing and it is quite simple. Do you care sending a
> patch?

A first version is below. As discussed in the commit message, it is
trivial to make set_ and get_ time functions consistent. But it is not
that easy to extend the capabilities of the driver after 2099 w/o
breaking current platforms.

Basically, the patch below simply remove support for century bit for
ds1307 flavours that have the feature to get things consistent. A sanity
check is also added.

Comments welcome!

>> 2) Alarm:
>> 
>
> [...]
>
> Well, my bad, your analysis is correct and I was thinking
> 8bc2a40730ec74271a0573a6882871308d069f5d was in 4.5 but it will actually
> be in 4.6:
> http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=8bc2a40730ec74271a0573a6882871308d069f5d
>
> This should solve that one. And you are right, I should probably do
> something more generic in the framework to handle "wakeup-source".

I have tested a 4.5 with 8bc2a40730ec74 and alarm support works as
expected (i.e. wakeup-source property from dts is honored).

The only minor things to address before removing my (regmap-enabled ;-))
rtc-isl12057.c driver from the tree is the backward compatibility for
"isil,isl12057", "isl,isl12057" and "isil,irq2-can-wakeup-machine" that
may be in existing .dtb and the drivcer support.

Regarding in-kernel users (RN102, RN104 and RN2120), those devices came
with a non-dt capable u-boot; the kernels are ones with an appended dtb,
which is usually updated w/ the kernel. For thoses ones, I do not think
there is any need for retrocompatibility.

Thoughts?

Cheers,

a+


>From 4af5d133daf3a77a39c2f0c17b245ed622e20c16 Mon Sep 17 00:00:00 2001
From: Arnaud Ebalard <arno@natisbad.org>
Date: Fri, 25 Mar 2016 21:21:09 +0100
Subject: [PATCH] rtc: ds1307: fix inconsistent use of century bit

Historically, ds1307 RTC driver mistakenly enabled century
bit when setting the time between 2000 and 2099 (on century
supporting flavour i.e. ds1337, ds1339, ds3231 and ds1340), but
ignored it when reading the time. In practice, this prevents the
driver to support time values after 2099.

This commit removes support for century bit for century capable
flavours supported by the driver to make get and set function
consistent. It also adds an explicit check that passed year
values are in the right range when setting time.

Note that it is not possible to make the driver support time
values after 2099 in a way compatible with currently deployed
versions because RTC chips in the field now have their century
bit set.
---
 drivers/rtc/rtc-ds1307.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/rtc/rtc-ds1307.c b/drivers/rtc/rtc-ds1307.c
index b2156ee5bae1..1537ec83bf8e 100644
--- a/drivers/rtc/rtc-ds1307.c
+++ b/drivers/rtc/rtc-ds1307.c
@@ -413,20 +413,12 @@ static int ds1307_set_time(struct device *dev, struct rtc_time *t)
 	buf[DS1307_REG_MONTH] = bin2bcd(t->tm_mon + 1);
 
 	/* assume 20YY not 19YY */
+	if (t->tm_year < 100 || t->tm_year > 199)
+		return -EINVAL;
 	tmp = t->tm_year - 100;
 	buf[DS1307_REG_YEAR] = bin2bcd(tmp);
 
 	switch (ds1307->type) {
-	case ds_1337:
-	case ds_1339:
-	case ds_3231:
-		buf[DS1307_REG_MONTH] |= DS1337_BIT_CENTURY;
-		break;
-	case ds_1340:
-		buf[DS1307_REG_HOUR] |= DS1340_BIT_CENTURY_EN
-				| DS1340_BIT_CENTURY;
-		break;
 	case mcp794xx:
 		/*
 		 * these bits were cleared when preparing the date/time
-- 
2.7.0

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
