Return-Path: <rtc-linux+bncBDS7HNEFSALRB6F2S63AKGQEM422T2I@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id e130si154662wme.2.2016.02.18.07.04.23
        for <rtc-linux@googlegroups.com>;
        Thu, 18 Feb 2016 07:04:23 -0800 (PST)
Date: Thu, 18 Feb 2016 16:04:22 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Akinobu Mita <akinobu.mita@gmail.com>
Cc: rtc-linux@googlegroups.com, Alessandro Zummo <a.zummo@towertech.it>,
	Dennis Aberilla <denzzzhome@yahoo.com>
Subject: [rtc-linux] Re: [PATCH v2 1/4] rtc: ds3232: rename rtc-ds3232.c to
 rtc-ds3232-core.c for preparation
Message-ID: <20160218150422.GT2189@piout.net>
References: <1455806972-27284-1-git-send-email-akinobu.mita@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1455806972-27284-1-git-send-email-akinobu.mita@gmail.com>
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

I didn't have a close look at it yet but could the abstraction be done
using regmap? This would nicely abstract I2C/SPI accesses.

On 18/02/2016 at 23:49:29 +0900, Akinobu Mita wrote :
> This is preparation for splitting into core module and i2c driver.
> This will make it a lot easier to review the real changes.
> 
> Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
> Cc: Alessandro Zummo <a.zummo@towertech.it>
> Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> Cc: Dennis Aberilla <denzzzhome@yahoo.com>
> ---
> * no changes since v1
> 
>  drivers/rtc/Makefile          |   1 +
>  drivers/rtc/rtc-ds3232-core.c | 517 ++++++++++++++++++++++++++++++++++++++++++
>  drivers/rtc/rtc-ds3232.c      | 517 ------------------------------------------
>  3 files changed, 518 insertions(+), 517 deletions(-)
>  create mode 100644 drivers/rtc/rtc-ds3232-core.c
>  delete mode 100644 drivers/rtc/rtc-ds3232.c
> 
> diff --git a/drivers/rtc/Makefile b/drivers/rtc/Makefile
> index 62d61b2..0b8cb6c 100644
> --- a/drivers/rtc/Makefile
> +++ b/drivers/rtc/Makefile
> @@ -59,6 +59,7 @@ obj-$(CONFIG_RTC_DRV_DS1685_FAMILY)	+= rtc-ds1685.o
>  obj-$(CONFIG_RTC_DRV_DS1742)	+= rtc-ds1742.o
>  obj-$(CONFIG_RTC_DRV_DS2404)	+= rtc-ds2404.o
>  obj-$(CONFIG_RTC_DRV_DS3232)	+= rtc-ds3232.o
> +rtc-ds3232-objs			:= rtc-ds3232-core.o
>  obj-$(CONFIG_RTC_DRV_DS3234)	+= rtc-ds3234.o
>  obj-$(CONFIG_RTC_DRV_EFI)	+= rtc-efi.o
>  obj-$(CONFIG_RTC_DRV_EM3027)	+= rtc-em3027.o
> diff --git a/drivers/rtc/rtc-ds3232-core.c b/drivers/rtc/rtc-ds3232-core.c
> new file mode 100644
> index 0000000..4e99ace
> --- /dev/null
> +++ b/drivers/rtc/rtc-ds3232-core.c
> @@ -0,0 +1,517 @@
> +/*
> + * RTC client/driver for the Maxim/Dallas DS3232 Real-Time Clock over I2C
> + *
> + * Copyright (C) 2009-2011 Freescale Semiconductor.
> + * Author: Jack Lan <jack.lan@freescale.com>
> + *
> + * This program is free software; you can redistribute  it and/or modify it
> + * under  the terms of  the GNU General  Public License as published by the
> + * Free Software Foundation;  either version 2 of the  License, or (at your
> + * option) any later version.
> + */
> +/*
> + * It would be more efficient to use i2c msgs/i2c_transfer directly but, as
> + * recommened in .../Documentation/i2c/writing-clients section
> + * "Sending and receiving", using SMBus level communication is preferred.
> + */
> +
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> +
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/interrupt.h>
> +#include <linux/i2c.h>
> +#include <linux/rtc.h>
> +#include <linux/bcd.h>
> +#include <linux/workqueue.h>
> +#include <linux/slab.h>
> +
> +#define DS3232_REG_SECONDS	0x00
> +#define DS3232_REG_MINUTES	0x01
> +#define DS3232_REG_HOURS	0x02
> +#define DS3232_REG_AMPM		0x02
> +#define DS3232_REG_DAY		0x03
> +#define DS3232_REG_DATE		0x04
> +#define DS3232_REG_MONTH	0x05
> +#define DS3232_REG_CENTURY	0x05
> +#define DS3232_REG_YEAR		0x06
> +#define DS3232_REG_ALARM1         0x07	/* Alarm 1 BASE */
> +#define DS3232_REG_ALARM2         0x0B	/* Alarm 2 BASE */
> +#define DS3232_REG_CR		0x0E	/* Control register */
> +#	define DS3232_REG_CR_nEOSC        0x80
> +#       define DS3232_REG_CR_INTCN        0x04
> +#       define DS3232_REG_CR_A2IE        0x02
> +#       define DS3232_REG_CR_A1IE        0x01
> +
> +#define DS3232_REG_SR	0x0F	/* control/status register */
> +#	define DS3232_REG_SR_OSF   0x80
> +#       define DS3232_REG_SR_BSY   0x04
> +#       define DS3232_REG_SR_A2F   0x02
> +#       define DS3232_REG_SR_A1F   0x01
> +
> +struct ds3232 {
> +	struct i2c_client *client;
> +	struct rtc_device *rtc;
> +	struct work_struct work;
> +
> +	/* The mutex protects alarm operations, and prevents a race
> +	 * between the enable_irq() in the workqueue and the free_irq()
> +	 * in the remove function.
> +	 */
> +	struct mutex mutex;
> +	bool suspended;
> +	int exiting;
> +};
> +
> +static struct i2c_driver ds3232_driver;
> +
> +static int ds3232_check_rtc_status(struct i2c_client *client)
> +{
> +	int ret = 0;
> +	int control, stat;
> +
> +	stat = i2c_smbus_read_byte_data(client, DS3232_REG_SR);
> +	if (stat < 0)
> +		return stat;
> +
> +	if (stat & DS3232_REG_SR_OSF)
> +		dev_warn(&client->dev,
> +				"oscillator discontinuity flagged, "
> +				"time unreliable\n");
> +
> +	stat &= ~(DS3232_REG_SR_OSF | DS3232_REG_SR_A1F | DS3232_REG_SR_A2F);
> +
> +	ret = i2c_smbus_write_byte_data(client, DS3232_REG_SR, stat);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* If the alarm is pending, clear it before requesting
> +	 * the interrupt, so an interrupt event isn't reported
> +	 * before everything is initialized.
> +	 */
> +
> +	control = i2c_smbus_read_byte_data(client, DS3232_REG_CR);
> +	if (control < 0)
> +		return control;
> +
> +	control &= ~(DS3232_REG_CR_A1IE | DS3232_REG_CR_A2IE);
> +	control |= DS3232_REG_CR_INTCN;
> +
> +	return i2c_smbus_write_byte_data(client, DS3232_REG_CR, control);
> +}
> +
> +static int ds3232_read_time(struct device *dev, struct rtc_time *time)
> +{
> +	struct i2c_client *client = to_i2c_client(dev);
> +	int ret;
> +	u8 buf[7];
> +	unsigned int year, month, day, hour, minute, second;
> +	unsigned int week, twelve_hr, am_pm;
> +	unsigned int century, add_century = 0;
> +
> +	ret = i2c_smbus_read_i2c_block_data(client, DS3232_REG_SECONDS, 7, buf);
> +
> +	if (ret < 0)
> +		return ret;
> +	if (ret < 7)
> +		return -EIO;
> +
> +	second = buf[0];
> +	minute = buf[1];
> +	hour = buf[2];
> +	week = buf[3];
> +	day = buf[4];
> +	month = buf[5];
> +	year = buf[6];
> +
> +	/* Extract additional information for AM/PM and century */
> +
> +	twelve_hr = hour & 0x40;
> +	am_pm = hour & 0x20;
> +	century = month & 0x80;
> +
> +	/* Write to rtc_time structure */
> +
> +	time->tm_sec = bcd2bin(second);
> +	time->tm_min = bcd2bin(minute);
> +	if (twelve_hr) {
> +		/* Convert to 24 hr */
> +		if (am_pm)
> +			time->tm_hour = bcd2bin(hour & 0x1F) + 12;
> +		else
> +			time->tm_hour = bcd2bin(hour & 0x1F);
> +	} else {
> +		time->tm_hour = bcd2bin(hour);
> +	}
> +
> +	/* Day of the week in linux range is 0~6 while 1~7 in RTC chip */
> +	time->tm_wday = bcd2bin(week) - 1;
> +	time->tm_mday = bcd2bin(day);
> +	/* linux tm_mon range:0~11, while month range is 1~12 in RTC chip */
> +	time->tm_mon = bcd2bin(month & 0x7F) - 1;
> +	if (century)
> +		add_century = 100;
> +
> +	time->tm_year = bcd2bin(year) + add_century;
> +
> +	return rtc_valid_tm(time);
> +}
> +
> +static int ds3232_set_time(struct device *dev, struct rtc_time *time)
> +{
> +	struct i2c_client *client = to_i2c_client(dev);
> +	u8 buf[7];
> +
> +	/* Extract time from rtc_time and load into ds3232*/
> +
> +	buf[0] = bin2bcd(time->tm_sec);
> +	buf[1] = bin2bcd(time->tm_min);
> +	buf[2] = bin2bcd(time->tm_hour);
> +	/* Day of the week in linux range is 0~6 while 1~7 in RTC chip */
> +	buf[3] = bin2bcd(time->tm_wday + 1);
> +	buf[4] = bin2bcd(time->tm_mday); /* Date */
> +	/* linux tm_mon range:0~11, while month range is 1~12 in RTC chip */
> +	buf[5] = bin2bcd(time->tm_mon + 1);
> +	if (time->tm_year >= 100) {
> +		buf[5] |= 0x80;
> +		buf[6] = bin2bcd(time->tm_year - 100);
> +	} else {
> +		buf[6] = bin2bcd(time->tm_year);
> +	}
> +
> +	return i2c_smbus_write_i2c_block_data(client,
> +					      DS3232_REG_SECONDS, 7, buf);
> +}
> +
> +/*
> + * DS3232 has two alarm, we only use alarm1
> + * According to linux specification, only support one-shot alarm
> + * no periodic alarm mode
> + */
> +static int ds3232_read_alarm(struct device *dev, struct rtc_wkalrm *alarm)
> +{
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct ds3232 *ds3232 = i2c_get_clientdata(client);
> +	int control, stat;
> +	int ret;
> +	u8 buf[4];
> +
> +	mutex_lock(&ds3232->mutex);
> +
> +	ret = i2c_smbus_read_byte_data(client, DS3232_REG_SR);
> +	if (ret < 0)
> +		goto out;
> +	stat = ret;
> +	ret = i2c_smbus_read_byte_data(client, DS3232_REG_CR);
> +	if (ret < 0)
> +		goto out;
> +	control = ret;
> +	ret = i2c_smbus_read_i2c_block_data(client, DS3232_REG_ALARM1, 4, buf);
> +	if (ret < 0)
> +		goto out;
> +
> +	alarm->time.tm_sec = bcd2bin(buf[0] & 0x7F);
> +	alarm->time.tm_min = bcd2bin(buf[1] & 0x7F);
> +	alarm->time.tm_hour = bcd2bin(buf[2] & 0x7F);
> +	alarm->time.tm_mday = bcd2bin(buf[3] & 0x7F);
> +
> +	alarm->time.tm_mon = -1;
> +	alarm->time.tm_year = -1;
> +	alarm->time.tm_wday = -1;
> +	alarm->time.tm_yday = -1;
> +	alarm->time.tm_isdst = -1;
> +
> +	alarm->enabled = !!(control & DS3232_REG_CR_A1IE);
> +	alarm->pending = !!(stat & DS3232_REG_SR_A1F);
> +
> +	ret = 0;
> +out:
> +	mutex_unlock(&ds3232->mutex);
> +	return ret;
> +}
> +
> +/*
> + * linux rtc-module does not support wday alarm
> + * and only 24h time mode supported indeed
> + */
> +static int ds3232_set_alarm(struct device *dev, struct rtc_wkalrm *alarm)
> +{
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct ds3232 *ds3232 = i2c_get_clientdata(client);
> +	int control, stat;
> +	int ret;
> +	u8 buf[4];
> +
> +	if (client->irq <= 0)
> +		return -EINVAL;
> +
> +	mutex_lock(&ds3232->mutex);
> +
> +	buf[0] = bin2bcd(alarm->time.tm_sec);
> +	buf[1] = bin2bcd(alarm->time.tm_min);
> +	buf[2] = bin2bcd(alarm->time.tm_hour);
> +	buf[3] = bin2bcd(alarm->time.tm_mday);
> +
> +	/* clear alarm interrupt enable bit */
> +	ret = i2c_smbus_read_byte_data(client, DS3232_REG_CR);
> +	if (ret < 0)
> +		goto out;
> +	control = ret;
> +	control &= ~(DS3232_REG_CR_A1IE | DS3232_REG_CR_A2IE);
> +	ret = i2c_smbus_write_byte_data(client, DS3232_REG_CR, control);
> +	if (ret < 0)
> +		goto out;
> +
> +	/* clear any pending alarm flag */
> +	ret = i2c_smbus_read_byte_data(client, DS3232_REG_SR);
> +	if (ret < 0)
> +		goto out;
> +	stat = ret;
> +	stat &= ~(DS3232_REG_SR_A1F | DS3232_REG_SR_A2F);
> +	ret = i2c_smbus_write_byte_data(client, DS3232_REG_SR, stat);
> +	if (ret < 0)
> +		goto out;
> +
> +	ret = i2c_smbus_write_i2c_block_data(client, DS3232_REG_ALARM1, 4, buf);
> +
> +	if (alarm->enabled) {
> +		control |= DS3232_REG_CR_A1IE;
> +		ret = i2c_smbus_write_byte_data(client, DS3232_REG_CR, control);
> +	}
> +out:
> +	mutex_unlock(&ds3232->mutex);
> +	return ret;
> +}
> +
> +static void ds3232_update_alarm(struct i2c_client *client)
> +{
> +	struct ds3232 *ds3232 = i2c_get_clientdata(client);
> +	int control;
> +	int ret;
> +	u8 buf[4];
> +
> +	mutex_lock(&ds3232->mutex);
> +
> +	ret = i2c_smbus_read_i2c_block_data(client, DS3232_REG_ALARM1, 4, buf);
> +	if (ret < 0)
> +		goto unlock;
> +
> +	buf[0] = bcd2bin(buf[0]) < 0 || (ds3232->rtc->irq_data & RTC_UF) ?
> +								0x80 : buf[0];
> +	buf[1] = bcd2bin(buf[1]) < 0 || (ds3232->rtc->irq_data & RTC_UF) ?
> +								0x80 : buf[1];
> +	buf[2] = bcd2bin(buf[2]) < 0 || (ds3232->rtc->irq_data & RTC_UF) ?
> +								0x80 : buf[2];
> +	buf[3] = bcd2bin(buf[3]) < 0 || (ds3232->rtc->irq_data & RTC_UF) ?
> +								0x80 : buf[3];
> +
> +	ret = i2c_smbus_write_i2c_block_data(client, DS3232_REG_ALARM1, 4, buf);
> +	if (ret < 0)
> +		goto unlock;
> +
> +	control = i2c_smbus_read_byte_data(client, DS3232_REG_CR);
> +	if (control < 0)
> +		goto unlock;
> +
> +	if (ds3232->rtc->irq_data & (RTC_AF | RTC_UF))
> +		/* enable alarm1 interrupt */
> +		control |= DS3232_REG_CR_A1IE;
> +	else
> +		/* disable alarm1 interrupt */
> +		control &= ~(DS3232_REG_CR_A1IE);
> +	i2c_smbus_write_byte_data(client, DS3232_REG_CR, control);
> +
> +unlock:
> +	mutex_unlock(&ds3232->mutex);
> +}
> +
> +static int ds3232_alarm_irq_enable(struct device *dev, unsigned int enabled)
> +{
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct ds3232 *ds3232 = i2c_get_clientdata(client);
> +
> +	if (client->irq <= 0)
> +		return -EINVAL;
> +
> +	if (enabled)
> +		ds3232->rtc->irq_data |= RTC_AF;
> +	else
> +		ds3232->rtc->irq_data &= ~RTC_AF;
> +
> +	ds3232_update_alarm(client);
> +	return 0;
> +}
> +
> +static irqreturn_t ds3232_irq(int irq, void *dev_id)
> +{
> +	struct i2c_client *client = dev_id;
> +	struct ds3232 *ds3232 = i2c_get_clientdata(client);
> +
> +	disable_irq_nosync(irq);
> +
> +	/*
> +	 * If rtc as a wakeup source, can't schedule the work
> +	 * at system resume flow, because at this time the i2c bus
> +	 * has not been resumed.
> +	 */
> +	if (!ds3232->suspended)
> +		schedule_work(&ds3232->work);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static void ds3232_work(struct work_struct *work)
> +{
> +	struct ds3232 *ds3232 = container_of(work, struct ds3232, work);
> +	struct i2c_client *client = ds3232->client;
> +	int stat, control;
> +
> +	mutex_lock(&ds3232->mutex);
> +
> +	stat = i2c_smbus_read_byte_data(client, DS3232_REG_SR);
> +	if (stat < 0)
> +		goto unlock;
> +
> +	if (stat & DS3232_REG_SR_A1F) {
> +		control = i2c_smbus_read_byte_data(client, DS3232_REG_CR);
> +		if (control < 0) {
> +			pr_warn("Read Control Register error - Disable IRQ%d\n",
> +				client->irq);
> +		} else {
> +			/* disable alarm1 interrupt */
> +			control &= ~(DS3232_REG_CR_A1IE);
> +			i2c_smbus_write_byte_data(client, DS3232_REG_CR,
> +						control);
> +
> +			/* clear the alarm pend flag */
> +			stat &= ~DS3232_REG_SR_A1F;
> +			i2c_smbus_write_byte_data(client, DS3232_REG_SR, stat);
> +
> +			rtc_update_irq(ds3232->rtc, 1, RTC_AF | RTC_IRQF);
> +
> +			if (!ds3232->exiting)
> +				enable_irq(client->irq);
> +		}
> +	}
> +
> +unlock:
> +	mutex_unlock(&ds3232->mutex);
> +}
> +
> +static const struct rtc_class_ops ds3232_rtc_ops = {
> +	.read_time = ds3232_read_time,
> +	.set_time = ds3232_set_time,
> +	.read_alarm = ds3232_read_alarm,
> +	.set_alarm = ds3232_set_alarm,
> +	.alarm_irq_enable = ds3232_alarm_irq_enable,
> +};
> +
> +static int ds3232_probe(struct i2c_client *client,
> +			const struct i2c_device_id *id)
> +{
> +	struct ds3232 *ds3232;
> +	int ret;
> +
> +	ds3232 = devm_kzalloc(&client->dev, sizeof(struct ds3232), GFP_KERNEL);
> +	if (!ds3232)
> +		return -ENOMEM;
> +
> +	ds3232->client = client;
> +	i2c_set_clientdata(client, ds3232);
> +
> +	INIT_WORK(&ds3232->work, ds3232_work);
> +	mutex_init(&ds3232->mutex);
> +
> +	ret = ds3232_check_rtc_status(client);
> +	if (ret)
> +		return ret;
> +
> +	if (client->irq > 0) {
> +		ret = devm_request_irq(&client->dev, client->irq, ds3232_irq,
> +				       IRQF_SHARED, "ds3232", client);
> +		if (ret) {
> +			dev_err(&client->dev, "unable to request IRQ\n");
> +		}
> +		device_init_wakeup(&client->dev, 1);
> +	}
> +	ds3232->rtc = devm_rtc_device_register(&client->dev, client->name,
> +					  &ds3232_rtc_ops, THIS_MODULE);
> +	return PTR_ERR_OR_ZERO(ds3232->rtc);
> +}
> +
> +static int ds3232_remove(struct i2c_client *client)
> +{
> +	struct ds3232 *ds3232 = i2c_get_clientdata(client);
> +
> +	if (client->irq > 0) {
> +		mutex_lock(&ds3232->mutex);
> +		ds3232->exiting = 1;
> +		mutex_unlock(&ds3232->mutex);
> +
> +		devm_free_irq(&client->dev, client->irq, client);
> +		cancel_work_sync(&ds3232->work);
> +	}
> +
> +	return 0;
> +}
> +
> +#ifdef CONFIG_PM_SLEEP
> +static int ds3232_suspend(struct device *dev)
> +{
> +	struct ds3232 *ds3232 = dev_get_drvdata(dev);
> +	struct i2c_client *client = to_i2c_client(dev);
> +
> +	if (device_can_wakeup(dev)) {
> +		ds3232->suspended = true;
> +		if (irq_set_irq_wake(client->irq, 1)) {
> +			dev_warn_once(dev, "Cannot set wakeup source\n");
> +			ds3232->suspended = false;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static int ds3232_resume(struct device *dev)
> +{
> +	struct ds3232 *ds3232 = dev_get_drvdata(dev);
> +	struct i2c_client *client = to_i2c_client(dev);
> +
> +	if (ds3232->suspended) {
> +		ds3232->suspended = false;
> +
> +		/* Clear the hardware alarm pend flag */
> +		schedule_work(&ds3232->work);
> +
> +		irq_set_irq_wake(client->irq, 0);
> +	}
> +
> +	return 0;
> +}
> +#endif
> +
> +static const struct dev_pm_ops ds3232_pm_ops = {
> +	SET_SYSTEM_SLEEP_PM_OPS(ds3232_suspend, ds3232_resume)
> +};
> +
> +static const struct i2c_device_id ds3232_id[] = {
> +	{ "ds3232", 0 },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(i2c, ds3232_id);
> +
> +static struct i2c_driver ds3232_driver = {
> +	.driver = {
> +		.name = "rtc-ds3232",
> +		.pm	= &ds3232_pm_ops,
> +	},
> +	.probe = ds3232_probe,
> +	.remove = ds3232_remove,
> +	.id_table = ds3232_id,
> +};
> +
> +module_i2c_driver(ds3232_driver);
> +
> +MODULE_AUTHOR("Srikanth Srinivasan <srikanth.srinivasan@freescale.com>");
> +MODULE_DESCRIPTION("Maxim/Dallas DS3232 RTC Driver");
> +MODULE_LICENSE("GPL");
> diff --git a/drivers/rtc/rtc-ds3232.c b/drivers/rtc/rtc-ds3232.c
> deleted file mode 100644
> index 4e99ace..0000000
> --- a/drivers/rtc/rtc-ds3232.c
> +++ /dev/null
> @@ -1,517 +0,0 @@
> -/*
> - * RTC client/driver for the Maxim/Dallas DS3232 Real-Time Clock over I2C
> - *
> - * Copyright (C) 2009-2011 Freescale Semiconductor.
> - * Author: Jack Lan <jack.lan@freescale.com>
> - *
> - * This program is free software; you can redistribute  it and/or modify it
> - * under  the terms of  the GNU General  Public License as published by the
> - * Free Software Foundation;  either version 2 of the  License, or (at your
> - * option) any later version.
> - */
> -/*
> - * It would be more efficient to use i2c msgs/i2c_transfer directly but, as
> - * recommened in .../Documentation/i2c/writing-clients section
> - * "Sending and receiving", using SMBus level communication is preferred.
> - */
> -
> -#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> -
> -#include <linux/kernel.h>
> -#include <linux/module.h>
> -#include <linux/interrupt.h>
> -#include <linux/i2c.h>
> -#include <linux/rtc.h>
> -#include <linux/bcd.h>
> -#include <linux/workqueue.h>
> -#include <linux/slab.h>
> -
> -#define DS3232_REG_SECONDS	0x00
> -#define DS3232_REG_MINUTES	0x01
> -#define DS3232_REG_HOURS	0x02
> -#define DS3232_REG_AMPM		0x02
> -#define DS3232_REG_DAY		0x03
> -#define DS3232_REG_DATE		0x04
> -#define DS3232_REG_MONTH	0x05
> -#define DS3232_REG_CENTURY	0x05
> -#define DS3232_REG_YEAR		0x06
> -#define DS3232_REG_ALARM1         0x07	/* Alarm 1 BASE */
> -#define DS3232_REG_ALARM2         0x0B	/* Alarm 2 BASE */
> -#define DS3232_REG_CR		0x0E	/* Control register */
> -#	define DS3232_REG_CR_nEOSC        0x80
> -#       define DS3232_REG_CR_INTCN        0x04
> -#       define DS3232_REG_CR_A2IE        0x02
> -#       define DS3232_REG_CR_A1IE        0x01
> -
> -#define DS3232_REG_SR	0x0F	/* control/status register */
> -#	define DS3232_REG_SR_OSF   0x80
> -#       define DS3232_REG_SR_BSY   0x04
> -#       define DS3232_REG_SR_A2F   0x02
> -#       define DS3232_REG_SR_A1F   0x01
> -
> -struct ds3232 {
> -	struct i2c_client *client;
> -	struct rtc_device *rtc;
> -	struct work_struct work;
> -
> -	/* The mutex protects alarm operations, and prevents a race
> -	 * between the enable_irq() in the workqueue and the free_irq()
> -	 * in the remove function.
> -	 */
> -	struct mutex mutex;
> -	bool suspended;
> -	int exiting;
> -};
> -
> -static struct i2c_driver ds3232_driver;
> -
> -static int ds3232_check_rtc_status(struct i2c_client *client)
> -{
> -	int ret = 0;
> -	int control, stat;
> -
> -	stat = i2c_smbus_read_byte_data(client, DS3232_REG_SR);
> -	if (stat < 0)
> -		return stat;
> -
> -	if (stat & DS3232_REG_SR_OSF)
> -		dev_warn(&client->dev,
> -				"oscillator discontinuity flagged, "
> -				"time unreliable\n");
> -
> -	stat &= ~(DS3232_REG_SR_OSF | DS3232_REG_SR_A1F | DS3232_REG_SR_A2F);
> -
> -	ret = i2c_smbus_write_byte_data(client, DS3232_REG_SR, stat);
> -	if (ret < 0)
> -		return ret;
> -
> -	/* If the alarm is pending, clear it before requesting
> -	 * the interrupt, so an interrupt event isn't reported
> -	 * before everything is initialized.
> -	 */
> -
> -	control = i2c_smbus_read_byte_data(client, DS3232_REG_CR);
> -	if (control < 0)
> -		return control;
> -
> -	control &= ~(DS3232_REG_CR_A1IE | DS3232_REG_CR_A2IE);
> -	control |= DS3232_REG_CR_INTCN;
> -
> -	return i2c_smbus_write_byte_data(client, DS3232_REG_CR, control);
> -}
> -
> -static int ds3232_read_time(struct device *dev, struct rtc_time *time)
> -{
> -	struct i2c_client *client = to_i2c_client(dev);
> -	int ret;
> -	u8 buf[7];
> -	unsigned int year, month, day, hour, minute, second;
> -	unsigned int week, twelve_hr, am_pm;
> -	unsigned int century, add_century = 0;
> -
> -	ret = i2c_smbus_read_i2c_block_data(client, DS3232_REG_SECONDS, 7, buf);
> -
> -	if (ret < 0)
> -		return ret;
> -	if (ret < 7)
> -		return -EIO;
> -
> -	second = buf[0];
> -	minute = buf[1];
> -	hour = buf[2];
> -	week = buf[3];
> -	day = buf[4];
> -	month = buf[5];
> -	year = buf[6];
> -
> -	/* Extract additional information for AM/PM and century */
> -
> -	twelve_hr = hour & 0x40;
> -	am_pm = hour & 0x20;
> -	century = month & 0x80;
> -
> -	/* Write to rtc_time structure */
> -
> -	time->tm_sec = bcd2bin(second);
> -	time->tm_min = bcd2bin(minute);
> -	if (twelve_hr) {
> -		/* Convert to 24 hr */
> -		if (am_pm)
> -			time->tm_hour = bcd2bin(hour & 0x1F) + 12;
> -		else
> -			time->tm_hour = bcd2bin(hour & 0x1F);
> -	} else {
> -		time->tm_hour = bcd2bin(hour);
> -	}
> -
> -	/* Day of the week in linux range is 0~6 while 1~7 in RTC chip */
> -	time->tm_wday = bcd2bin(week) - 1;
> -	time->tm_mday = bcd2bin(day);
> -	/* linux tm_mon range:0~11, while month range is 1~12 in RTC chip */
> -	time->tm_mon = bcd2bin(month & 0x7F) - 1;
> -	if (century)
> -		add_century = 100;
> -
> -	time->tm_year = bcd2bin(year) + add_century;
> -
> -	return rtc_valid_tm(time);
> -}
> -
> -static int ds3232_set_time(struct device *dev, struct rtc_time *time)
> -{
> -	struct i2c_client *client = to_i2c_client(dev);
> -	u8 buf[7];
> -
> -	/* Extract time from rtc_time and load into ds3232*/
> -
> -	buf[0] = bin2bcd(time->tm_sec);
> -	buf[1] = bin2bcd(time->tm_min);
> -	buf[2] = bin2bcd(time->tm_hour);
> -	/* Day of the week in linux range is 0~6 while 1~7 in RTC chip */
> -	buf[3] = bin2bcd(time->tm_wday + 1);
> -	buf[4] = bin2bcd(time->tm_mday); /* Date */
> -	/* linux tm_mon range:0~11, while month range is 1~12 in RTC chip */
> -	buf[5] = bin2bcd(time->tm_mon + 1);
> -	if (time->tm_year >= 100) {
> -		buf[5] |= 0x80;
> -		buf[6] = bin2bcd(time->tm_year - 100);
> -	} else {
> -		buf[6] = bin2bcd(time->tm_year);
> -	}
> -
> -	return i2c_smbus_write_i2c_block_data(client,
> -					      DS3232_REG_SECONDS, 7, buf);
> -}
> -
> -/*
> - * DS3232 has two alarm, we only use alarm1
> - * According to linux specification, only support one-shot alarm
> - * no periodic alarm mode
> - */
> -static int ds3232_read_alarm(struct device *dev, struct rtc_wkalrm *alarm)
> -{
> -	struct i2c_client *client = to_i2c_client(dev);
> -	struct ds3232 *ds3232 = i2c_get_clientdata(client);
> -	int control, stat;
> -	int ret;
> -	u8 buf[4];
> -
> -	mutex_lock(&ds3232->mutex);
> -
> -	ret = i2c_smbus_read_byte_data(client, DS3232_REG_SR);
> -	if (ret < 0)
> -		goto out;
> -	stat = ret;
> -	ret = i2c_smbus_read_byte_data(client, DS3232_REG_CR);
> -	if (ret < 0)
> -		goto out;
> -	control = ret;
> -	ret = i2c_smbus_read_i2c_block_data(client, DS3232_REG_ALARM1, 4, buf);
> -	if (ret < 0)
> -		goto out;
> -
> -	alarm->time.tm_sec = bcd2bin(buf[0] & 0x7F);
> -	alarm->time.tm_min = bcd2bin(buf[1] & 0x7F);
> -	alarm->time.tm_hour = bcd2bin(buf[2] & 0x7F);
> -	alarm->time.tm_mday = bcd2bin(buf[3] & 0x7F);
> -
> -	alarm->time.tm_mon = -1;
> -	alarm->time.tm_year = -1;
> -	alarm->time.tm_wday = -1;
> -	alarm->time.tm_yday = -1;
> -	alarm->time.tm_isdst = -1;
> -
> -	alarm->enabled = !!(control & DS3232_REG_CR_A1IE);
> -	alarm->pending = !!(stat & DS3232_REG_SR_A1F);
> -
> -	ret = 0;
> -out:
> -	mutex_unlock(&ds3232->mutex);
> -	return ret;
> -}
> -
> -/*
> - * linux rtc-module does not support wday alarm
> - * and only 24h time mode supported indeed
> - */
> -static int ds3232_set_alarm(struct device *dev, struct rtc_wkalrm *alarm)
> -{
> -	struct i2c_client *client = to_i2c_client(dev);
> -	struct ds3232 *ds3232 = i2c_get_clientdata(client);
> -	int control, stat;
> -	int ret;
> -	u8 buf[4];
> -
> -	if (client->irq <= 0)
> -		return -EINVAL;
> -
> -	mutex_lock(&ds3232->mutex);
> -
> -	buf[0] = bin2bcd(alarm->time.tm_sec);
> -	buf[1] = bin2bcd(alarm->time.tm_min);
> -	buf[2] = bin2bcd(alarm->time.tm_hour);
> -	buf[3] = bin2bcd(alarm->time.tm_mday);
> -
> -	/* clear alarm interrupt enable bit */
> -	ret = i2c_smbus_read_byte_data(client, DS3232_REG_CR);
> -	if (ret < 0)
> -		goto out;
> -	control = ret;
> -	control &= ~(DS3232_REG_CR_A1IE | DS3232_REG_CR_A2IE);
> -	ret = i2c_smbus_write_byte_data(client, DS3232_REG_CR, control);
> -	if (ret < 0)
> -		goto out;
> -
> -	/* clear any pending alarm flag */
> -	ret = i2c_smbus_read_byte_data(client, DS3232_REG_SR);
> -	if (ret < 0)
> -		goto out;
> -	stat = ret;
> -	stat &= ~(DS3232_REG_SR_A1F | DS3232_REG_SR_A2F);
> -	ret = i2c_smbus_write_byte_data(client, DS3232_REG_SR, stat);
> -	if (ret < 0)
> -		goto out;
> -
> -	ret = i2c_smbus_write_i2c_block_data(client, DS3232_REG_ALARM1, 4, buf);
> -
> -	if (alarm->enabled) {
> -		control |= DS3232_REG_CR_A1IE;
> -		ret = i2c_smbus_write_byte_data(client, DS3232_REG_CR, control);
> -	}
> -out:
> -	mutex_unlock(&ds3232->mutex);
> -	return ret;
> -}
> -
> -static void ds3232_update_alarm(struct i2c_client *client)
> -{
> -	struct ds3232 *ds3232 = i2c_get_clientdata(client);
> -	int control;
> -	int ret;
> -	u8 buf[4];
> -
> -	mutex_lock(&ds3232->mutex);
> -
> -	ret = i2c_smbus_read_i2c_block_data(client, DS3232_REG_ALARM1, 4, buf);
> -	if (ret < 0)
> -		goto unlock;
> -
> -	buf[0] = bcd2bin(buf[0]) < 0 || (ds3232->rtc->irq_data & RTC_UF) ?
> -								0x80 : buf[0];
> -	buf[1] = bcd2bin(buf[1]) < 0 || (ds3232->rtc->irq_data & RTC_UF) ?
> -								0x80 : buf[1];
> -	buf[2] = bcd2bin(buf[2]) < 0 || (ds3232->rtc->irq_data & RTC_UF) ?
> -								0x80 : buf[2];
> -	buf[3] = bcd2bin(buf[3]) < 0 || (ds3232->rtc->irq_data & RTC_UF) ?
> -								0x80 : buf[3];
> -
> -	ret = i2c_smbus_write_i2c_block_data(client, DS3232_REG_ALARM1, 4, buf);
> -	if (ret < 0)
> -		goto unlock;
> -
> -	control = i2c_smbus_read_byte_data(client, DS3232_REG_CR);
> -	if (control < 0)
> -		goto unlock;
> -
> -	if (ds3232->rtc->irq_data & (RTC_AF | RTC_UF))
> -		/* enable alarm1 interrupt */
> -		control |= DS3232_REG_CR_A1IE;
> -	else
> -		/* disable alarm1 interrupt */
> -		control &= ~(DS3232_REG_CR_A1IE);
> -	i2c_smbus_write_byte_data(client, DS3232_REG_CR, control);
> -
> -unlock:
> -	mutex_unlock(&ds3232->mutex);
> -}
> -
> -static int ds3232_alarm_irq_enable(struct device *dev, unsigned int enabled)
> -{
> -	struct i2c_client *client = to_i2c_client(dev);
> -	struct ds3232 *ds3232 = i2c_get_clientdata(client);
> -
> -	if (client->irq <= 0)
> -		return -EINVAL;
> -
> -	if (enabled)
> -		ds3232->rtc->irq_data |= RTC_AF;
> -	else
> -		ds3232->rtc->irq_data &= ~RTC_AF;
> -
> -	ds3232_update_alarm(client);
> -	return 0;
> -}
> -
> -static irqreturn_t ds3232_irq(int irq, void *dev_id)
> -{
> -	struct i2c_client *client = dev_id;
> -	struct ds3232 *ds3232 = i2c_get_clientdata(client);
> -
> -	disable_irq_nosync(irq);
> -
> -	/*
> -	 * If rtc as a wakeup source, can't schedule the work
> -	 * at system resume flow, because at this time the i2c bus
> -	 * has not been resumed.
> -	 */
> -	if (!ds3232->suspended)
> -		schedule_work(&ds3232->work);
> -
> -	return IRQ_HANDLED;
> -}
> -
> -static void ds3232_work(struct work_struct *work)
> -{
> -	struct ds3232 *ds3232 = container_of(work, struct ds3232, work);
> -	struct i2c_client *client = ds3232->client;
> -	int stat, control;
> -
> -	mutex_lock(&ds3232->mutex);
> -
> -	stat = i2c_smbus_read_byte_data(client, DS3232_REG_SR);
> -	if (stat < 0)
> -		goto unlock;
> -
> -	if (stat & DS3232_REG_SR_A1F) {
> -		control = i2c_smbus_read_byte_data(client, DS3232_REG_CR);
> -		if (control < 0) {
> -			pr_warn("Read Control Register error - Disable IRQ%d\n",
> -				client->irq);
> -		} else {
> -			/* disable alarm1 interrupt */
> -			control &= ~(DS3232_REG_CR_A1IE);
> -			i2c_smbus_write_byte_data(client, DS3232_REG_CR,
> -						control);
> -
> -			/* clear the alarm pend flag */
> -			stat &= ~DS3232_REG_SR_A1F;
> -			i2c_smbus_write_byte_data(client, DS3232_REG_SR, stat);
> -
> -			rtc_update_irq(ds3232->rtc, 1, RTC_AF | RTC_IRQF);
> -
> -			if (!ds3232->exiting)
> -				enable_irq(client->irq);
> -		}
> -	}
> -
> -unlock:
> -	mutex_unlock(&ds3232->mutex);
> -}
> -
> -static const struct rtc_class_ops ds3232_rtc_ops = {
> -	.read_time = ds3232_read_time,
> -	.set_time = ds3232_set_time,
> -	.read_alarm = ds3232_read_alarm,
> -	.set_alarm = ds3232_set_alarm,
> -	.alarm_irq_enable = ds3232_alarm_irq_enable,
> -};
> -
> -static int ds3232_probe(struct i2c_client *client,
> -			const struct i2c_device_id *id)
> -{
> -	struct ds3232 *ds3232;
> -	int ret;
> -
> -	ds3232 = devm_kzalloc(&client->dev, sizeof(struct ds3232), GFP_KERNEL);
> -	if (!ds3232)
> -		return -ENOMEM;
> -
> -	ds3232->client = client;
> -	i2c_set_clientdata(client, ds3232);
> -
> -	INIT_WORK(&ds3232->work, ds3232_work);
> -	mutex_init(&ds3232->mutex);
> -
> -	ret = ds3232_check_rtc_status(client);
> -	if (ret)
> -		return ret;
> -
> -	if (client->irq > 0) {
> -		ret = devm_request_irq(&client->dev, client->irq, ds3232_irq,
> -				       IRQF_SHARED, "ds3232", client);
> -		if (ret) {
> -			dev_err(&client->dev, "unable to request IRQ\n");
> -		}
> -		device_init_wakeup(&client->dev, 1);
> -	}
> -	ds3232->rtc = devm_rtc_device_register(&client->dev, client->name,
> -					  &ds3232_rtc_ops, THIS_MODULE);
> -	return PTR_ERR_OR_ZERO(ds3232->rtc);
> -}
> -
> -static int ds3232_remove(struct i2c_client *client)
> -{
> -	struct ds3232 *ds3232 = i2c_get_clientdata(client);
> -
> -	if (client->irq > 0) {
> -		mutex_lock(&ds3232->mutex);
> -		ds3232->exiting = 1;
> -		mutex_unlock(&ds3232->mutex);
> -
> -		devm_free_irq(&client->dev, client->irq, client);
> -		cancel_work_sync(&ds3232->work);
> -	}
> -
> -	return 0;
> -}
> -
> -#ifdef CONFIG_PM_SLEEP
> -static int ds3232_suspend(struct device *dev)
> -{
> -	struct ds3232 *ds3232 = dev_get_drvdata(dev);
> -	struct i2c_client *client = to_i2c_client(dev);
> -
> -	if (device_can_wakeup(dev)) {
> -		ds3232->suspended = true;
> -		if (irq_set_irq_wake(client->irq, 1)) {
> -			dev_warn_once(dev, "Cannot set wakeup source\n");
> -			ds3232->suspended = false;
> -		}
> -	}
> -
> -	return 0;
> -}
> -
> -static int ds3232_resume(struct device *dev)
> -{
> -	struct ds3232 *ds3232 = dev_get_drvdata(dev);
> -	struct i2c_client *client = to_i2c_client(dev);
> -
> -	if (ds3232->suspended) {
> -		ds3232->suspended = false;
> -
> -		/* Clear the hardware alarm pend flag */
> -		schedule_work(&ds3232->work);
> -
> -		irq_set_irq_wake(client->irq, 0);
> -	}
> -
> -	return 0;
> -}
> -#endif
> -
> -static const struct dev_pm_ops ds3232_pm_ops = {
> -	SET_SYSTEM_SLEEP_PM_OPS(ds3232_suspend, ds3232_resume)
> -};
> -
> -static const struct i2c_device_id ds3232_id[] = {
> -	{ "ds3232", 0 },
> -	{ }
> -};
> -MODULE_DEVICE_TABLE(i2c, ds3232_id);
> -
> -static struct i2c_driver ds3232_driver = {
> -	.driver = {
> -		.name = "rtc-ds3232",
> -		.pm	= &ds3232_pm_ops,
> -	},
> -	.probe = ds3232_probe,
> -	.remove = ds3232_remove,
> -	.id_table = ds3232_id,
> -};
> -
> -module_i2c_driver(ds3232_driver);
> -
> -MODULE_AUTHOR("Srikanth Srinivasan <srikanth.srinivasan@freescale.com>");
> -MODULE_DESCRIPTION("Maxim/Dallas DS3232 RTC Driver");
> -MODULE_LICENSE("GPL");
> -- 
> 2.5.0
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
