Return-Path: <rtc-linux+bncBAABBI6I6SUAKGQE5KI32MY@googlegroups.com>
Received: from bear.ext.ti.com (bear.ext.ti.com. [192.94.94.41])
        by gmr-mx.google.com with ESMTPS id e4si1773264igt.3.2015.04.02.04.12.35
        for <rtc-linux@googlegroups.com>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 02 Apr 2015 04:12:35 -0700 (PDT)
Message-ID: <551D241C.8040709@ti.com>
Date: Thu, 2 Apr 2015 16:42:28 +0530
From: Lokesh Vutla <lokeshvutla@ti.com>
MIME-Version: 1.0
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        <rtc-linux@googlegroups.com>
CC: <a.zummo@towertech.it>, <t-kristo@ti.com>, <nsekhar@ti.com>,
        <linux-omap@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [rtc-linux] [PATCH 1/3] rtc: omap: Unlock and Lock rtc registers
 before and after register writes
References: <1427867698-1326-1-git-send-email-lokeshvutla@ti.com> <1427867698-1326-2-git-send-email-lokeshvutla@ti.com> <20150401155204.GC20669@piout.net>
In-Reply-To: <20150401155204.GC20669@piout.net>
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

Hi,

On Wednesday 01 April 2015 09:22 PM, Alexandre Belloni wrote:
> Hi,
> 
> On 01/04/2015 at 11:24:56 +0530, Lokesh Vutla wrote :
>> RTC module contains a kicker mechanism to prevent any spurious writes
>> from changing the register values. This mechanism requires two MMR
>> writes to the KICK0 and KICK1 registers with exact data values
>> before the kicker lock mechanism is released.
>>
>> Currently the driver release the lock in the probe and leaves it enabled
>> until the rtc driver removal. This eliminates the idea of preventing
>> spurious writes when RTC driver is loaded.
>> So implement rtc lock and unlock functions before and after register writes.
>>
>> Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
>> ---
>> - This is as advised by Paul to implement lock and unlock functions in
>>   the driver and not to unlock and leave it in probe.
>>   The same discussion can be seen here:
>>   http://www.mail-archive.com/linux-omap%40vger.kernel.org/msg111588.html
>>
>>  drivers/rtc/rtc-omap.c | 46 ++++++++++++++++++++++++++++++++++++++--------
>>  1 file changed, 38 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/rtc/rtc-omap.c b/drivers/rtc/rtc-omap.c
>> index 8e5851a..96cc613 100644
>> --- a/drivers/rtc/rtc-omap.c
>> +++ b/drivers/rtc/rtc-omap.c
>> @@ -156,6 +156,22 @@ static inline void rtc_writel(struct omap_rtc *rtc, unsigned int reg, u32 val)
>>  	writel(val, rtc->base + reg);
>>  }
>>  
>> +static void rtc_unlock(struct omap_rtc *rtc)
>> +{
>> +	if (rtc->type->has_kicker) {
> 
> Instead of testing for has_kicker each time, I would add .lock and
> .unlock to omap_rtc_device_type and directly use rtc->type->lock and
> rtc->type->unlock.
Makes sense. I have posted v2 of my series updating this.

Thanks and regards,
Lokesh
> 
>> +		rtc_writel(rtc, OMAP_RTC_KICK0_REG, KICK0_VALUE);
>> +		rtc_writel(rtc, OMAP_RTC_KICK1_REG, KICK1_VALUE);
>> +	}
>> +}
>> +

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
