Return-Path: <rtc-linux+bncBDKZNNNLXAHBBV7S26YQKGQELXAD7QQ@googlegroups.com>
Received: from mail-pa0-x22d.google.com (mail-pa0-x22d.google.com. [2607:f8b0:400e:c03::22d])
        by gmr-mx.google.com with ESMTPS id el2si1512457pbb.0.2015.11.01.03.36.55
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 01 Nov 2015 03:36:55 -0800 (PST)
Received: by mail-pa0-x22d.google.com with SMTP id fv9so123588528pac.3
        for <rtc-linux@googlegroups.com>; Sun, 01 Nov 2015 03:36:55 -0800 (PST)
Sender: rtc-linux@googlegroups.com
Subject: [rtc-linux] Re: Pending rtc-s3c patches
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>,
 Kukjin Kim <kgene.kim@samsung.com>
References: <20151028101449.GA13014@piout.net>
Cc: k.kozlowski.k@gmail.com, linux-samsung-soc@vger.kernel.org,
 rtc-linux@googlegroups.com
From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Message-ID: <5635F953.6080702@samsung.com>
Date: Sun, 1 Nov 2015 20:36:51 +0900
MIME-Version: 1.0
In-Reply-To: <20151028101449.GA13014@piout.net>
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

W dniu 28.10.2015 o 19:14, Alexandre Belloni pisze:
> Hi,
> 
> There are three pending patches (from 2010 and 2011) for rtc-s3c. I'd
> like to get an update and either drop or apply those.
> 
> Can someone take a few minutes to review them?
> 
> The patches are:
> http://patchwork.ozlabs.org/patch/71318/

This is not needed. The pie_lock (replacing s3c_rtc_pie_lock) protects
set_freq() which:
1. is called only during probe;
2. is accessing different registers than s3c_rtc_setaie().


> http://patchwork.ozlabs.org/patch/99857/

This is good although does not apply cleanly. I rebased, tested and send
the patch.

> http://patchwork.ozlabs.org/patch/101732/

This does not look good. Code is actually used so commit description
does not match current state. I think you can ignore it.

Best regards,
Krzysztof

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
