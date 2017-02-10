Return-Path: <rtc-linux+bncBDA63GMRREGBB44E7HCAKGQEWWTSAIA@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from marmot.wormnet.eu (marmot.wormnet.eu. [2a03:9800:10:2d:3203:b3a5:8bdc:5b68])
        by gmr-mx.google.com with ESMTPS id y19si190785wmd.0.2017.02.10.14.45.06
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Feb 2017 14:45:06 -0800 (PST)
Date: Fri, 10 Feb 2017 22:45:05 +0000
From: Alexander Clouter <alex@digriz.org.uk>
To: H Hartley Sweeten <hsweeten@visionengravers.com>
Cc: rtc-linux@googlegroups.com
Subject: [rtc-linux] Re: [PATCH 0/3] rtc: m48t86: cleanup driver and add NVRAM support
Message-ID: <20170210224505.GK24768@quatermain.digriz.org.uk>
References: <20170210181157.6283-1-hsweeten@visionengravers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
In-Reply-To: <20170210181157.6283-1-hsweeten@visionengravers.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On Fri, Feb 10, 2017 at 11:11:54AM -0700, H Hartley Sweeten wrote:
>
>Currently the ts78xx platform does some "probing" of the rtc NVRAM to see
>if it is actually present before registering the rtc device. This "probing"
>just checks if the NVRAM is present by reading/writing the last two bytes
>of the NVRAM. I'm not sure if this is really necessary. If it can be removed
>all the m48t86_ops stuff could also be removed from this driver, along with
>platform_data/rtc-m48t86.h.

The RTC is an optional upgrade on the TS-7800[1].  Not sure what would happen 
if the RTC driver kicks in with no actual RTC being present?

If I was to do this over again, I probably would have the driver check that the 
HMS is actually incrementing after being instantiated, if it looks weird then 
to unbind its-self.

My TS-7800 is still clunking away in the corner though on an aging 2.6.32 
kernel.  I keep meaning to update it, might be some time before I can though.

Cheers

[1] https://www.embeddedarm.com/products/TS-7800 - 'Order' tab

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
