Return-Path: <rtc-linux+bncBAABBP45VOWAKGQE27WMUPI@googlegroups.com>
Received: from comal.ext.ti.com (comal.ext.ti.com. [198.47.26.152])
        by gmr-mx.google.com with ESMTP id pl5si210277igb.3.2015.06.24.08.37.34
        for <rtc-linux@googlegroups.com>;
        Wed, 24 Jun 2015 08:37:34 -0700 (PDT)
Message-ID: <558ACEB8.2020406@ti.com>
Date: Wed, 24 Jun 2015 18:37:28 +0300
From: Grygorii Strashko <grygorii.strashko@ti.com>
MIME-Version: 1.0
To: <balbi@ti.com>, Nishanth Menon <nm@ti.com>
CC: Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        Alessandro Zummo
	<a.zummo@towertech.it>,
        <linux-kernel@vger.kernel.org>, <rtc-linux@googlegroups.com>,
        <linux-omap@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
Subject: [rtc-linux] Re: [PATCH V2 0/5] drivers/rtc/rtc-ds1307.c: Basic
 cleanups and support for wakeupirq
References: <1435076114-12416-1-git-send-email-nm@ti.com> <20150624143432.GE21232@saruman.tx.rr.com>
In-Reply-To: <20150624143432.GE21232@saruman.tx.rr.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

On 06/24/2015 05:34 PM, Felipe Balbi wrote:
> Hi,
>
> On Tue, Jun 23, 2015 at 11:15:09AM -0500, Nishanth Menon wrote:
>> Hi,
>>
>> Here is the revamp of the patch posted eariler to support wakeupirq.
>> This series does a few cleanups as well prior to introducing the
>> generic apis required to support the wakeirq mechanism used on certain
>> TI SoCs. Cleanups done here are just minimal set of the cleanups we
>> discussed in [2].
>>
>> Series is based on next-20150623
>>
>> Test log: http://pastebin.ubuntu.com/11763002/
>>
>> NOTE1: I have only tested in mcp79410 device, and not on other
>> ds1307-rtc driver compatbile devices as I dont have any other.
>> additional testing might be nice to have.
>> NOTE2: there are additional fixes that linux-next seems to need but
>> those are in omap-rtc, cpufreq etc, but those are not related by the
>> ds-1307.
>>
>> V1: https://patchwork.kernel.org/patch/4759171/
>>
>> NOTE: Patch 5/5 of the series is meant to indicate the usage, and will
>> be reposted along with other wakeup sources to be enabled once the
>> driver changes are accepted.
>>
>> Felipe Balbi (1):
>>    drivers/rtc/rtc-ds1307.c: Convert to threaded IRQ
>>
>> Nishanth Menon (4):
>>    drivers/rtc/rtc-ds1307.c: Switch to managed irq allocation
>>    drivers/rtc/rtc-ds1307.c: Sort the headers
>>    drivers/rtc/rtc-ds1307.c: Support optional wakeup interrupt source
>
> for the series, except the patch which I wrote :
>
> Acked-by: Felipe Balbi <balbi@ti.com>
>

With minor comment to patch 4:
Reviewed-by: Grygorii Strashko <grygorii.strashko@ti.com>

-- 
regards,
-grygorii

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
