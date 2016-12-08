Return-Path: <rtc-linux+bncBDJNHL5JSEOBB5VQU3BAKGQEJXO5WQA@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from vps0.lunn.ch (vps0.lunn.ch. [178.209.37.122])
        by gmr-mx.google.com with ESMTPS id d22si436051wmd.0.2016.12.08.09.29.25
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 08 Dec 2016 09:29:25 -0800 (PST)
Date: Thu, 8 Dec 2016 18:29:23 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	rtc-linux@googlegroups.com, Jason Cooper <jason@lakedaemon.net>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	linux-arm-kernel@lists.infradead.org,
	Shaker Daibes <shaker@marvell.com>
Subject: [rtc-linux] Re: [PATCH 1/3] rtc: armada38x: improve RTC errata implementation
Message-ID: <20161208172923.GQ26852@lunn.ch>
References: <20161208171010.29446-1-gregory.clement@free-electrons.com>
 <20161208171010.29446-2-gregory.clement@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <20161208171010.29446-2-gregory.clement@free-electrons.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

> +struct str_value_to_freq {
> +	unsigned long value;
> +	u8 freq;
> +} __packed;
> +
> +static unsigned long read_rtc_register_wa(struct armada38x_rtc *rtc, u8 rtc_reg)
> +{
> +	unsigned long value_array[SAMPLE_NR], i, j, value;
> +	unsigned long max = 0, index_max = SAMPLE_NR - 1;
> +	struct str_value_to_freq value_to_freq[SAMPLE_NR];

Hi Gregory

This appears to be putting over 900 bytes on the stack. Is there any
danger of overflowing the stack? Would it be safer to make these
arrays part of armada38x_rtc?

       Andrew

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
