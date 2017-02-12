Return-Path: <rtc-linux+bncBDA63GMRREGBBQOV73CAKGQEVLJJZGY@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com. [66.111.4.28])
        by gmr-mx.google.com with ESMTPS id f187si658202ywc.0.2017.02.11.16.22.25
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 11 Feb 2017 16:22:25 -0800 (PST)
Date: Sun, 12 Feb 2017 00:22:23 +0000
From: Alexander Clouter <alex@digriz.org.uk>
To: Hartley Sweeten <HartleyS@visionengravers.com>
Cc: "rtc-linux@googlegroups.com" <rtc-linux@googlegroups.com>
Subject: [rtc-linux] Re: [PATCH 0/3] rtc: m48t86: cleanup driver and add NVRAM support
Message-ID: <20170212002223.GB31755@quatermain.digriz.org.uk>
References: <20170210181157.6283-1-hsweeten@visionengravers.com>
 <20170210224505.GK24768@quatermain.digriz.org.uk>
 <SN1PR0101MB1565C312398D334B5B81B2E1D0440@SN1PR0101MB1565.prod.exchangelabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
In-Reply-To: <SN1PR0101MB1565C312398D334B5B81B2E1D0440@SN1PR0101MB1565.prod.exchangelabs.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On Fri, Feb 10, 2017 at 10:56:12PM +0000, Hartley Sweeten wrote:
>On Friday, February 10, 2017 3:45 PM, Alexander Clouter wrote:
>> On Fri, Feb 10, 2017 at 11:11:54AM -0700, H Hartley Sweeten wrote:
>>>
>>>Currently the ts78xx platform does some "probing" of the rtc NVRAM to see
>>>if it is actually present before registering the rtc device. This "probing"
>>>just checks if the NVRAM is present by reading/writing the last two bytes
>>>of the NVRAM. I'm not sure if this is really necessary. If it can be removed
>>>all the m48t86_ops stuff could also be removed from this driver, along with
>>>platform_data/rtc-m48t86.h.
>>
>> The RTC is an optional upgrade on the TS-7800[1].  Not sure what would happen
>> if the RTC driver kicks in with no actual RTC being present?
>
>How about modifying the m48t86 probe so that it does the NVRAM check that
>you are doing in the ts78xx platform code. If the NVRAM check fails the probe
>will return -ENODEV. Reading the NVRAM to check the 0x55 0xaa signature in
>the last locations might be adequate. Not sure if making sure they can be written
>is necessary.

Its not a signature, its just some spare usable bytes at the end of the NVRAM; 
I cribbed the probing routing from Technologic Systems[1].  They seem to use a 
similar routine[2] for the TS-7200 too.

Looks like it would be fine to move this all into the driver its-self.

Cheers

[1] ftp://ftp.embeddedarm.com/ts-arm-sbc/ts-7800-linux/samples/rtc7800.c
[2] ftp://ftp.embeddedarm.com/ts-arm-sbc/ts-7200-linux/sources/rtc.c

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
