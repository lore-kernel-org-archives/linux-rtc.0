Date: Thu, 9 Apr 2015 18:56:42 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: rtc-linux@googlegroups.com
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Alessandro Zummo <a.zummo@towertech.it>,
	linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [rtc-linux] Re: [PATCH v2 2/2] rtc: add rtc-abx80x, a driver for
 the Abracon AB x80x i2c rtc
Message-ID: <20150409165642.GC20669@piout.net>
References: <1427856743-26625-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1427856743-26625-3-git-send-email-alexandre.belloni@free-electrons.com>
 <20150409133122.GA4969@frolo.macqel>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150409133122.GA4969@frolo.macqel>
List-ID: <rtc-linux.googlegroups.com>

On 09/04/2015 at 15:31:22 +0200, Philippe De Muyter wrote :
> > +static int abx80x_rtc_read_time(struct device *dev, struct rtc_time *tm)
> > +{
> > +	struct i2c_client *client = to_i2c_client(dev);
> > +	unsigned char date[8];
> > +	int err;
> > +
> > +	err = i2c_smbus_read_i2c_block_data(client, ABX8XX_REG_HTH,
> > +					    sizeof(date), date);
> > +	if (err < 0) {
> > +		dev_err(&client->dev, "Unable to read date\n");
> > +		return -EIO;
> > +	}
> > +
> > +	tm->tm_sec = bcd2bin(date[ABX8XX_REG_SC] & 0x7F);
> > +	tm->tm_min = bcd2bin(date[ABX8XX_REG_MN] & 0x7F);
> > +	tm->tm_hour = bcd2bin(date[ABX8XX_REG_HR] & 0x3F);
> > +	tm->tm_wday = date[ABX8XX_REG_WD] & 0x7;
> > +	tm->tm_mday = bcd2bin(date[ABX8XX_REG_DA] & 0x3F);
> > +	tm->tm_mon = bcd2bin(date[ABX8XX_REG_MO] & 0x1F) - 1;
> > +	tm->tm_year = bcd2bin(date[ABX8XX_REG_YR]) + 100;
> 
> Just a minor nit: I would rather not name the buffer 'date', but 'buf' like
> in abx80x_rtc_set_time.
> 

Ok but I won't have time to respin before the merge window, can you send
a v3 with that change?

> > +
> > +	err = rtc_valid_tm(tm);
> > +	if (err < 0)
> > +		dev_err(&client->dev, "retrieved date/time is not valid.\n");
> > +
> > +	return err;
> > +}
> > +
> > +static int abx80x_rtc_set_time(struct device *dev, struct rtc_time *tm)
> > +{
> > +	struct i2c_client *client = to_i2c_client(dev);
> > +	unsigned char buf[8];
> > +	int err;
> > +
> ...
> > +static const struct i2c_device_id abx80x_id[] = {
> > +	{ "abx80x", ABX80X },
> 
> should become
> 	{ "abx80x-rtc", ABX80X },
> > +	{ "ab0801", AB0801 },
> > +	{ "ab0803", AB0803 },
> > +	{ "ab0804", AB0804 },
> > +	{ "ab0805", AB0805 },
> > +	{ "ab1801", AB1801 },
> > +	{ "ab1803", AB1803 },
> > +	{ "ab1804", AB1804 },
> > +	{ "ab1805", AB1805 },
> > +	{ }
> and likewise

See my other answer, it would be redundant.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
