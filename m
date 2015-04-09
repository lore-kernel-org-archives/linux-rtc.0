Return-Path: <rtc-linux+bncBCRMHO7Q34EBBLH6TGUQKGQEYKZAF4A@googlegroups.com>
Received: from smtp2.macqel.be (smtp2.macqel.be. [109.135.2.61])
        by gmr-mx.google.com with ESMTP id m3si850102wia.1.2015.04.09.06.31.24
        for <rtc-linux@googlegroups.com>;
        Thu, 09 Apr 2015 06:31:24 -0700 (PDT)
Date: Thu, 9 Apr 2015 15:31:22 +0200
From: Philippe De Muyter <phdm@macqel.be>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Alessandro Zummo <a.zummo@towertech.it>, rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: [rtc-linux] Re: [PATCH v2 2/2] rtc: add rtc-abx80x, a driver for the
 Abracon AB x80x i2c rtc
Message-ID: <20150409133122.GA4969@frolo.macqel>
References: <1427856743-26625-1-git-send-email-alexandre.belloni@free-electrons.com> <1427856743-26625-3-git-send-email-alexandre.belloni@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1427856743-26625-3-git-send-email-alexandre.belloni@free-electrons.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

Hi Alexandre,

On Wed, Apr 01, 2015 at 04:52:23AM +0200, Alexandre Belloni wrote:
> From: Philippe De Muyter <phdm@macqel.be>
> 
> This is a basic driver for the ultra-low-power Abracon AB x80x series of RTC
> chips. It supports in particular, the supersets AB0805 and AB1805.
> It allows reading and writing the time, and enables the supercapacitor/
> battery charger.
> 
> [arnd@arndb.de: abx805 depends on i2c]
> Signed-off-by: Philippe De Muyter <phdm@macqel.be>
> Cc: Alessandro Zummo <a.zummo@towertech.it>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
...
> +static int abx80x_rtc_read_time(struct device *dev, struct rtc_time *tm)
> +{
> +	struct i2c_client *client = to_i2c_client(dev);
> +	unsigned char date[8];
> +	int err;
> +
> +	err = i2c_smbus_read_i2c_block_data(client, ABX8XX_REG_HTH,
> +					    sizeof(date), date);
> +	if (err < 0) {
> +		dev_err(&client->dev, "Unable to read date\n");
> +		return -EIO;
> +	}
> +
> +	tm->tm_sec = bcd2bin(date[ABX8XX_REG_SC] & 0x7F);
> +	tm->tm_min = bcd2bin(date[ABX8XX_REG_MN] & 0x7F);
> +	tm->tm_hour = bcd2bin(date[ABX8XX_REG_HR] & 0x3F);
> +	tm->tm_wday = date[ABX8XX_REG_WD] & 0x7;
> +	tm->tm_mday = bcd2bin(date[ABX8XX_REG_DA] & 0x3F);
> +	tm->tm_mon = bcd2bin(date[ABX8XX_REG_MO] & 0x1F) - 1;
> +	tm->tm_year = bcd2bin(date[ABX8XX_REG_YR]) + 100;

Just a minor nit: I would rather not name the buffer 'date', but 'buf' like
in abx80x_rtc_set_time.

> +
> +	err = rtc_valid_tm(tm);
> +	if (err < 0)
> +		dev_err(&client->dev, "retrieved date/time is not valid.\n");
> +
> +	return err;
> +}
> +
> +static int abx80x_rtc_set_time(struct device *dev, struct rtc_time *tm)
> +{
> +	struct i2c_client *client = to_i2c_client(dev);
> +	unsigned char buf[8];
> +	int err;
> +
...
> +static const struct i2c_device_id abx80x_id[] = {
> +	{ "abx80x", ABX80X },

should become
	{ "abx80x-rtc", ABX80X },
> +	{ "ab0801", AB0801 },
> +	{ "ab0803", AB0803 },
> +	{ "ab0804", AB0804 },
> +	{ "ab0805", AB0805 },
> +	{ "ab1801", AB1801 },
> +	{ "ab1803", AB1803 },
> +	{ "ab1804", AB1804 },
> +	{ "ab1805", AB1805 },
> +	{ }
and likewise

Best regards

Philippe

-- 
Philippe De Muyter +32 2 6101532 Macq SA rue de l'Aeronef 2 B-1140 Bruxelles

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
