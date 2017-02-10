Return-Path: <rtc-linux+bncBDKOZ45RYIGRBTES7HCAKGQEQZUFQPY@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from NAM03-BY2-obe.outbound.protection.outlook.com (mail-by2nam03on0102.outbound.protection.outlook.com. [104.47.42.102])
        by gmr-mx.google.com with ESMTPS id a17si370200itd.1.2017.02.10.15.14.20
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 10 Feb 2017 15:14:20 -0800 (PST)
From: Hartley Sweeten <HartleyS@visionengravers.com>
To: Alexander Clouter <alex@digriz.org.uk>
CC: "rtc-linux@googlegroups.com" <rtc-linux@googlegroups.com>
Subject: [rtc-linux] RE: [PATCH 0/3] rtc: m48t86: cleanup driver and add NVRAM support
Date: Fri, 10 Feb 2017 23:14:18 +0000
Message-ID: <SN1PR0101MB1565A68616512F4F0EE1D44FD0440@SN1PR0101MB1565.prod.exchangelabs.com>
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
>
> The RTC is an optional upgrade on the TS-7800[1].  Not sure what would happen 
> if the RTC driver kicks in with no actual RTC being present?

I think the only side-effect of the RTC not actually being present is that
rtc_valid_tm() will probably report an invalid time with the time is read
from the rtc.  The values read will probably just be random, unless the
board has pull-up/down resistors on the data bus....

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
