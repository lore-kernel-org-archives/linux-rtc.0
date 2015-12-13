Return-Path: <rtc-linux+bncBDS7HNEFSALRBUPQWWZQKGQEYDOUWYQ@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id 204si433274wmx.1.2015.12.13.05.53.21
        for <rtc-linux@googlegroups.com>;
        Sun, 13 Dec 2015 05:53:21 -0800 (PST)
Date: Sun, 13 Dec 2015 14:53:08 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: LABBE Corentin <clabbe.montjoie@gmail.com>
Cc: a.zummo@towertech.it, linux-kernel@vger.kernel.org,
	rtc-linux@googlegroups.com
Subject: [rtc-linux] Re: [PATCH] rtc: Replace simple_strtoul by kstrtoul
Message-ID: <20151213135308.GD11209@piout.net>
References: <1449238780-31110-1-git-send-email-clabbe.montjoie@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1449238780-31110-1-git-send-email-clabbe.montjoie@gmail.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Hi,

On 04/12/2015 at 15:19:39 +0100, LABBE Corentin wrote :
> The simple_strtoul function is obsolete.
> This patch replace it by kstrtoul.
> 
> Signed-off-by: LABBE Corentin <clabbe.montjoie@gmail.com>
> ---
>  drivers/rtc/rtc-sysfs.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/rtc/rtc-sysfs.c b/drivers/rtc/rtc-sysfs.c
> index 7273855..a023f63 100644
> --- a/drivers/rtc/rtc-sysfs.c
> +++ b/drivers/rtc/rtc-sysfs.c
> @@ -91,7 +91,12 @@ max_user_freq_store(struct device *dev, struct device_attribute *attr,
>  		const char *buf, size_t n)
>  {
>  	struct rtc_device *rtc = to_rtc_device(dev);
> -	unsigned long val = simple_strtoul(buf, NULL, 0);
> +	unsigned long val;
> +	int err;
> +
> +	err = kstrtoul(buf, 0, &val);
> +	if (err)
> +		return err;
>  

There are other uses in the same file, you might as well change them.


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
