Return-Path: <rtc-linux+bncBDKOZ45RYIGRBDUK7HCAKGQES2C2FOA@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from NAM03-DM3-obe.outbound.protection.outlook.com (mail-dm3nam03on0126.outbound.protection.outlook.com. [104.47.41.126])
        by gmr-mx.google.com with ESMTPS id e196si453439itc.2.2017.02.10.14.56.14
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 10 Feb 2017 14:56:14 -0800 (PST)
From: Hartley Sweeten <HartleyS@visionengravers.com>
To: Alexander Clouter <alex@digriz.org.uk>
CC: "rtc-linux@googlegroups.com" <rtc-linux@googlegroups.com>
Subject: [rtc-linux] RE: [PATCH 0/3] rtc: m48t86: cleanup driver and add NVRAM support
Date: Fri, 10 Feb 2017 22:56:12 +0000
Message-ID: <SN1PR0101MB1565C312398D334B5B81B2E1D0440@SN1PR0101MB1565.prod.exchangelabs.com>
References: <20170210181157.6283-1-hsweeten@visionengravers.com>
 <20170210224505.GK24768@quatermain.digriz.org.uk>
In-Reply-To: <20170210224505.GK24768@quatermain.digriz.org.uk>
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On Friday, February 10, 2017 3:45 PM, Alexander Clouter wrote:
> On Fri, Feb 10, 2017 at 11:11:54AM -0700, H Hartley Sweeten wrote:
>>
>>Currently the ts78xx platform does some "probing" of the rtc NVRAM to see
>>if it is actually present before registering the rtc device. This "probing"
>>just checks if the NVRAM is present by reading/writing the last two bytes
>>of the NVRAM. I'm not sure if this is really necessary. If it can be removed
>>all the m48t86_ops stuff could also be removed from this driver, along with
>>platform_data/rtc-m48t86.h.
>
> The RTC is an optional upgrade on the TS-7800[1].  Not sure what would happen 
> if the RTC driver kicks in with no actual RTC being present?

How about modifying the m48t86 probe so that it does the NVRAM check that
you are doing in the ts78xx platform code. If the NVRAM check fails the probe
will return -ENODEV. Reading the NVRAM to check the 0x55 0xaa signature in
the last locations might be adequate. Not sure if making sure they can be written
is necessary.

Then you can just register the driver and let it figure out if the rtc is actually there.

>> If I was to do this over again, I probably would have the driver check that the 
>> HMS is actually incrementing after being instantiated, if it looks weird then 
>> to unbind its-self.

Or the probe could do that check and return -ENODEV if it fails.

> My TS-7800 is still clunking away in the corner though on an aging 2.6.32 
> kernel.  I keep meaning to update it, might be some time before I can though.

I recently got a TS-7300 from them. It has an even older 2.4 kernel. I have it
booting 4.9.9 right now and I'm trying to cleanup some of the driver code it
uses.

Regards,
Hartley

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
