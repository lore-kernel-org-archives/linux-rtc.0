Return-Path: <rtc-linux+bncBAABBFOG43CQKGQEMT4G3JQ@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from osg.samsung.com (ec2-52-27-115-49.us-west-2.compute.amazonaws.com. [52.27.115.49])
        by gmr-mx.google.com with ESMTP id h79si155483pfh.2.2017.03.03.09.08.36
        for <rtc-linux@googlegroups.com>;
        Fri, 03 Mar 2017 09:08:36 -0800 (PST)
Subject: [rtc-linux] Re: [PATCH 00/13] rtc: Add OF device table to I2C drivers
 that are missing it
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
References: <20170303142925.17915-1-javier@osg.samsung.com>
 <20170303150134.qacfd7ccemqxwq3p@piout.net>
 <abb5cd41-b904-1512-7520-e4a89f26d4b3@osg.samsung.com>
 <20170303160400.2n6vwbypxvt62nl4@piout.net>
From: Javier Martinez Canillas <javier@osg.samsung.com>
Cc: linux-kernel@vger.kernel.org, rtc-linux@googlegroups.com,
 Alessandro Zummo <a.zummo@towertech.it>
Message-ID: <84e4a5d9-0db0-6614-f602-14ed6daf5da0@osg.samsung.com>
Date: Fri, 3 Mar 2017 14:08:24 -0300
MIME-Version: 1.0
In-Reply-To: <20170303160400.2n6vwbypxvt62nl4@piout.net>
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

Sorry for the long email...

On 03/03/2017 01:04 PM, Alexandre Belloni wrote:
> On 03/03/2017 at 12:27:23 -0300, Javier Martinez Canillas wrote:
>> On 03/03/2017 12:01 PM, Alexandre Belloni wrote:
>>> On 03/03/2017 at 11:29:11 -0300, Javier Martinez Canillas wrote:
>>>> This series add OF device ID tables to RTC I2C drivers whose devices are
>>>> either used in Device Tree source files or are listed in binding docs as
>>>> a compatible string.
>>>>
>>>> That's done because the plan is to change the I2C core to report proper OF
>>>> modaliases instead of always reporting a MODALIAS=i2c:<foo> regardless if
>>>> a device was registered via DT or using the legacy platform data.
>>>>
>>>
>>> Doesn't that break the DT ABI for all i2c devices? A lot of people are
>>> getting the vendor wrong in the compatible string and because the i2c
>>> core doesn't care, the driver is still probed. Dropping that will break
>>> all those DTBs.
>>> Or will that only affect module autoload?
>>>
>>
>> The change will only be for module autoload. The I2C core will still attempt
>> to match the I2C device ID table as a fallback if fails to match the OF one.
>> So there's no change in the match logic for drivers that do the wrong thing.
>>
> 
> I'm probably not seeing the big picture here but then I don't understand

The big picture is to make the I2C subsystem to be consistent with other
subsystems.

Take the platform bus as an example, platform drivers define an OF ID table
if the platform devices are going to be registered via DT and a platform ID
table if the driver supports legacy platform device registration.

But that's not the case for I2C, either only a I2C device ID table is defined
(and the vendor prefix not used which lead to the current situation of wrong
DT's) or a OF device ID table is used to match but still a I2C device table
with duplicated entries is needed only to make the driver module to autoload.

> why you are reworking the id->driver_data handling and using
> of_device_get_match_data instead.
>

I meant that the proposed change to the I2C core is only for module autoload.
The driver changes are for both match and autoload (once I2C core is fixed).

So the change to use the of_device_id .data instead of the i2c_device_id
.driver_data is to use the correct entry in case the I2C core matches using
the OF table instead of the I2C table. Another option is to do the opposite
of what's needed currently, that is to have an I2C table to match and only
use the OF table to populate the OF aliases in the module (i.e: not setting
the .of_match_table field).

But I think that if the device is registered via OF, then the correct thing
to do is to match using the OF table and the OF aliases for module autoload.
 
> If this is related to b8a1a4cd5a98a2adf8dfd6902cd98e57d910ee12, that is
> a completely different issue (and that is probably the kind of changes
> that should be notified to maintainers).
>

It's related in some way. There were two reasons why a I2C driver required a
I2C table:

1) Because their probe function received a struct i2c_device_id as argument.

2) Because the reported MODALIAS is always i2c:<foo> regardless of how the
   device was registered (legacy platform dev or DT).

Lee's commit that you mention solves (1) and I'm trying to solve (2).

>> If someone is using a wrong vendor prefix and the DT can't be changed, then
>> an entry in the OF device ID table has to be added for "wrong_vendor,device"
>> so the MODALIAS uevent can be "of:N*T*wrong_vendor,device".
>>
> 
> And then, we end up with a crap load of useless strings that are matched
> against at boottime...
> I'm saying that because all the rv3029 compatible strings are wrong.
> 

Yeah... that's the joy of the DT backward compatibility. The reason why added
those (wrong) compatibles for rv3029 is because there are mainline users that
are either not using a vendor or using a wrong one (mc instead of microchip).

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
