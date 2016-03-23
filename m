Return-Path: <rtc-linux+bncBC4L3MVYV4CBBMEOZS3QKGQERXBIPWY@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from smtp.natisbad.org (2a02-8428-026f-b200-0221-70ff-fe55-8f78.rev.sfr.net. [2a02:8428:26f:b200:221:70ff:fe55:8f78])
        by gmr-mx.google.com with ESMTP id v68si348204wmd.1.2016.03.23.14.14.24
        for <rtc-linux@googlegroups.com>;
        Wed, 23 Mar 2016 14:14:24 -0700 (PDT)
From: arno@natisbad.org (Arnaud Ebalard)
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: rtc-linux@googlegroups.com,  Jason Cooper <jason@lakedaemon.net>
Subject: [rtc-linux] Re: Intersil ISL12057 driver
References: <20160323171003.GE2570@piout.net>
Date: Wed, 23 Mar 2016 22:14:18 +0100
In-Reply-To: <20160323171003.GE2570@piout.net> (Alexandre Belloni's message of
	"Wed, 23 Mar 2016 18:10:03 +0100")
Message-ID: <878u18hp79.fsf@natisbad.org>
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

> I know it has been a while that this driver has been submitted but
> Intersil is claiming that ISL12057 is a drop in replacement for ds1337.
> I don't think there are any features supported by rtc-isl12057.c
> that are not supported by rtc-ds1307.c.  Could you confirm rtc-ds1307
> works for you?  I'd like to reduce the number of duplicated drivers.

Sure. I'll take some time tomorrow evening to test how ds1337 works on
my platforms and report back.

a+

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
