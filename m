Return-Path: <rtc-linux+bncBDKZNNNLXAHBBG77QW2QKGQEZOLSE7Q@googlegroups.com>
Received: from mailout4.w1.samsung.com (mailout4.w1.samsung.com. [210.118.77.14])
        by gmr-mx.google.com with ESMTPS id ui7si443896pab.0.2016.01.21.17.02.18
        for <rtc-linux@googlegroups.com>
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Thu, 21 Jan 2016 17:02:19 -0800 (PST)
Received: from eucpsbgm2.samsung.com (unknown [203.254.199.245])
 by mailout4.w1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0O1B00HQ7XJQRB50@mailout4.w1.samsung.com> for
 rtc-linux@googlegroups.com; Fri, 22 Jan 2016 01:02:14 +0000 (GMT)
Subject: [rtc-linux] Re: [PATCH v2 03/10] rtc: max77686: Use usleep_range()
 instead of msleep()
To: Javier Martinez Canillas <javier@osg.samsung.com>,
 linux-kernel@vger.kernel.org
References: <1453407813-14646-1-git-send-email-javier@osg.samsung.com>
 <1453407813-14646-4-git-send-email-javier@osg.samsung.com>
Cc: Kukjin Kim <kgene@kernel.org>, rtc-linux@googlegroups.com,
 Chanwoo Choi <cw00.choi@samsung.com>,
 Alexandre Belloni <alexandre.belloni@free-electrons.com>,
 Laxman Dewangan <ldewangan@nvidia.com>, linux-samsung-soc@vger.kernel.org
From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Message-id: <56A17F99.6080903@samsung.com>
Date: Fri, 22 Jan 2016 10:02:17 +0900
MIME-version: 1.0
In-reply-to: <1453407813-14646-4-git-send-email-javier@osg.samsung.com>
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

On 22.01.2016 05:23, Javier Martinez Canillas wrote:
> Documentation/timers/timers-howto.txt suggest to use usleep_range()
> instead of msleep() for small msec (1ms - 20ms) since msleep() will
> often sleep for 20ms for any value in that range.
> 
> This is fine in this case since 16ms is the _minimum_ delay required
> by max77686 for an RTC update but by using usleep_range() instead of
> msleep(), the driver can support other RTC IP blocks with a shorter
> minimum delay (i.e: in the range of usecs instead of msecs).
> 
> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
> Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> 
> ---
> 
> Changes in v2:
> - Add Krzysztof Kozlowski's Reviewed-by tag to patch #3.
> - Fix typo error in changelog. Suggested by Krzysztof Kozlowski.
> 
>  drivers/rtc/rtc-max77686.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 

Tested on Trats2 board with max77686:
Tested-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

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
