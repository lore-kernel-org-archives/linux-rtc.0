Return-Path: <rtc-linux+bncBC2IT2GSZUDRBY4H3DBQKGQEEXXVFNY@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com. [91.207.212.93])
        by gmr-mx.google.com with ESMTPS id h198si117638wmg.1.2017.01.11.02.07.30
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Jan 2017 02:07:30 -0800 (PST)
Subject: [rtc-linux] Re: [PATCHv3 3/8] rtc: add STM32 RTC driver
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
References: <1483623809-29937-1-git-send-email-amelie.delaunay@st.com>
 <1483623809-29937-4-git-send-email-amelie.delaunay@st.com>
 <20170111000803.mlie6kizcsj2o7lh@piout.net>
CC: Alessandro Zummo <a.zummo@towertech.it>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Coquelin
	<mcoquelin.stm32@gmail.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        Russell King <linux@armlinux.org.uk>,
        "rtc-linux@googlegroups.com"
	<rtc-linux@googlegroups.com>,
        "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        Gabriel FERNANDEZ <gabriel.fernandez@st.com>
From: Amelie DELAUNAY <amelie.delaunay@st.com>
Message-ID: <1feb3a23-7450-2b5c-9c1c-c7ecacd7fa17@st.com>
Date: Wed, 11 Jan 2017 11:07:16 +0100
MIME-Version: 1.0
In-Reply-To: <20170111000803.mlie6kizcsj2o7lh@piout.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Hi Alexandre,

On 01/11/2017 01:08 AM, Alexandre Belloni wrote:
> Looks good to me, however...
>
>
> On 05/01/2017 at 14:43:24 +0100, Amelie Delaunay wrote :
>> +struct stm32_rtc {
>> +	struct rtc_device *rtc_dev;
>> +	void __iomem *base;
>> +	struct clk *ck_rtc;
>> +	spinlock_t lock; /* Protects registers accesses */
>
> This spinlock seems to be useless, the rtc ops_lock is already
> protecting everywhere it is taken.
>
After having a deeper look on ops_lock, it seems this one is sufficient, 
so I'll remove all spinlock uses in this driver.
>> +	int irq_alarm;
>> +};
>> +
>
> [...]
>
>> +static int stm32_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
>> +{
>> +	struct stm32_rtc *rtc = dev_get_drvdata(dev);
>> +	struct rtc_time *tm = &alrm->time;
>> +	unsigned long irqflags;
>> +	unsigned int cr, isr, alrmar;
>> +	int ret = 0;
>> +
>> +	if (rtc_valid_tm(tm)) {
>> +		dev_err(dev, "Alarm time not valid.\n");
>> +		return -EINVAL;
>
> This will never happen, tm is already checked multiple times (up to
> three) in the core before this function can be called.
>
You're right. I'll remove all rtc_valid_tm calls.
>> +	}
>> +
>
> You don't need to resend the whole series, just this patch. I'll take
> 2/8 and 3/8, the other ones can go through the stm32 tree.
>
Thanks for reviewing. I send a v4 for this patch right now.

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
