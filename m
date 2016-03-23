Return-Path: <rtc-linux+bncBDS7HNEFSALRB5U3ZO3QKGQENCT7LWY@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id s141si1159933wmd.1.2016.03.23.10.10.13
        for <rtc-linux@googlegroups.com>;
        Wed, 23 Mar 2016 10:10:13 -0700 (PDT)
Date: Wed, 23 Mar 2016 18:10:03 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Arnaud Ebalard <arno@natisbad.org>
Cc: rtc-linux@googlegroups.com, Jason Cooper <jason@lakedaemon.net>
Subject: [rtc-linux] Intersil ISL12057 driver
Message-ID: <20160323171003.GE2570@piout.net>
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

Hi,

I know it has been a while that this driver has been submitted but
Intersil is claiming that ISL12057 is a drop in replacement for ds1337.
I don't think there are any features supported by rtc-isl12057.c
that are not supported by rtc-ds1307.c.  Could you confirm rtc-ds1307
works for you?  I'd like to reduce the number of duplicated drivers.

Thanks!

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
