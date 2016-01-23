Return-Path: <rtc-linux+bncBCKMZDW5VIHBB5U6RO2QKGQE6Q6PH2A@googlegroups.com>
Received: from bh-25.webhostbox.net (bh-25.webhostbox.net. [208.91.199.152])
        by gmr-mx.google.com with ESMTPS id ht5si292673igb.1.2016.01.22.16.55.17
        for <rtc-linux@googlegroups.com>
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Fri, 22 Jan 2016 16:55:17 -0800 (PST)
Subject: [rtc-linux] Re: [PATCH v2] rtc: rtc-ds1307: add temperature sensor
 support for ds3231
To: Akinobu Mita <akinobu.mita@gmail.com>, rtc-linux@googlegroups.com
References: <1453485441-11667-1-git-send-email-akinobu.mita@gmail.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>,
 Alexandre Belloni <alexandre.belloni@free-electrons.com>,
 Jean Delvare <jdelvare@suse.com>, lm-sensors@lm-sensors.org
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <56A2CF6D.9040300@roeck-us.net>
Date: Fri, 22 Jan 2016 16:55:09 -0800
MIME-Version: 1.0
In-Reply-To: <1453485441-11667-1-git-send-email-akinobu.mita@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 01/22/2016 09:57 AM, Akinobu Mita wrote:
> DS3231 has the temperature registers with a resolution of 0.25
> degree celsius.  This enables to get the value through hwmon.
>
> 	# cat /sys/class/i2c-adapter/i2c-2/2-0068/hwmon/hwmon0/temp1_input
> 	21000
>
> Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
> Cc: Alessandro Zummo <a.zummo@towertech.it>
> Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> Cc: rtc-linux@googlegroups.com
> Cc: Jean Delvare <jdelvare@suse.com>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: lm-sensors@lm-sensors.org
> ---
> * v2
> - convert to use hwmon framework, suggested by Alexandre Belloni
>
>   drivers/rtc/rtc-ds1307.c | 122 +++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 122 insertions(+)
>
> diff --git a/drivers/rtc/rtc-ds1307.c b/drivers/rtc/rtc-ds1307.c

Something else, on top of my previous comments.

> +#if IS_ENABLED(CONFIG_HWMON)

I don't think this will work as intended. It will fail if the ds1307 driver
is built into the kernel but hwmon is built as module.

Check configurations such as BE2NET_HWMON or NET_DSA_HWMON for ideas
on how to handle this problem.

Thanks,
Guenter

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
