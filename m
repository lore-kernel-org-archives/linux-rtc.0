Return-Path: <rtc-linux+bncBDS7HNEFSALRBBEX56UAKGQE3MFMEPI@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id bz6si986775wib.3.2015.04.01.03.42.11
        for <rtc-linux@googlegroups.com>;
        Wed, 01 Apr 2015 03:42:11 -0700 (PDT)
Date: Wed, 1 Apr 2015 12:42:10 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Joe Perches <joe@perches.com>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>,
	Alessandro Zummo <a.zummo@towertech.it>, rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org
Subject: [rtc-linux] Re: [PATCH 3/3] rtc: hctosys: use function name in the
 error log
Message-ID: <20150401104210.GT3849@piout.net>
References: <1427576976-22353-1-git-send-email-aaro.koskinen@iki.fi>
 <1427576976-22353-3-git-send-email-aaro.koskinen@iki.fi>
 <20150401030124.GO3849@piout.net>
 <1427858308.18175.30.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1427858308.18175.30.camel@perches.com>
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

On 31/03/2015 at 20:18:28 -0700, Joe Perches wrote :
> Neither __func__ or __FILE__ is really useful here.
> The message is already specific enough without it.
> 
> If anything, it'd probably be better to add
> 
> #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> 
> to the various files in drivers/rtc that don't
> already have it and remove most all of these
> logging __func__ uses.
> 

Indeed, that seems better. Can you submit that patch?

