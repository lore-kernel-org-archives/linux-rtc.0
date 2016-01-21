Return-Path: <rtc-linux+bncBAABBLXBQO2QKGQEJBZFTAY@googlegroups.com>
Received: from lists.s-osg.org (lists.s-osg.org. [54.187.51.154])
        by gmr-mx.google.com with ESMTP id ui7si191458pab.0.2016.01.21.06.52.30
        for <rtc-linux@googlegroups.com>;
        Thu, 21 Jan 2016 06:52:30 -0800 (PST)
Subject: [rtc-linux] Re: [PATCH 2/8] rtc: max77686: Use usleep_range() instead
 of msleep()
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>,
 linux-kernel@vger.kernel.org
References: <1453310088-29985-1-git-send-email-javier@osg.samsung.com>
 <1453310088-29985-3-git-send-email-javier@osg.samsung.com>
 <56A02845.3010008@samsung.com>
Cc: Kukjin Kim <kgene@kernel.org>, rtc-linux@googlegroups.com,
 Chanwoo Choi <cw00.choi@samsung.com>,
 Alexandre Belloni <alexandre.belloni@free-electrons.com>,
 Laxman Dewangan <ldewangan@nvidia.com>, linux-samsung-soc@vger.kernel.org
From: Javier Martinez Canillas <javier@osg.samsung.com>
Message-ID: <56A0F0AA.6080202@osg.samsung.com>
Date: Thu, 21 Jan 2016 11:52:26 -0300
MIME-Version: 1.0
In-Reply-To: <56A02845.3010008@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Hello Krzysztof,

On 01/20/2016 09:37 PM, Krzysztof Kozlowski wrote:
> On 21.01.2016 02:14, Javier Martinez Canillas wrote:
>> Documentation/timers/timers-howto.txt suggest to use usleep_range()
>> instead of msleep() for small msec (1ms - 20ms) since msleep() will
>> often sleep for 20ms for any value in that range.
>>
>> This is fine in this case since 16ms is the _minimum_ delay required
>> by max77686 for an RTC update but by using usleep_range() instead of
>> msleep(), the driver can support other RTC IP blocks with a shorter
>> minium delay (i.e: in the range of usecs insted of msecs).
>
> s/minium/minimum/
> s/insted/instead/
>

Fixed.

>>
>> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
>> ---
>>
>>   drivers/rtc/rtc-max77686.c | 5 +++--
>>   1 file changed, 3 insertions(+), 2 deletions(-)
>
> Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
>

Thanks a lot for your review.
  
> Best regards,
> Krzysztof
>

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America

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
