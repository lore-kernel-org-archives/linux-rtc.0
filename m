Return-Path: <rtc-linux+bncBDKLHK5XRULBB3OC32UQKGQEKD25T4A@googlegroups.com>
Received: from mail-la0-f42.google.com (mail-la0-f42.google.com. [209.85.215.42])
        by gmr-mx.google.com with ESMTPS id su3si442322lbb.1.2015.04.22.06.26.05
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Apr 2015 06:26:05 -0700 (PDT)
Received: by labbd9 with SMTP id bd9so174867246lab.2
        for <rtc-linux@googlegroups.com>; Wed, 22 Apr 2015 06:26:05 -0700 (PDT)
From: "Grygorii.Strashko@linaro.org" <grygorii.strashko@linaro.org>
Message-ID: <5537A169.206@linaro.org>
Date: Wed, 22 Apr 2015 16:26:01 +0300
MIME-Version: 1.0
To: Nishanth Menon <nm@ti.com>,
 Alexandre Belloni <alexandre.belloni@free-electrons.com>,
 Alessandro Zummo <a.zummo@towertech.it>
CC: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org,
 rtc-linux@googlegroups.com
Subject: [rtc-linux] Re: [PATCH V2] drivers/rtc/rtc-ds1307.c: Enable the
 mcp794xx alarm after programming time
References: <1429577494-15087-1-git-send-email-nm@ti.com>
In-Reply-To: <1429577494-15087-1-git-send-email-nm@ti.com>
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

Hi,

On 04/21/2015 03:51 AM, Nishanth Menon wrote:
> Alarm interrupt enable register is at offset 0x7, while the time
> registers for the alarm follow that. When we program Alarm interrupt
> enable prior to programming the time, it is possible that previous
> time value could be close or match at the time of alarm enable
> resulting in interrupt trigger which is unexpected (and does not match
> the time we expect it to trigger).
> 
> To prevent this scenario from occuring, program the ALM0_EN bit only
> after the alarm time is appropriately programmed.
> 
> Ofcourse, I2C programming is non-atomic, so there are loopholes where
> the interrupt wont trigger if the time requested is in the past at
> the time of programming the ALM0_EN bit. However, we will not have
> unexpected interrupts while the time is programmed after the interrupt
> are enabled.

I think it will be nice if you will mention that you going to follow
vendor recommendations - AN1491 Configuring the MCP794XX RTCC Family
http://ww1.microchip.com/downloads/en/AppNotes/01491A.pdf
;)
"Also, it is recommended that the alarm registers be loaded
before the alarm is enabled."

> 
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
> Changes in v2:
> 	- minor typo fix in comments
> 	- merged up code that I missed committing in
> 
> V1: https://patchwork.kernel.org/patch/6245041/
> 
>   drivers/rtc/rtc-ds1307.c |   12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/rtc/rtc-ds1307.c b/drivers/rtc/rtc-ds1307.c
> index 4ffabb322a9a..3cd4783375a5 100644
> --- a/drivers/rtc/rtc-ds1307.c
> +++ b/drivers/rtc/rtc-ds1307.c
> @@ -742,17 +742,17 @@ static int mcp794xx_set_alarm(struct device *dev, struct rtc_wkalrm *t)
>   	regs[6] &= ~MCP794XX_BIT_ALMX_IF;
>   	/* Set alarm match: second, minute, hour, day, date, month. */
>   	regs[6] |= MCP794XX_MSK_ALMX_MATCH;
> -
> -	if (t->enabled)
> -		regs[0] |= MCP794XX_BIT_ALM0_EN;
> -	else
> -		regs[0] &= ~MCP794XX_BIT_ALM0_EN;
> +	/* Disable interrupt. We will not enable until completely programmed */
> +	regs[0] &= ~MCP794XX_BIT_ALM0_EN;
>   
>   	ret = ds1307->write_block_data(client, MCP794XX_REG_CONTROL, 10, regs);
>   	if (ret < 0)
>   		return ret;
>   
> -	return 0;
> +	if (!t->enabled)
> +		return 0;
> +	regs[0] |= MCP794XX_BIT_ALM0_EN;
> +	return i2c_smbus_write_byte_data(client, MCP794XX_REG_CONTROL, regs[0]);

So, It seems, that right sequence should be:
- disable alarmX
- read alarmX regs
- configure alarmX regs
- load alarmX regs
- enable alarmX

More over, looks like, alarm/alarm IRQ should be enabled/disabled separately from set_alarm/RTC_ALM_SET
by RTC_AIE_ON, RTC_AIE_OFF. Should it?

>   }
>   
>   static int mcp794xx_alarm_irq_enable(struct device *dev, unsigned int enabled)
> 


-- 
regards,
-grygorii

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
