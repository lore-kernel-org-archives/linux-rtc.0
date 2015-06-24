Return-Path: <rtc-linux+bncBCO3XAUMTIFRBOVLVOWAKGQE2PFX47I@googlegroups.com>
Received: from bear.ext.ti.com (bear.ext.ti.com. [192.94.94.41])
        by gmr-mx.google.com with ESMTPS id f17si220781igt.0.2015.06.24.09.07.21
        for <rtc-linux@googlegroups.com>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 24 Jun 2015 09:07:21 -0700 (PDT)
Message-ID: <558AD5B1.8030406@ti.com>
Date: Wed, 24 Jun 2015 11:07:13 -0500
From: Nishanth Menon <nm@ti.com>
MIME-Version: 1.0
To: Grygorii Strashko <grygorii.strashko@ti.com>,
        Alexandre Belloni
	<alexandre.belloni@free-electrons.com>,
        Alessandro Zummo
	<a.zummo@towertech.it>
CC: <linux-kernel@vger.kernel.org>, <rtc-linux@googlegroups.com>,
        <linux-omap@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <balbi@ti.com>
Subject: [rtc-linux] Re: [PATCH V2 4/5] drivers/rtc/rtc-ds1307.c: Support
 optional wakeup interrupt source
References: <1435076114-12416-1-git-send-email-nm@ti.com> <1435076114-12416-5-git-send-email-nm@ti.com> <558ACE87.6040509@ti.com>
In-Reply-To: <558ACE87.6040509@ti.com>
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

On 06/24/2015 10:36 AM, Grygorii Strashko wrote:
> On 06/23/2015 07:15 PM, Nishanth Menon wrote:
[...]

>> +		ds1307->wakeirq = of_irq_get(node, 1);
>> +		if (ds1307->wakeirq <= 0) {
>> +			if (ds1307->wakeirq == -EPROBE_DEFER) {
>> +				err = ds1307->wakeirq;
>> +				goto exit;
>> +			}
>> +			ds1307->wakeirq = 0;
>> +			goto no_irq;
>> +		}
> 
> Might be above code could be done a little bit simpler?
> 
> 		err = of_irq_get(node, 1);
> 		if (err <= 0) {
> 			if (err == -EPROBE_DEFER)
> 				goto exit;
> 			goto no_irq;

I had considered it, but problem with this approach is that is err
does not get reset back to 0 and probe will fail as it flows through
the rest of the code.. which is not our intent.

> 		}
> 		ds1307->wakeirq = err;
> 





-- 
Regards,
Nishanth Menon

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
