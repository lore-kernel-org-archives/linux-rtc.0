Return-Path: <rtc-linux+bncBAABBCGF43AAKGQEZSSBYFQ@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from EUR02-VE1-obe.outbound.protection.outlook.com (mail-eopbgr20043.outbound.protection.outlook.com. [40.107.2.43])
        by gmr-mx.google.com with ESMTPS id z76si437736pff.1.2016.11.02.01.23.36
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 02 Nov 2016 01:23:36 -0700 (PDT)
From: Meng Yi <meng.yi@nxp.com>
To: Meng Yi <meng.yi@nxp.com>, "a.zummo@towertech.it" <a.zummo@towertech.it>,
	"alexandre.belloni@free-electrons.com" <alexandre.belloni@free-electrons.com>
CC: "rtc-linux@googlegroups.com" <rtc-linux@googlegroups.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [rtc-linux] RE: [RFC PATCH] rtc/nxp: add FTM alarm driver as the
 wakeup source
Date: Wed, 2 Nov 2016 08:23:32 +0000
Message-ID: <DB6PR0401MB263163BD3E6AF420934DC6FAECA00@DB6PR0401MB2631.eurprd04.prod.outlook.com>
References: <1477273336-48449-1-git-send-email-meng.yi@nxp.com>
In-Reply-To: <1477273336-48449-1-git-send-email-meng.yi@nxp.com>
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

> +
> +static int ftm_alarm_irq_enable(struct device *dev, unsigned int
> +enabled) {
> +	if (enabled)
> +		ftm_irq_enable(true);
> +	else
> +		ftm_irq_enable(false);
> +
> +	return 0;
> +}
> +
> +static int nxp_ftm_rtc_read_time(struct device *dev, struct rtc_time
> +*tm) {
> +	struct timeval time;
> +	unsigned long local_time;
> +
> +	do_gettimeofday(&time);
> +	local_time = (u32)(time.tv_sec - (sys_tz.tz_minuteswest * 60));
> +	rtc_time_to_tm(local_time, tm);
> +
> +	return 0;
> +}
> +

This is not really getting time from the RTC since FTM is not a RTC device,
But we need to get the time to setup alarm, so we are using system time for now.
Anybody have better idea?

Meng

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
