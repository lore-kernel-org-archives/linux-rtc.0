Return-Path: <rtc-linux+bncBDG6R4VLYILBBEXEVK3QKGQEQQOYQVQ@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mailapp01.imgtec.com (mailapp01.imgtec.com. [195.59.15.196])
        by gmr-mx.google.com with ESMTP id c7si279319wmf.2.2016.03.17.06.33.06
        for <rtc-linux@googlegroups.com>;
        Thu, 17 Mar 2016 06:33:06 -0700 (PDT)
Subject: [rtc-linux] Re: [PATCH 3/5] rtc: rtc-jz4740: Add support for devicetree
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>, Paul Cercueil
	<paul@crapouillou.net>
References: <1457217531-26064-1-git-send-email-paul@crapouillou.net>
 <1457217531-26064-3-git-send-email-paul@crapouillou.net>
 <20160317120804.GD3362@piout.net>
CC: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark
 Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>, Ralf Baechle <ralf@linux-mips.org>,
	Alessandro Zummo <a.zummo@towertech.it>, Paul Burton
	<paul.burton@imgtec.com>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-mips@linux-mips.org>,
	<rtc-linux@googlegroups.com>
From: Harvey Hunt <harvey.hunt@imgtec.com>
Message-ID: <56EAB210.70900@imgtec.com>
Date: Thu, 17 Mar 2016 13:33:04 +0000
MIME-Version: 1.0
In-Reply-To: <20160317120804.GD3362@piout.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Hi Alexandre,

On 17/03/16 12:08, Alexandre Belloni wrote:
> On 05/03/2016 at 23:38:49 +0100, Paul Cercueil wrote :
>> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
>> ---
>>   drivers/rtc/rtc-jz4740.c | 16 +++++++++++++++-
>>   1 file changed, 15 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/rtc/rtc-jz4740.c b/drivers/rtc/rtc-jz4740.c
>> index 47617bd..3914b1c 100644
>> --- a/drivers/rtc/rtc-jz4740.c
>> +++ b/drivers/rtc/rtc-jz4740.c
>> @@ -17,6 +17,7 @@
>>   #include <linux/io.h>
>>   #include <linux/kernel.h>
>>   #include <linux/module.h>
>> +#include <linux/of_device.h>
>>   #include <linux/platform_device.h>
>>   #include <linux/rtc.h>
>>   #include <linux/slab.h>
>> @@ -245,6 +246,13 @@ void jz4740_rtc_poweroff(struct device *dev)
>>   }
>>   EXPORT_SYMBOL_GPL(jz4740_rtc_poweroff);
>>
>> +static const struct of_device_id jz4740_rtc_of_match[] = {
>> +	{ .compatible = "ingenic,jz4740-rtc", .data = (void *) ID_JZ4740 },
>> +	{ .compatible = "ingenic,jz4780-rtc", .data = (void *) ID_JZ4780 },
>
> ingenic is not in Documentation/devicetree/bindings/vendor-prefixes.txt,
> you have to add it there before using it.

Ingenic is in vendor-prefixes.txt - it was added by Commit f289cc7 
("devicetree/bindings: add Ingenic Semiconductor vendor prefix").

Thanks,

Harvey

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
