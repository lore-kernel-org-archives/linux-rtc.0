Received: from canpmsgout11.his.huawei.com (canpmsgout11.his.huawei.com [113.46.200.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A069883F;
	Thu, 11 Jun 2026 02:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781143301; cv=none; b=PdNvKFmJF1FWlQMIvx9I2PmxK/19bdIxiFOqUYMYYSdOoCRSlCfORyJESP6fFfaRhWoOksVMh5ZPfPu7nsADSz6UOV46o7kebR4K+aTSna7RR3arL003/GdLiMForhMFvBvftfRbNoAMP6xpSBuXppvusMPMHJGHLQhRSvW7IBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781143301; c=relaxed/simple;
	bh=3Wgkq3I6vf8ZqekMNaFwJbYlDYJXfSbTHLRxYiCEKQc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=WVs/1ZgOUci38HUPudE8J05/fAaMqn3i3q/6mI6dBs8Ug7qTO/OE4D6gWsXtO07BIFAfA60Hrq8SGBu1cWH/9rzbA61t4cVCf1hscYOt82NgLxSuyFBuif1v8qZSUFJge+ov3afQls0eRvlYVDWwx7Ac9Hj2puTScaky999sjeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=CXci4ge/; arc=none smtp.client-ip=113.46.200.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="CXci4ge/"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=6JQC6N28eVBKchOxf+ANESTYf2DoO13+dkaIV8b2L0c=;
	b=CXci4ge/Wsv5+hrJJUbn/47pUg1Xy+tXcgaO0MZoYBZnMqxkt8vR8w2EiumjUf9i5BXf1rkWB
	SOBigQJod7+SXnHkH4FHh4DISY0vLCyn1jfNf1pJT4lAMvwuzpviHCM2U1Zl7GzGxS/bpHAtHGv
	DRHstEIi9mJw0EAMzI1FDcM=
Received: from mail.maildlp.com (unknown [172.19.163.127])
	by canpmsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4gbQfN5yGbzKmZx;
	Thu, 11 Jun 2026 09:53:32 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id F019C402AB;
	Thu, 11 Jun 2026 10:01:29 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 dggpemf500011.china.huawei.com (7.185.36.131) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 11 Jun 2026 10:01:29 +0800
Message-ID: <da58d687-2c19-41ca-be69-c1cfdbe392f0@huawei.com>
Date: Thu, 11 Jun 2026 10:01:28 +0800
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rtc: interface: Add rtc time jump debug in
 rtc_timer_do_work()
To: <alexandre.belloni@bootlin.com>, <linux-rtc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <tglx@linutronix.de>
References: <20260525130825.954214-1-ruanjinjie@huawei.com>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <20260525130825.954214-1-ruanjinjie@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 dggpemf500011.china.huawei.com (7.185.36.131)

+cc Thomas Gleixner

On 5/25/2026 9:08 PM, Jinjie Ruan wrote:
> In virtualization environments like QEMU [1], or during hardware
> clocksource anomalies, an extreme time-warp event can occur. When
> the system time abruptly jumps forward, the rtc_timer_do_work() handler
> falls into a prolonged processing loop to clear accumulated historical
> timers via timerqueue_getnext(). Running this loop indefinitely under
> the rtc->ops_lock mutex triggers a kernel softlockup, stalling
> the system.
> 
> Introduce an adaptive telemetry and loop guard mechanism to enhance debug
> visibility and prevent softlockups:
> 
> 1. Record `start_jiffies` upon entry and leverage `time_after()` to
>    check if the loop has monopolized the CPU for more than 1s (HZ). If so,
>    the handler prints a telemetry warning, triggers a WARN stack dump, and
>    breaks the loop to safely yield the CPU.
> 
> 2. Track the execution via a `loop_count` metric. Printing this counter
>    in the warning log provides vital diagnostics to distinguish
>    an aggressive time-warp storm (high count) from a bogged-down callback
>    bug (low count).
> 
> 3. Utilize the kernel format specifier `%ptR` to convert the raw ktime
>    into a human-readable timestamp (YYYY-MM-DD HH:MM:SS), allowing
>    developers to instantly pinpoint the exact boundary of the time
>    jump in dmesg.
> 
> This non-destructive telemetry guard provides precise hardware/emulator
> diagnostic visibility while ensuring core kernel availability.
> 
> [1]: https://lore.kernel.org/all/20260114013257.3500578-1-ruanjinjie@huawei.com/
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> ---
>  drivers/rtc/interface.c | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/rtc/interface.c b/drivers/rtc/interface.c
> index 1906f4884a83..f6c5fd16cc4e 100644
> --- a/drivers/rtc/interface.c
> +++ b/drivers/rtc/interface.c
> @@ -927,10 +927,12 @@ static void rtc_timer_remove(struct rtc_device *rtc, struct rtc_timer *timer)
>   */
>  void rtc_timer_do_work(struct work_struct *work)
>  {
> -	struct rtc_timer *timer;
> +	unsigned long start_jiffies = jiffies;
>  	struct timerqueue_node *next;
> -	ktime_t now;
> +	struct rtc_timer *timer;
>  	struct rtc_time tm;
> +	int loop_count = 0;
> +	ktime_t now;
>  	int err;
>  
>  	struct rtc_device *rtc =
> @@ -945,6 +947,15 @@ void rtc_timer_do_work(struct work_struct *work)
>  	}
>  	now = rtc_tm_to_ktime(tm);
>  	while ((next = timerqueue_getnext(&rtc->timerqueue))) {
> +		loop_count++;
> +
> +		if (unlikely(time_after(jiffies, start_jiffies + HZ))) {
> +			dev_warn(&rtc->dev, "RTC time jump (loop: %d) to %ptR.\n",
> +				 loop_count, &tm);
> +			WARN_ON_ONCE(1);
> +			break;
> +		}
> +
>  		if (next->expires > now)
>  			break;
>  

