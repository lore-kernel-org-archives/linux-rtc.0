Return-Path: <rtc-linux+bncBCKYNX7Y3IMBBWEK43CQKGQE3WX6OBA@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (mail.free-electrons.com. [62.4.15.54])
        by gmr-mx.google.com with ESMTP id 14si231801wmn.2.2017.03.03.07.01.44
        for <rtc-linux@googlegroups.com>;
        Fri, 03 Mar 2017 07:01:44 -0800 (PST)
Date: Fri, 3 Mar 2017 16:01:34 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Javier Martinez Canillas <javier@osg.samsung.com>
Cc: linux-kernel@vger.kernel.org, rtc-linux@googlegroups.com,
	Alessandro Zummo <a.zummo@towertech.it>
Subject: [rtc-linux] Re: [PATCH 00/13] rtc: Add OF device table to I2C drivers
 that are missing it
Message-ID: <20170303150134.qacfd7ccemqxwq3p@piout.net>
References: <20170303142925.17915-1-javier@osg.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <20170303142925.17915-1-javier@osg.samsung.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Hi,

On 03/03/2017 at 11:29:11 -0300, Javier Martinez Canillas wrote:
> This series add OF device ID tables to RTC I2C drivers whose devices are
> either used in Device Tree source files or are listed in binding docs as
> a compatible string.
> 
> That's done because the plan is to change the I2C core to report proper OF
> modaliases instead of always reporting a MODALIAS=i2c:<foo> regardless if
> a device was registered via DT or using the legacy platform data.
> 

Doesn't that break the DT ABI for all i2c devices? A lot of people are
getting the vendor wrong in the compatible string and because the i2c
core doesn't care, the driver is still probed. Dropping that will break
all those DTBs.
Or will that only affect module autoload?


-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
