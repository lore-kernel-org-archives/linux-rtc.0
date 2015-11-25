Return-Path: <rtc-linux+bncBDS7HNEFSALRBW7W2OZAKGQE6MQSI3I@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id w187si102206wmw.1.2015.11.24.16.05.47
        for <rtc-linux@googlegroups.com>;
        Tue, 24 Nov 2015 16:05:47 -0800 (PST)
Date: Wed, 25 Nov 2015 01:05:47 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Geliang Tang <geliangtang@163.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>, rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org
Subject: [rtc-linux] Re: [PATCH 2/2] rtc: efi: add efi_procfs in efi_rtc_ops
Message-ID: <20151125000547.GK3950@piout.net>
References: <9d57abe4fe1acdbc4a63496142ea4b78f152e621.1446868545.git.geliangtang@163.com>
 <92f29256c04397cde0a3572982702dca359392b6.1446868545.git.geliangtang@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <92f29256c04397cde0a3572982702dca359392b6.1446868545.git.geliangtang@163.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

Hi,

On 07/11/2015 at 12:00:22 +0800, Geliang Tang wrote :
> Add efi_procfs in efi_rtc_ops to show rtc-efi info in /proc/driver/rtc.
> Most of the code comes from efi_rtc_proc_show() in efirtc.
> 

I'm actually wondering whether someone actually use those information in
/proc/driver/rtc. Do you have a use case?

> Signed-off-by: Geliang Tang <geliangtang@163.com>
> ---
>  drivers/rtc/rtc-efi.c | 66 +++++++++++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 62 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/rtc/rtc-efi.c b/drivers/rtc/rtc-efi.c
> index 3806961..96d3860 100644
> --- a/drivers/rtc/rtc-efi.c
> +++ b/drivers/rtc/rtc-efi.c
> @@ -191,11 +191,69 @@ static int efi_set_time(struct device *dev, struct rtc_time *tm)
>  	return status == EFI_SUCCESS ? 0 : -EINVAL;
>  }
>  
> +static int efi_procfs(struct device *dev, struct seq_file *seq)
> +{
> +	efi_time_t      eft, alm;
> +	efi_time_cap_t  cap;
> +	efi_bool_t      enabled, pending;
> +
> +	memset(&eft, 0, sizeof(eft));
> +	memset(&alm, 0, sizeof(alm));
> +	memset(&cap, 0, sizeof(cap));
> +
> +	efi.get_time(&eft, &cap);
> +	efi.get_wakeup_time(&enabled, &pending, &alm);
> +
> +	seq_printf(seq,
> +		   "Time\t\t: %u:%u:%u.%09u\n"
> +		   "Date\t\t: %u-%u-%u\n"
> +		   "Daylight\t: %u\n",
> +		   eft.hour, eft.minute, eft.second, eft.nanosecond,
> +		   eft.year, eft.month, eft.day,
> +		   eft.daylight);
> +
> +	if (eft.timezone == EFI_UNSPECIFIED_TIMEZONE)
> +		seq_puts(seq, "Timezone\t: unspecified\n");
> +	else
> +		/* XXX fixme: convert to string? */
> +		seq_printf(seq, "Timezone\t: %u\n", eft.timezone);
> +
> +	seq_printf(seq,
> +		   "Alarm Time\t: %u:%u:%u.%09u\n"
> +		   "Alarm Date\t: %u-%u-%u\n"
> +		   "Alarm Daylight\t: %u\n"
> +		   "Enabled\t\t: %s\n"
> +		   "Pending\t\t: %s\n",
> +		   alm.hour, alm.minute, alm.second, alm.nanosecond,
> +		   alm.year, alm.month, alm.day,
> +		   alm.daylight,
> +		   enabled == 1 ? "yes" : "no",
> +		   pending == 1 ? "yes" : "no");
> +
> +	if (eft.timezone == EFI_UNSPECIFIED_TIMEZONE)
> +		seq_puts(seq, "Timezone\t: unspecified\n");
> +	else
> +		/* XXX fixme: convert to string? */
> +		seq_printf(seq, "Timezone\t: %u\n", alm.timezone);
> +
> +	/*
> +	 * now prints the capabilities
> +	 */
> +	seq_printf(seq,
> +		   "Resolution\t: %u\n"
> +		   "Accuracy\t: %u\n"
> +		   "SetstoZero\t: %u\n",
> +		   cap.resolution, cap.accuracy, cap.sets_to_zero);
> +
> +	return 0;
> +}
> +
>  static const struct rtc_class_ops efi_rtc_ops = {
> -	.read_time = efi_read_time,
> -	.set_time = efi_set_time,
> -	.read_alarm = efi_read_alarm,
> -	.set_alarm = efi_set_alarm,
> +	.read_time	= efi_read_time,
> +	.set_time	= efi_set_time,
> +	.read_alarm	= efi_read_alarm,
> +	.set_alarm	= efi_set_alarm,
> +	.proc		= efi_procfs,
>  };
>  
>  static int __init efi_rtc_probe(struct platform_device *dev)
> -- 
> 2.5.0
> 
> 

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
