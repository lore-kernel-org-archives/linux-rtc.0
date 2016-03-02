Return-Path: <rtc-linux+bncBDKZNNNLXAHBB6WD3G3AKGQEGUQPXDA@googlegroups.com>
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com. [210.118.77.12])
        by gmr-mx.google.com with ESMTPS id y20si2909786pfa.2.2016.03.01.19.46.01
        for <rtc-linux@googlegroups.com>
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Tue, 01 Mar 2016 19:46:02 -0800 (PST)
Received: from eucpsbgm1.samsung.com (unknown [203.254.199.244])
 by mailout2.w1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0O3E003LY7SLYE80@mailout2.w1.samsung.com> for
 rtc-linux@googlegroups.com; Wed, 02 Mar 2016 03:45:57 +0000 (GMT)
Subject: [rtc-linux] Re: [PATCH 2/2] rtc: max77686: Use REGMAP_IRQ_REG for
 regmap-rtc-irqs initialisation
To: Laxman Dewangan <ldewangan@nvidia.com>,
 alexandre.belloni@free-electrons.com, a.zummo@towertech.it
References: <1456750705-13579-1-git-send-email-ldewangan@nvidia.com>
 <1456750705-13579-2-git-send-email-ldewangan@nvidia.com>
 <56D63B28.9030502@samsung.com> <56D64A25.5050700@nvidia.com>
Cc: cw00.choi@samsung.com, rtc-linux@googlegroups.com,
 linux-kernel@vger.kernel.org, javier@osg.samsung.com, rklein@nvidia.com
From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Message-id: <56D661F0.9080805@samsung.com>
Date: Wed, 02 Mar 2016 12:45:52 +0900
MIME-version: 1.0
In-reply-to: <56D64A25.5050700@nvidia.com>
Content-type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 02.03.2016 11:04, Laxman Dewangan wrote:
> 
> On Wednesday 02 March 2016 06:30 AM, Krzysztof Kozlowski wrote:
>> On 29.02.2016 21:58, Laxman Dewangan wrote:
>>> use macro REGMAP_IRQ_REG from regmap.h to initialise the
>>> regmap irq table for max77686.
>> Why? Any benefits?
>>
>>
> I think it is better coding to use macro for member initializations
> instead of doing it locally and it improves readability.
> 
> I got the similar comment from Lee's in my MFD patches to use macro for
> such initialization and I agreed with him.
> 
> As I was here on this driver, thought to use macro.

Sounds good, so this should be written in commit message.

BR,
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
