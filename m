Return-Path: <rtc-linux+bncBCH67JWTV4DBBR4CYXFAKGQEYX32U3A@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail-wm0-x244.google.com (mail-wm0-x244.google.com. [2a00:1450:400c:c09::244])
        by gmr-mx.google.com with ESMTPS id 5si116277wmj.1.2017.06.26.10.15.51
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Jun 2017 10:15:51 -0700 (PDT)
Received: by mail-wm0-x244.google.com with SMTP id j85so1413666wmj.0
        for <rtc-linux@googlegroups.com>; Mon, 26 Jun 2017 10:15:51 -0700 (PDT)
Subject: [rtc-linux] Re: [PATCH 2/2] rtc: brcmstb-waketimer: Add Broadcom STB wake-timer
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: linux-kernel@vger.kernel.org, Brian Norris <computersforpeace@gmail.com>,
 Markus Mayer <mmayer@broadcom.com>, Alessandro Zummo <a.zummo@towertech.it>,
 Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Gregory Fong <gregory.0xf0@gmail.com>,
 "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE"
 <bcm-kernel-feedback-list@broadcom.com>,
 "open list:REAL TIME CLOCK (RTC) SUBSYSTEM" <rtc-linux@googlegroups.com>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>,
 "moderated list:BROADCOM BCM7XXX ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
References: <20170615195904.12653-1-f.fainelli@gmail.com>
 <20170615195904.12653-3-f.fainelli@gmail.com>
 <20170624185942.vq656pjxbqnqdhll@piout.net>
From: Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <35c43786-ee58-130c-2ecd-5577197bd5aa@gmail.com>
Date: Mon, 26 Jun 2017 10:15:46 -0700
MIME-Version: 1.0
In-Reply-To: <20170624185942.vq656pjxbqnqdhll@piout.net>
Content-Type: text/plain; charset="UTF-8"
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 06/24/2017 11:59 AM, Alexandre Belloni wrote:
> Hi,
> 
> This seems mostly good.
> 
> On 15/06/2017 at 12:59:04 -0700, Florian Fainelli wrote:
>> +static void wktmr_read(struct brcmstb_waketmr *timer,
>> +		       struct wktmr_time *t)
>> +{
>> +	u32 tmp;
>> +
> 
> To be sure, is this IP always 32bit, even on 64bit platforms?

Correct, it's only 32-bit capable (saw the recent discussions about the
2038yr "problem"...).

> 
>> +	do {
>> +		t->sec = readl_relaxed(timer->base + BRCMSTB_WKTMR_COUNTER);
>> +		tmp = readl_relaxed(timer->base + BRCMSTB_WKTMR_PRESCALER_VAL);
>> +	} while (tmp >= timer->rate);
>> +
>> +	t->pre = timer->rate - tmp;
>> +}
>> +
> 
> [...]
> 
>> +static int brcmstb_waketmr_settime(struct device *dev,
>> +				   struct rtc_time *tm)
>> +{
>> +	struct brcmstb_waketmr *timer = dev_get_drvdata(dev);
>> +	unsigned long sec;
>> +	int ret;
>> +
>> +	ret = rtc_valid_tm(tm);
>> +	if (ret)
>> +		return ret;
>> +
> 
> There is no way this function can be called without a valid tm. The only
> caller checks before calling.

OK.

> 
>> +	rtc_tm_to_time(tm, &sec);
>> +
>> +	dev_dbg(dev, "%s: sec=%ld\n", __func__, sec);
>> +	writel_relaxed(sec, timer->base + BRCMSTB_WKTMR_COUNTER);
>> +
>> +	return 0;
>> +}
>> +
>> +static int brcmstb_waketmr_getalarm(struct device *dev,
>> +				    struct rtc_wkalrm *alarm)
>> +{
>> +	struct brcmstb_waketmr *timer = dev_get_drvdata(dev);
>> +	unsigned long sec;
>> +	u32 reg;
>> +
>> +	sec = readl_relaxed(timer->base + BRCMSTB_WKTMR_ALARM);
>> +	if (sec == 0) {
>> +		/* Alarm is disabled */
>> +		alarm->enabled = 0;
>> +		alarm->time.tm_mon = -1;
>> +		alarm->time.tm_mday = -1;
>> +		alarm->time.tm_year = -1;
>> +		alarm->time.tm_hour = -1;
>> +		alarm->time.tm_min = -1;
>> +		alarm->time.tm_sec = -1;
> 
> This is not needed since d68778b80dd7

Great, I will take that out.

Do you care whether some dev_dbg() prints are left in the driver or
should I remove those in v2?

> 
>> +		dev_dbg(dev, "%s: alarm is disabled\n", __func__);
>> +	} else {
>> +		/* Alarm is enabled */
>> +		alarm->enabled = 1;
>> +		rtc_time_to_tm(sec, &alarm->time);
>> +		dev_dbg(dev, "%s: alarm is enabled\n", __func__);
>> +	}
>> +
>> +	reg = readl_relaxed(timer->base + BRCMSTB_WKTMR_EVENT);
>> +	alarm->pending = !!(reg & 1);
>> +	dev_dbg(dev, "%s: alarm pending=%d\n", __func__, alarm->pending);
>> +
>> +	return 0;
>> +}
> 


-- 
Florian

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
