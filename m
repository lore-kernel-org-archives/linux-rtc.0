Return-Path: <rtc-linux+bncBAABB3WUXS3AKGQEAEN42UA@googlegroups.com>
Received: from email.microchip.com (exsmtp01.microchip.com. [198.175.253.37])
        by gmr-mx.google.com with ESMTPS id yd9si1292668pab.1.2016.02.25.08.23.10
        for <rtc-linux@googlegroups.com>
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 25 Feb 2016 08:23:10 -0800 (PST)
Subject: [rtc-linux] Re: [PATCH v2 2/2] rtc: rtc-pic32: Add PIC32 real time
 clock driver
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
References: <1455905390-3491-2-git-send-email-joshua.henderson@microchip.com>
 <20160224222555.GA12073@piout.net>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Rob Herring
	<robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland
	<mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar
 Gala <galak@codeaurora.org>, Alessandro Zummo <a.zummo@towertech.it>,
	<rtc-linux@googlegroups.com>
From: Joshua Henderson <joshua.henderson@microchip.com>
Message-ID: <56CF2A9B.5080005@microchip.com>
Date: Thu, 25 Feb 2016 09:23:55 -0700
MIME-Version: 1.0
In-Reply-To: <20160224222555.GA12073@piout.net>
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 02/24/2016 03:25 PM, Alexandre Belloni wrote:
> Hi,
> 
> On 19/02/2016 at 11:09:45 -0700, Joshua Henderson wrote :
>> +static int pic32_rtc_gettime(struct device *dev, struct rtc_time *rtc_tm)
>> +{
>> +	struct pic32_rtc_dev *pdata = dev_get_drvdata(dev);
>> +	void __iomem *base = pdata->reg_base;
>> +	unsigned int tries = 0;
>> +
>> +	clk_enable(pdata->clk);
>> +
>> +	do {
>> +		rtc_tm->tm_hour = readb(base + PIC32_RTCHOUR);
>> +		rtc_tm->tm_min = readb(base + PIC32_RTCMIN);
>> +		rtc_tm->tm_mon  = readb(base + PIC32_RTCMON);
>> +		rtc_tm->tm_mday = readb(base + PIC32_RTCDAY);
>> +		rtc_tm->tm_year = readb(base + PIC32_RTCYEAR);
>> +		rtc_tm->tm_sec  = readb(base + PIC32_RTCSEC);
>> +
>> +		/*
>> +		 * The only way to work out whether the system was mid-update
>> +		 * when we read it is to check the second counter, and if it
>> +		 * is zero, then we re-try the entire read.
>> +		 */
>> +		tries = 1;
>> +	} while (rtc_tm->tm_sec == 0 && tries < 2);
>> +
> 
> This doesn't seem right. It will wait up to a second as tries will
> always be less than 2, this is probably not what you want.

Dang good catch.  When fixed, it will work as expected:

# hwclock
tries 1
Sun Oct 17 19:23:59 2010  0.000000 seconds
# hwclock
tries 1
tries 2
Sun Oct 17 19:24:00 2010  0.000000 seconds
# hwclock
tries 1
Sun Oct 17 19:24:01 2010  0.000000 seconds

Josh

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
