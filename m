Return-Path: <joe@perches.com>
Message-ID: <1425158574.31561.1.camel@perches.com>
Subject: Re: [PATCH] rtc: add Abracon ABx80x driver
From: Joe Perches <joe@perches.com>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>, linux-kernel@vger.kernel.org,
	rtc-linux@googlegroups.com
Date: Sat, 28 Feb 2015 13:22:54 -0800
In-Reply-To: <20150228205243.GF4094@piout.net>
References: 
	<1425150876-8141-1-git-send-email-alexandre.belloni@free-electrons.com>
	 <1425151935.25697.5.camel@perches.com> <20150228205243.GF4094@piout.net>
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
List-ID: <rtc-linux.googlegroups.com>

On Sat, 2015-02-28 at 21:52 +0100, Alexandre Belloni wrote:
> > > diff --git a/drivers/rtc/rtc-abx80x.c b/drivers/rtc/rtc-abx80x.c
> > []
> > > +static int ab08xx_get_datetime(struct i2c_client *client, struct rtc_time *tm)
[]
> > > +	tm->tm_sec = bcd2bin(date[AB08XX_REG_SC] & 0x7F);
> > > +	tm->tm_min = bcd2bin(date[AB08XX_REG_MN] & 0x7F);
> > > +	tm->tm_hour = bcd2bin(date[AB08XX_REG_HR] & 0x3F);
> > > +	tm->tm_wday = date[AB08XX_REG_WD] & 0x7;
> > > +	tm->tm_mday = bcd2bin(date[AB08XX_REG_DA] & 0x3F);
> > > +	tm->tm_mon = bcd2bin(date[AB08XX_REG_MO] & 0x1F) - 1;
> > > +	tm->tm_year = bcd2bin(date[AB08XX_REG_YR]);
> > > +	if (tm->tm_year < 70)
> > > +		tm->tm_year += 100;
> > > +
> > > +	err = rtc_valid_tm(tm);
> > > +	if (err < 0)
> > > +		dev_err(&client->dev, "retrieved date/time is not valid.\n");
> > 
> > Is setting the date to a known bad value really the desired thing?
> 
> I'm not sure what you mean here, isn't that what is done in almost all
> the rtc drivers?

Dunno.

> A lot of those are simply using return
> rtc_valid_tm(tm); My guess is that a userspace program must not try to
> use tm when errno is not 0.

My thought was that it might be better to
use a local struct rtc_time r like

	r.tm_sec = bcd2bin(date[AB08XX_REG_SC] & 0x7F);
	r.tm_min = bcd2bin(date[AB08XX_REG_MN] & 0x7F);
	r.tm_hour = bcd2bin(date[AB08XX_REG_HR] & 0x3F);
	r.tm_wday = date[AB08XX_REG_WD] & 0x7;
	r.tm_mday = bcd2bin(date[AB08XX_REG_DA] & 0x3F);
	r.tm_mon = bcd2bin(date[AB08XX_REG_MO] & 0x1F) - 1;
	r.tm_year = bcd2bin(date[AB08XX_REG_YR]);
	if (r.tm_year < 70)
		r.tm_year += 100;

	err = rtc_valid_tm(&r);
	if (!err)
		*tm = r;
	else
		dev_err(&client->dev, "retrieved date/time is not valid\n");

	return err;
