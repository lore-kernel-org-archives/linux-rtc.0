Return-Path: <rtc-linux+bncBDIK5VOGT4GRBOFJRKZAKGQEVEKJPBA@googlegroups.com>
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com. [119.145.14.65])
        by gmr-mx.google.com with ESMTPS id pe1si637106pac.2.2015.11.10.17.07.03
        for <rtc-linux@googlegroups.com>
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Tue, 10 Nov 2015 17:07:04 -0800 (PST)
Subject: [rtc-linux] Re: [PATCH 1/1] rtc: fix type information of rtc-proc
To: Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni
	<alexandre.belloni@free-electrons.com>,
        rtc-linux
	<rtc-linux@googlegroups.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <1444297652-10328-1-git-send-email-thunder.leizhen@huawei.com>
CC: Arnd Bergmann <arnd@arndb.de>, Zefan Li <lizefan@huawei.com>,
        Xinwei Hu
	<huxinwei@huawei.com>,
        Tianhong Ding <dingtianhong@huawei.com>,
        Hanjun Guo
	<guohanjun@huawei.com>
From: "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <564294AB.1080500@huawei.com>
Date: Wed, 11 Nov 2015 09:06:51 +0800
MIME-Version: 1.0
In-Reply-To: <1444297652-10328-1-git-send-email-thunder.leizhen@huawei.com>
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

Hi, all

I'm sorry. Maybe I didn't describe clearly enough before. These words are finally
shown to the end user. The end user maybe not a programmer, abbreviation word is unsuitable.


cat /proc/driver/rtc

rtc_time        : 00:47:43
rtc_date        : 2015-11-11
alrm_time       : 03:27:58				//alrm_time --> alarm_time
alrm_date       : 2015-10-08				//alrm_date --> alarm_date
alarm_IRQ       : no
alrm_pending    : no					//alrm_pending --> alarm_pending
update IRQ enabled      : no


On 2015/10/8 17:47, Zhen Lei wrote:
> Display the whole word of "alarm", make it look more comfortable.
> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>  drivers/rtc/rtc-proc.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/rtc/rtc-proc.c b/drivers/rtc/rtc-proc.c
> index ffa69e1..ef83f34 100644
> --- a/drivers/rtc/rtc-proc.c
> +++ b/drivers/rtc/rtc-proc.c
> @@ -58,7 +58,7 @@ static int rtc_proc_show(struct seq_file *seq, void *offset)
> 
>  	err = rtc_read_alarm(rtc, &alrm);
>  	if (err == 0) {
> -		seq_printf(seq, "alrm_time\t: ");
> +		seq_printf(seq, "alarm_time\t: ");
>  		if ((unsigned int)alrm.time.tm_hour <= 24)
>  			seq_printf(seq, "%02d:", alrm.time.tm_hour);
>  		else
> @@ -72,7 +72,7 @@ static int rtc_proc_show(struct seq_file *seq, void *offset)
>  		else
>  			seq_printf(seq, "**\n");
> 
> -		seq_printf(seq, "alrm_date\t: ");
> +		seq_printf(seq, "alarm_date\t: ");
>  		if ((unsigned int)alrm.time.tm_year <= 200)
>  			seq_printf(seq, "%04d-", alrm.time.tm_year + 1900);
>  		else
> @@ -87,7 +87,7 @@ static int rtc_proc_show(struct seq_file *seq, void *offset)
>  			seq_printf(seq, "**\n");
>  		seq_printf(seq, "alarm_IRQ\t: %s\n",
>  				alrm.enabled ? "yes" : "no");
> -		seq_printf(seq, "alrm_pending\t: %s\n",
> +		seq_printf(seq, "alarm_pending\t: %s\n",
>  				alrm.pending ? "yes" : "no");
>  		seq_printf(seq, "update IRQ enabled\t: %s\n",
>  			(rtc->uie_rtctimer.enabled) ? "yes" : "no");
> --
> 2.5.0
> 
> 
> 
> .
> 

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