> Something like:
> 
>  drivers/rtc/hctosys.c          | 6 ++++--
>  drivers/rtc/rtc-cmos.c         | 6 ++++--
>  drivers/rtc/rtc-ds1374.c       | 8 +++++---
>  drivers/rtc/rtc-ds1685.c       | 4 +++-
>  drivers/rtc/rtc-ds3232.c       | 6 ++++--
>  drivers/rtc/rtc-efi-platform.c | 3 +++
>  drivers/rtc/rtc-m41t80.c       | 6 ++++--
>  drivers/rtc/rtc-max77686.c     | 6 ++++--
>  drivers/rtc/rtc-max8997.c      | 8 +++++---
>  drivers/rtc/rtc-msm6242.c      | 4 +++-
>  drivers/rtc/rtc-opal.c         | 3 ++-
>  drivers/rtc/rtc-s5m.c          | 4 +++-
>  drivers/rtc/rtc-twl.c          | 9 +++++----
>  13 files changed, 49 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/rtc/hctosys.c b/drivers/rtc/hctosys.c
> index fb4251d..e1cfa06 100644
> --- a/drivers/rtc/hctosys.c
> +++ b/drivers/rtc/hctosys.c
> @@ -9,6 +9,8 @@
>   * published by the Free Software Foundation.
>  */
>  
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> +
>  #include <linux/rtc.h>
>  
>  /* IMPORTANT: the RTC only stores whole seconds. It is arbitrary
> @@ -32,8 +34,8 @@ static int __init rtc_hctosys(void)
>  	struct rtc_device *rtc = rtc_class_open(CONFIG_RTC_HCTOSYS_DEVICE);
>  
>  	if (rtc == NULL) {
> -		pr_info("%s: unable to open rtc device (%s)\n",
> -			__FILE__, CONFIG_RTC_HCTOSYS_DEVICE);
> +		pr_info("unable to open rtc device (%s)\n",
> +			CONFIG_RTC_HCTOSYS_DEVICE);
>  		goto err_open;
>  	}
>  
> diff --git a/drivers/rtc/rtc-cmos.c b/drivers/rtc/rtc-cmos.c
> index 87647f4..a82556a 100644
> --- a/drivers/rtc/rtc-cmos.c
> +++ b/drivers/rtc/rtc-cmos.c
> @@ -28,6 +28,9 @@
>   * interrupts disabled, holding the global rtc_lock, to exclude those
>   * other drivers and utilities on correctly configured systems.
>   */
> +
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> +
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/init.h>
> @@ -385,8 +388,7 @@ static bool alarm_disable_quirk;
>  static int __init set_alarm_disable_quirk(const struct dmi_system_id *id)
>  {
>  	alarm_disable_quirk = true;
> -	pr_info("rtc-cmos: BIOS has alarm-disable quirk. ");
> -	pr_info("RTC alarms disabled\n");
> +	pr_info("BIOS has alarm-disable quirk - RTC alarms disabled\n");
>  	return 0;
>  }
>  
> diff --git a/drivers/rtc/rtc-ds1374.c b/drivers/rtc/rtc-ds1374.c
> index 8605fde..167783f 100644
> --- a/drivers/rtc/rtc-ds1374.c
> +++ b/drivers/rtc/rtc-ds1374.c
> @@ -18,6 +18,8 @@
>   * "Sending and receiving", using SMBus level communication is preferred.
>   */
>  
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> +
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/interrupt.h>
> @@ -406,7 +408,7 @@ static int ds1374_wdt_settimeout(unsigned int timeout)
>  	/* Set new watchdog time */
>  	ret = ds1374_write_rtc(save_client, timeout, DS1374_REG_WDALM0, 3);
>  	if (ret) {
> -		pr_info("rtc-ds1374 - couldn't set new watchdog time\n");
> +		pr_info("couldn't set new watchdog time\n");
>  		goto out;
>  	}
>  
> @@ -539,12 +541,12 @@ static long ds1374_wdt_ioctl(struct file *file, unsigned int cmd,
>  			return -EFAULT;
>  
>  		if (options & WDIOS_DISABLECARD) {
> -			pr_info("rtc-ds1374: disable watchdog\n");
> +			pr_info("disable watchdog\n");
>  			ds1374_wdt_disable();
>  		}
>  
>  		if (options & WDIOS_ENABLECARD) {
> -			pr_info("rtc-ds1374: enable watchdog\n");
> +			pr_info("enable watchdog\n");
>  			ds1374_wdt_settimeout(wdt_margin);
>  			ds1374_wdt_ping();
>  		}
> diff --git a/drivers/rtc/rtc-ds1685.c b/drivers/rtc/rtc-ds1685.c
> index 7020209..818a363 100644
> --- a/drivers/rtc/rtc-ds1685.c
> +++ b/drivers/rtc/rtc-ds1685.c
> @@ -16,6 +16,8 @@
>   * published by the Free Software Foundation.
>   */
>  
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> +
>  #include <linux/bcd.h>
>  #include <linux/delay.h>
>  #include <linux/io.h>
> @@ -2182,7 +2184,7 @@ ds1685_rtc_poweroff(struct platform_device *pdev)
>  
>  	/* Check for valid RTC data, else, spin forever. */
>  	if (unlikely(!pdev)) {
> -		pr_emerg("rtc-ds1685: platform device data not available, spinning forever ...\n");
> +		pr_emerg("platform device data not available, spinning forever ...\n");
>  		unreachable();
>  	} else {
>  		/* Get the rtc data. */
> diff --git a/drivers/rtc/rtc-ds3232.c b/drivers/rtc/rtc-ds3232.c
> index adaf06c..7e48e53 100644
> --- a/drivers/rtc/rtc-ds3232.c
> +++ b/drivers/rtc/rtc-ds3232.c
> @@ -15,6 +15,8 @@
>   * "Sending and receiving", using SMBus level communication is preferred.
>   */
>  
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> +
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/interrupt.h>
> @@ -373,8 +375,8 @@ static void ds3232_work(struct work_struct *work)
>  	if (stat & DS3232_REG_SR_A1F) {
>  		control = i2c_smbus_read_byte_data(client, DS3232_REG_CR);
>  		if (control < 0) {
> -			pr_warn("Read DS3232 Control Register error."
> -				"Disable IRQ%d.\n", client->irq);
> +			pr_warn("Read Control Register error - Disable IRQ%d\n",
> +				client->irq);
>  		} else {
>  			/* disable alarm1 interrupt */
>  			control &= ~(DS3232_REG_CR_A1IE);
> diff --git a/drivers/rtc/rtc-efi-platform.c b/drivers/rtc/rtc-efi-platform.c
> index b40fbe3..1a7f1d1 100644
> --- a/drivers/rtc/rtc-efi-platform.c
> +++ b/drivers/rtc/rtc-efi-platform.c
> @@ -8,6 +8,9 @@
>   * Copyright (C) 1999-2000 VA Linux Systems
>   * Copyright (C) 1999-2000 Walt Drummond <drummond@valinux.com>
>   */
> +
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> +
>  #include <linux/init.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
> diff --git a/drivers/rtc/rtc-m41t80.c b/drivers/rtc/rtc-m41t80.c
> index 7ff7427..a82937e 100644
> --- a/drivers/rtc/rtc-m41t80.c
> +++ b/drivers/rtc/rtc-m41t80.c
> @@ -13,6 +13,8 @@
>   *
>   */
>  
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> +
>  #include <linux/bcd.h>
>  #include <linux/i2c.h>
>  #include <linux/init.h>
> @@ -513,12 +515,12 @@ static int wdt_ioctl(struct file *file, unsigned int cmd,
>  			return -EFAULT;
>  
>  		if (rv & WDIOS_DISABLECARD) {
> -			pr_info("rtc-m41t80: disable watchdog\n");
> +			pr_info("disable watchdog\n");
>  			wdt_disable();
>  		}
>  
>  		if (rv & WDIOS_ENABLECARD) {
> -			pr_info("rtc-m41t80: enable watchdog\n");
> +			pr_info("enable watchdog\n");
>  			wdt_ping();
>  		}
>  
> diff --git a/drivers/rtc/rtc-max77686.c b/drivers/rtc/rtc-max77686.c
> index 9d71328..7632a87 100644
> --- a/drivers/rtc/rtc-max77686.c
> +++ b/drivers/rtc/rtc-max77686.c
> @@ -12,6 +12,8 @@
>   *
>   */
>  
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> +
>  #include <linux/slab.h>
>  #include <linux/rtc.h>
>  #include <linux/delay.h>
> @@ -103,8 +105,8 @@ static int max77686_rtc_tm_to_data(struct rtc_time *tm, u8 *data)
>  	data[RTC_YEAR] = tm->tm_year > 100 ? (tm->tm_year - 100) : 0;
>  
>  	if (tm->tm_year < 100) {
> -		pr_warn("%s: MAX77686 RTC cannot handle the year %d."
> -			"Assume it's 2000.\n", __func__, 1900 + tm->tm_year);
> +		pr_warn("RTC cannot handle the year %d.  Assume it's 2000.\n",
> +			1900 + tm->tm_year);
>  		return -EINVAL;
>  	}
>  	return 0;
> diff --git a/drivers/rtc/rtc-max8997.c b/drivers/rtc/rtc-max8997.c
> index 67fbe55..9e02bcd 100644
> --- a/drivers/rtc/rtc-max8997.c
> +++ b/drivers/rtc/rtc-max8997.c
> @@ -12,6 +12,8 @@
>   *
>   */
>  
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> +
>  #include <linux/slab.h>
>  #include <linux/rtc.h>
>  #include <linux/delay.h>
> @@ -107,8 +109,8 @@ static int max8997_rtc_tm_to_data(struct rtc_time *tm, u8 *data)
>  	data[RTC_YEAR] = tm->tm_year > 100 ? (tm->tm_year - 100) : 0;
>  
>  	if (tm->tm_year < 100) {
> -		pr_warn("%s: MAX8997 RTC cannot handle the year %d."
> -			"Assume it's 2000.\n", __func__, 1900 + tm->tm_year);
> +		pr_warn("RTC cannot handle the year %d.  Assume it's 2000.\n",
> +			1900 + tm->tm_year);
>  		return -EINVAL;
>  	}
>  	return 0;
> @@ -424,7 +426,7 @@ static void max8997_rtc_enable_smpl(struct max8997_rtc_info *info, bool enable)
>  
>  	val = 0;
>  	max8997_read_reg(info->rtc, MAX8997_RTC_WTSR_SMPL, &val);
> -	pr_info("%s: WTSR_SMPL(0x%02x)\n", __func__, val);
> +	pr_info("WTSR_SMPL(0x%02x)\n", val);
>  }
>  
>  static int max8997_rtc_init_reg(struct max8997_rtc_info *info)
> diff --git a/drivers/rtc/rtc-msm6242.c b/drivers/rtc/rtc-msm6242.c
> index 9bf877b..c1c5c4e 100644
> --- a/drivers/rtc/rtc-msm6242.c
> +++ b/drivers/rtc/rtc-msm6242.c
> @@ -7,6 +7,8 @@
>   *  Copyright (C) 1993 Hamish Macdonald
>   */
>  
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> +
>  #include <linux/delay.h>
>  #include <linux/io.h>
>  #include <linux/kernel.h>
> @@ -111,7 +113,7 @@ static void msm6242_lock(struct msm6242_priv *priv)
>  	}
>  
>  	if (!cnt)
> -		pr_warn("msm6242: timed out waiting for RTC (0x%x)\n",
> +		pr_warn("timed out waiting for RTC (0x%x)\n",
>  			msm6242_read(priv, MSM6242_CD));
>  }
>  
> diff --git a/drivers/rtc/rtc-opal.c b/drivers/rtc/rtc-opal.c
> index 95f6521..7061dca 100644
> --- a/drivers/rtc/rtc-opal.c
> +++ b/drivers/rtc/rtc-opal.c
> @@ -16,8 +16,9 @@
>   * along with this program.
>   */
>  
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> +
>  #define DRVNAME		"rtc-opal"
> -#define pr_fmt(fmt)	DRVNAME ": " fmt
>  
>  #include <linux/module.h>
>  #include <linux/err.h>
> diff --git a/drivers/rtc/rtc-s5m.c b/drivers/rtc/rtc-s5m.c
> index 1f15b67..635c472 100644
> --- a/drivers/rtc/rtc-s5m.c
> +++ b/drivers/rtc/rtc-s5m.c
> @@ -15,6 +15,8 @@
>   *  GNU General Public License for more details.
>   */
>  
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> +
>  #include <linux/module.h>
>  #include <linux/i2c.h>
>  #include <linux/bcd.h>
> @@ -146,7 +148,7 @@ static int s5m8767_tm_to_data(struct rtc_time *tm, u8 *data)
>  	data[RTC_YEAR1] = tm->tm_year > 100 ? (tm->tm_year - 100) : 0;
>  
>  	if (tm->tm_year < 100) {
> -		pr_err("s5m8767 RTC cannot handle the year %d.\n",
> +		pr_err("RTC cannot handle the year %d\n",
>  		       1900 + tm->tm_year);
>  		return -EINVAL;
>  	} else {
> diff --git a/drivers/rtc/rtc-twl.c b/drivers/rtc/rtc-twl.c
> index 5baea3f..2dc787d 100644
> --- a/drivers/rtc/rtc-twl.c
> +++ b/drivers/rtc/rtc-twl.c
> @@ -18,6 +18,8 @@
>   * 2 of the License, or (at your option) any later version.
>   */
>  
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> +
>  #include <linux/kernel.h>
>  #include <linux/errno.h>
>  #include <linux/init.h>
> @@ -145,8 +147,7 @@ static int twl_rtc_read_u8(u8 *data, u8 reg)
>  
>  	ret = twl_i2c_read_u8(TWL_MODULE_RTC, data, (rtc_reg_map[reg]));
>  	if (ret < 0)
> -		pr_err("twl_rtc: Could not read TWL"
> -		       "register %X - error %d\n", reg, ret);
> +		pr_err("Could not read TWL register %X - error %d\n", reg, ret);
>  	return ret;
>  }
>  
> @@ -159,8 +160,8 @@ static int twl_rtc_write_u8(u8 data, u8 reg)
>  
>  	ret = twl_i2c_write_u8(TWL_MODULE_RTC, data, (rtc_reg_map[reg]));
>  	if (ret < 0)
> -		pr_err("twl_rtc: Could not write TWL"
> -		       "register %X - error %d\n", reg, ret);
> +		pr_err("Could not write TWL register %X - error %d\n",
> +		       reg, ret);
>  	return ret;
>  }
>  
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
