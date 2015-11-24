Return-Path: <rtc-linux+bncBDS7HNEFSALRBWPD2OZAKGQE5DQNGNY@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id e201si33316wma.3.2015.11.24.15.25.13
        for <rtc-linux@googlegroups.com>;
        Tue, 24 Nov 2015 15:25:13 -0800 (PST)
Date: Wed, 25 Nov 2015 00:25:12 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Joshua Clayton <stillcompiling@gmail.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>, rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org
Subject: [rtc-linux] Re: [PATCH 6/9] rtc-pcf2123: avoid resetting the clock if possible
Message-ID: <20151124232512.GG3950@piout.net>
References: <cover.1446587705.git.stillcompiling@gmail.com>
 <f801d4f26d4c4944b1a5353d5b5fde4e507b45b2.1446587705.git.stillcompiling@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <f801d4f26d4c4944b1a5353d5b5fde4e507b45b2.1446587705.git.stillcompiling@gmail.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

On 04/11/2015 at 07:36:37 -0800, Joshua Clayton wrote :
> +	ret = pcf2123_rtc_read_time(dev, &tm);
> +	if (ret < 0)
> +		return false;
> +
> +	if (rtc_valid_tm(&tm) < 0) {
> +		dev_err(dev, "retrieved date/time is not valid.\n");
> +		return false;
> +	}
> +

I would remove that test as basically, the date/time will only be valid
when OSC_HAS_STOPPED is not set.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

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
