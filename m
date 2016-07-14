Return-Path: <rtc-linux+bncBC4L3MVYV4CBBDHGT66AKGQE3CSRHPI@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from smtp.natisbad.org (2a02-8428-026f-b200-0221-70ff-fe55-8f78.rev.sfr.net. [2a02:8428:26f:b200:221:70ff:fe55:8f78])
        by gmr-mx.google.com with ESMTP id v14si500004wmf.0.2016.07.14.13.16.12
        for <rtc-linux@googlegroups.com>;
        Thu, 14 Jul 2016 13:16:12 -0700 (PDT)
From: arno@natisbad.org (Arnaud Ebalard)
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>,  rtc-linux@googlegroups.com,  linux-kernel@vger.kernel.org
Subject: [rtc-linux] Re: [PATCH 0/3] rtc: remove intersil isl12057
References: <1468371571-22641-1-git-send-email-alexandre.belloni@free-electrons.com>
Date: Thu, 14 Jul 2016 22:16:07 +0200
In-Reply-To: <1468371571-22641-1-git-send-email-alexandre.belloni@free-electrons.com>
	(Alexandre Belloni's message of "Wed, 13 Jul 2016 02:59:28 +0200")
Message-ID: <87vb08gem0.fsf@natisbad.org>
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

> This is the series I intend to apply once you confirm my previous patch
> is working.

For previous patch and that series, once the typos are fixed:

Acked-by: Arnaud Ebalard <arno@natisbad.org>

Thanks for spotting the duplication and your work.

Cheers,

a+

>
> Alexandre Belloni (3):
>   Documentation: dt: Intersil isl12057 is not a trivial device
>   rtc: ds1307: add Intersil ISL12057 support
>   rtc: isl12057: remove driver
>
>  .../devicetree/bindings/i2c/trivial-devices.txt    |   1 -
>  drivers/rtc/Kconfig                                |  18 +-
>  drivers/rtc/Makefile                               |   1 -
>  drivers/rtc/rtc-ds1307.c                           |   6 +
>  drivers/rtc/rtc-isl12057.c                         | 643 ---------------------
>  5 files changed, 10 insertions(+), 659 deletions(-)
>  delete mode 100644 drivers/rtc/rtc-isl12057.c

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
