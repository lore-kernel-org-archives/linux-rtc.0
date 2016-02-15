Return-Path: <rtc-linux+bncBAABBT6LQ63AKGQEDV4GZ6Y@googlegroups.com>
Received: from lists.s-osg.org (lists.s-osg.org. [54.187.51.154])
        by gmr-mx.google.com with ESMTP id ff2si2931508pad.2.2016.02.15.06.50.54
        for <rtc-linux@googlegroups.com>;
        Mon, 15 Feb 2016 06:50:55 -0800 (PST)
Subject: [rtc-linux] Re: [PATCH] rtc: mt6397: Add platform device ID table
To: Eddie Huang <eddie.huang@mediatek.com>
References: <1455016095-13724-1-git-send-email-javier@osg.samsung.com>
 <1455501497.7263.4.camel@mtksdaap41>
From: Javier Martinez Canillas <javier@osg.samsung.com>
Cc: linux-kernel@vger.kernel.org, Alessandro Zummo <a.zummo@towertech.it>,
 rtc-linux@googlegroups.com,
 Alexandre Belloni <alexandre.belloni@free-electrons.com>,
 linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org
Message-ID: <56C1E5C8.6040007@osg.samsung.com>
Date: Mon, 15 Feb 2016 11:50:48 -0300
MIME-Version: 1.0
In-Reply-To: <1455501497.7263.4.camel@mtksdaap41>
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

Hello Eddie,

On 02/14/2016 10:58 PM, Eddie Huang wrote:

[snip]

>> @@ -412,6 +418,7 @@ static struct platform_driver mtk_rtc_driver = {
>>   	},
>>   	.probe	= mtk_rtc_probe,
>>   	.remove = mtk_rtc_remove,
>> +	.id_table = mt6397_rtc_id,
>>   };
>>
>>   module_platform_driver(mtk_rtc_driver);
>> @@ -419,4 +426,3 @@ module_platform_driver(mtk_rtc_driver);
>>   MODULE_LICENSE("GPL v2");
>>   MODULE_AUTHOR("Tianping Fang <tianping.fang@mediatek.com>");
>>   MODULE_DESCRIPTION("RTC Driver for MediaTek MT6397 PMIC");
>> -MODULE_ALIAS("platform:mt6397-rtc");
>
> This patch looks good to me, but I am wondering, since we tend to use
> device tree method to match driver, do we still need support platform
> device ID ?
>

I'm not familiar with neither this IP block nor the SoC so it is up to
you. I just noticed this issue when reviewing a regulator driver for a
similar PMIC posted by someone from mediatek.

I thought platform device was needed since the driver has a MODULE_ALIAS()
but please let me know what you prefer and I can re-spin the patch and
just remove the MODULE_ALIAS() if that makes more sense for this platform.
  
> Eddie
>
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
