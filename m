Return-Path: <rtc-linux+bncBDMJX6NV6MPRBZ6MR2VAKGQEPF5X22A@googlegroups.com>
Received: from smtp.smtpout.orange.fr (smtp06.smtpout.orange.fr. [80.12.242.128])
        by gmr-mx.google.com with ESMTPS id k2si260747wif.0.2015.05.01.09.14.30
        for <rtc-linux@googlegroups.com>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 01 May 2015 09:14:30 -0700 (PDT)
From: Robert Jarzmik <robert.jarzmik@free.fr>
To: Rob Herring <robh@kernel.org>
Cc: Russell King <linux@arm.linux.org.uk>,  Alessandro Zummo <a.zummo@towertech.it>,  linux-arm-kernel@lists.infradead.org,  Arnd Bergmann <arnd@arndb.de>,  Daniel Mack <daniel@zonque.org>,  Haojian Zhuang <haojian.zhuang@gmail.com>,  Eric Miao <eric.y.miao@gmail.com>,  rtc-linux@googlegroups.com
Subject: [rtc-linux] Re: [PATCH v2 2/4] rtc: sa1100: convert to run-time
 register mapping
References: <1430426233-7461-1-git-send-email-robh@kernel.org>
	<1430426233-7461-3-git-send-email-robh@kernel.org>
Date: Fri, 01 May 2015 18:13:48 +0200
In-Reply-To: <1430426233-7461-3-git-send-email-robh@kernel.org> (Rob Herring's
	message of "Thu, 30 Apr 2015 15:37:11 -0500")
Message-ID: <87mw1ojmwz.fsf@belgarion.home>
MIME-Version: 1.0
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

Rob Herring <robh@kernel.org> writes:

>  static int sa1100_rtc_read_time(struct device *dev, struct rtc_time *tm)
>  {
> -	rtc_time_to_tm(RCNR, tm);
> +	struct sa1100_rtc *info = dev_get_drvdata(dev);
> +	rtc_time_to_tm(readl_relaxed(info->rcnr), tm);
One nitpick here : an empty line between info declaration and code would be
better..

> @@ -206,8 +215,9 @@ out:
>
>  static int sa1100_rtc_proc(struct device *dev, struct seq_file *seq)
>  {
> -	seq_printf(seq, "trim/divider\t\t: 0x%08x\n", (u32) RTTR);
> -	seq_printf(seq, "RTSR\t\t\t: 0x%08x\n", (u32)RTSR);
> +	struct sa1100_rtc *info = dev_get_drvdata(dev);
> +	seq_printf(seq, "trim/divider\t\t: 0x%08x\n", readl_relaxed(info->rttr));
> +	seq_printf(seq, "RTSR\t\t\t: 0x%08x\n", readl_relaxed(info->rtsr));
Ditto.

> @@ -244,6 +256,26 @@ static int sa1100_rtc_probe(struct platform_device *pdev)
>  	}
>  	info->irq_1hz = irq_1hz;
>  	info->irq_alarm = irq_alarm;
> +
> +
Ah here the is one too much. Too bad I had not caught it the first time.

With these 3 small details, you can add my :
Acked-by: Robert Jarzmik <robert.jarzmik@free.fr>

Cheers.

-- 
Robert

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
