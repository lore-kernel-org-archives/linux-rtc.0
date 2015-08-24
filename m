Return-Path: <rtc-linux+bncBD66BCOYSQBBBCOA5KXAKGQEVQUMB2Y@googlegroups.com>
Received: from bear.ext.ti.com (bear.ext.ti.com. [192.94.94.41])
        by gmr-mx.google.com with ESMTPS id o7si859339igp.1.2015.08.23.21.39.37
        for <rtc-linux@googlegroups.com>
        (version=TLS1 cipher=RC4-SHA bits=128/128);
        Sun, 23 Aug 2015 21:39:37 -0700 (PDT)
Message-ID: <55DAA000.1050301@ti.com>
Date: Mon, 24 Aug 2015 10:09:28 +0530
From: Keerthy <a0393675@ti.com>
MIME-Version: 1.0
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        Keerthy
	<j-keerthy@ti.com>
CC: <tony@atomide.com>, <bcousson@baylibre.com>, <johan@kernel.org>,
        <linux-omap@vger.kernel.org>, <rtc-linux@googlegroups.com>,
        <grygorii.strashko@ti.com>
Subject: [rtc-linux] Re: [PATCH v5 2/3] rtc: omap: Add internal clock enabling support
References: <1439890876-19024-1-git-send-email-j-keerthy@ti.com> <1439890876-19024-3-git-send-email-j-keerthy@ti.com> <20150821213642.GJ3769@piout.net>
In-Reply-To: <20150821213642.GJ3769@piout.net>
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



On Saturday 22 August 2015 03:06 AM, Alexandre Belloni wrote:
> Hi,
>
> On 18/08/2015 at 15:11:15 +0530, Keerthy wrote :
>> @@ -681,6 +688,9 @@ static int __exit omap_rtc_remove(struct platform_device *pdev)
>>
>>   	device_init_wakeup(&pdev->dev, 0);
>>
>> +	if (!IS_ERR(rtc->clk))
>> +		clk_disable_unprepare(rtc->clk);
>> +
>>   	rtc->type->unlock(rtc);
>>   	/* leave rtc running, but disable irqs */
>
> Is it actually still running once the clock is disabled?

With the current set of patches on Aegis the disabling the external 
clock toggles it to be sourced from internal clock. So rtc will still be 
running.

>
>>   	rtc_write(rtc, OMAP_RTC_INTERRUPTS_REG, 0);
>
>
>

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
