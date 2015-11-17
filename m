Return-Path: <rtc-linux+bncBCNNJWF7RUMRBNMQVWZAKGQEYAESJRY@googlegroups.com>
Received: from mail-pa0-x22b.google.com (mail-pa0-x22b.google.com. [2607:f8b0:400e:c03::22b])
        by gmr-mx.google.com with ESMTPS id xk4si3827296pbc.2.2015.11.17.07.31.01
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Nov 2015 07:31:01 -0800 (PST)
Received: by mail-pa0-x22b.google.com with SMTP id ej9so11885552pac.2
        for <rtc-linux@googlegroups.com>; Tue, 17 Nov 2015 07:31:01 -0800 (PST)
From: Joshua Clayton <stillcompiling@gmail.com>
To: Alessandro Zummo <a.zummo@towertech.it>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, rtc-linux@googlegroups.com
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [rtc-linux] Re: [PATCH 0/9] rtc-2123: access the clock offset feature
Date: Tue, 17 Nov 2015 07:30:48 -0800
Message-ID: <2107368.j5bIbb5cBF@jclayton-pc>
In-Reply-To: <cover.1446587705.git.stillcompiling@gmail.com>
References: <cover.1446587705.git.stillcompiling@gmail.com>
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

On Wednesday, November 04, 2015 07:36:31 AM Joshua Clayton wrote:
> Greetings,
> This series was prompted by a need to adjust the clock rate of the rtc
> The existing code performs a soft reset during probe, which wipes out
> several registers including the offset register, which performs adjustments
> to the clock rate.
> 
> The first several patches are cleanup, with patch 5 and 6 avoiding the reset,
> and patch 9 adding a nice sysfs interface to the clock offset.
> 
> I know that this is not the only rtc to provide a programmable clock offset
> I wonder if this interface would make a good addition to the rtc api?
> 
> The rtc chips I have seen list their clock adjustments in parts per million.
> I went with parts per billion, since the ppm listed was listed with a
> fractional component.
> 
> Joshua Clayton (9):
>   rtc-pcf2123: Document all registers and useful bits
>   rtc-pcf2123: clean up reads from the chip
>   rtc-pcf2123: clean up writes to the rtc chip
>   rtc-pcf2123: replace magic numbers with defines
>   rtc-pcf2123: put the chip reset into a function
>   rtc-pcf2123: avoid resetting the clock if possible
>   rtc-pcf2123: allow sysfs to accept hexidecimal
>   rtc-pcf2123: use sysfs groups
>   rtc-pcf2123: adjust the clock rate via sysfs
> 
>  drivers/rtc/rtc-pcf2123.c | 391 ++++++++++++++++++++++++++++++----------------
>  1 file changed, 257 insertions(+), 134 deletions(-)
> 
> 
Any comments on this series?
I realize now that I submitted it during the merge window, so it may have been overlooked.

-- 
~Joshua Clayton

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
