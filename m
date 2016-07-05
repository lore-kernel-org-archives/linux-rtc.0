Return-Path: <rtc-linux+bncBDKZNNNLXAHBBX6Z5W5QKGQECU25VMY@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com. [210.118.77.11])
        by gmr-mx.google.com with ESMTPS id i135si324919pfe.0.2016.07.05.01.16.30
        for <rtc-linux@googlegroups.com>
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Tue, 05 Jul 2016 01:16:31 -0700 (PDT)
Received: from eucpsbgm2.samsung.com (unknown [203.254.199.245])
 by mailout1.w1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0O9U009E41NFGL50@mailout1.w1.samsung.com> for
 rtc-linux@googlegroups.com; Tue, 05 Jul 2016 09:16:27 +0100 (BST)
Subject: [rtc-linux] Re: [RFC PATCH 2/2] rtc: s3c: Add s3c_rtc_{enable/disable}_clk
 in s3c_rtc_setfreq()
To: Alim Akhtar <alim.akhtar@samsung.com>, rtc-linux@googlegroups.com,
 linux-kernel@vger.kernel.org
References: <1467630195-6929-1-git-send-email-alim.akhtar@samsung.com>
 <1467630195-6929-2-git-send-email-alim.akhtar@samsung.com>
Cc: alexandre.belloni@free-electrons.com, javier@osg.samsung.com,
 pankaj.dubey@samsung.com
From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Message-id: <577B6CD9.80605@samsung.com>
Date: Tue, 05 Jul 2016 10:16:25 +0200
MIME-version: 1.0
In-reply-to: <1467630195-6929-2-git-send-email-alim.akhtar@samsung.com>
Content-type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 07/04/2016 01:03 PM, Alim Akhtar wrote:
> As per code flow it is possible that s3c_rtc_setfreq() might get called
> with rtc clock disabled and in set_freq we perform h/w registers read/write,
> which might results in a kernel crash while probing rtc driver.
> Below is one such case:
> s3c_rtc_probe()
>     clk_prepare_enable(info->rtc_clk) // rtc clock enabled
>       s3c_rtc_gettime() // will enable clk if not done, and disable it upon exit
>         s3c_rtc_setfreq() //then this will be called with clk disabled

The indentation suggests levels of calls (chain) not sequence. This
should be:
s3c_rtc_probe()
  clk_prepare_enable(info->rtc_clk) // rtc clock enabled
  s3c_rtc_gettime() // will enable clk if not done, and disable it upon exit
  s3c_rtc_setfreq() //then this will be called with clk disabled

> 
> This patch take cares of such issue by adding s3c_rtc_{enable/disable}_clk in
> s3c_rtc_setfreq().

What I don't get is that you wrote "it is *possible* that
s3c_rtc_setfreq() *might* get called". From my understanding this will
happen always because src_rtc_gettime() always disables the clocks.

Why it does not happen always?

Best regards,
Krzysztof

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
