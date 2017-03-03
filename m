Return-Path: <rtc-linux+bncBAABBY4W43CQKGQEODLWT2Q@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from osg.samsung.com (ec2-52-27-115-49.us-west-2.compute.amazonaws.com. [52.27.115.49])
        by gmr-mx.google.com with ESMTP id g82si91086pfb.5.2017.03.03.07.27.30
        for <rtc-linux@googlegroups.com>;
        Fri, 03 Mar 2017 07:27:30 -0800 (PST)
Subject: [rtc-linux] Re: [PATCH 00/13] rtc: Add OF device table to I2C drivers
 that are missing it
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
References: <20170303142925.17915-1-javier@osg.samsung.com>
 <20170303150134.qacfd7ccemqxwq3p@piout.net>
From: Javier Martinez Canillas <javier@osg.samsung.com>
Cc: linux-kernel@vger.kernel.org, rtc-linux@googlegroups.com,
 Alessandro Zummo <a.zummo@towertech.it>
Message-ID: <abb5cd41-b904-1512-7520-e4a89f26d4b3@osg.samsung.com>
Date: Fri, 3 Mar 2017 12:27:23 -0300
MIME-Version: 1.0
In-Reply-To: <20170303150134.qacfd7ccemqxwq3p@piout.net>
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Hello Alexandre,

On 03/03/2017 12:01 PM, Alexandre Belloni wrote:
> Hi,
> 
> On 03/03/2017 at 11:29:11 -0300, Javier Martinez Canillas wrote:
>> This series add OF device ID tables to RTC I2C drivers whose devices are
>> either used in Device Tree source files or are listed in binding docs as
>> a compatible string.
>>
>> That's done because the plan is to change the I2C core to report proper OF
>> modaliases instead of always reporting a MODALIAS=i2c:<foo> regardless if
>> a device was registered via DT or using the legacy platform data.
>>
> 
> Doesn't that break the DT ABI for all i2c devices? A lot of people are
> getting the vendor wrong in the compatible string and because the i2c
> core doesn't care, the driver is still probed. Dropping that will break
> all those DTBs.
> Or will that only affect module autoload?
> 

The change will only be for module autoload. The I2C core will still attempt
to match the I2C device ID table as a fallback if fails to match the OF one.
So there's no change in the match logic for drivers that do the wrong thing.

If someone is using a wrong vendor prefix and the DT can't be changed, then
an entry in the OF device ID table has to be added for "wrong_vendor,device"
so the MODALIAS uevent can be "of:N*T*wrong_vendor,device".

This is the RFC patch for the I2C core so you get a better idea:

https://patchwork.kernel.org/patch/6903981/

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
