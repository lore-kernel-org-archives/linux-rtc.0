Return-Path: <rtc-linux+bncBDE6ZCHLVAOBBQ64UKYAKGQEN7I3QTQ@googlegroups.com>
Received: from eso.teric.us (eso.teric.us. [69.164.192.171])
        by gmr-mx.google.com with ESMTP id mx5si1216246igb.1.2015.09.27.20.04.34
        for <rtc-linux@googlegroups.com>;
        Sun, 27 Sep 2015 20:04:34 -0700 (PDT)
Date: Sun, 27 Sep 2015 22:04:34 -0500
From: Josh Cartwright <joshc@eso.teric.us>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>, rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org
Subject: [rtc-linux] Re: [PATCH] rtc: Add a driver for Micro Crystal RV8803
Message-ID: <20150928030434.GJ3543@kryptos>
References: <1443275679-21459-1-git-send-email-alexandre.belloni@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1443275679-21459-1-git-send-email-alexandre.belloni@free-electrons.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

Hello Alexandre-

Few comments below.

On Sat, Sep 26, 2015 at 03:54:39PM +0200, Alexandre Belloni wrote:
> This driver supports the following functions:
>  - reading and settings time
>  - alarms when connected to an IRQ
>  - reading and clearing the voltage low flags
>  - nvram
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> ---
[..]
> +static irqreturn_t rv8803_handle_irq(int irq, void *dev_id)
> +{
> +	struct i2c_client *client = dev_id;
> +	struct rv8803_data *rv8803 = i2c_get_clientdata(client);
> +	unsigned long events = 0;
> +	u8 flags;
> +
> +	flags = i2c_smbus_read_byte_data(client, RV8803_FLAG);
> +	if (flags <= 0)
> +		return IRQ_HANDLED;

Returning IRQ_HANDLED when no interrupt condition is met.  That seems
like a bad idea.

> +	if (flags & RV8803_FLAG_V1F)
> +		dev_warn(&client->dev, "Voltage low, temperature compensation stopped.\n");
> +
> +	if (flags & RV8803_FLAG_V2F)
> +		dev_warn(&client->dev, "Voltage low, data loss detected.\n");
> +
> +	if (flags & RV8803_FLAG_TF) {
> +		flags &= ~RV8803_FLAG_TF;
> +		rv8803->ctrl &= ~RV8803_CTRL_TIE;
> +		events |= RTC_PF;
> +	}
> +
> +	if (flags & RV8803_FLAG_AF) {
> +		flags &= ~RV8803_FLAG_AF;
> +		rv8803->ctrl &= ~RV8803_CTRL_AIE;
> +		events |= RTC_AF;
> +	}
> +
> +	if (flags & RV8803_FLAG_UF) {
> +		flags &= ~RV8803_FLAG_UF;
> +		rv8803->ctrl &= ~RV8803_CTRL_UIE;
> +		events |= RTC_UF;
> +	}
> +
> +	if (events) {
> +		rtc_update_irq(rv8803->rtc, 1, events);
> +		i2c_smbus_write_byte_data(client, RV8803_FLAG, flags);

How are the many read-modify-write cycles for flags safe without any
form of synchronization?  (Especially given the interrupt handler isn't
under ops_lock).

> +		i2c_smbus_write_byte_data(rv8803->client, RV8803_CTRL,
> +					  rv8803->ctrl);
> +	}
> +
> +	return IRQ_HANDLED;
> +}
> +
[..]
> +static int rv8803_get_alarm(struct device *dev, struct rtc_wkalrm *alrm)
> +{
> +	struct rv8803_data *rv8803 = dev_get_drvdata(dev);
> +	struct i2c_client *client = rv8803->client;
> +	u8 alarmvals[3];
> +	int flags, ret;
> +
> +	if (client->irq <= 0)
> +		return -EINVAL;

It'd be cleaner just to have a second set of rtc_class_ops that can be
switched between based on whether a valid interrupt is specified.

  Josh

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
