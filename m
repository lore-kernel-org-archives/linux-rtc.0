Return-Path: <phdm@macqel.be>
Date: Sun, 15 Mar 2015 16:10:17 +0100
From: Philippe De Muyter <phdm@macqel.be>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Alessandro Zummo <a.zummo@towertech.it>, rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 2/2] rtc: add rtc-abx80x, a driver for the Abracon AB
	x80x i2c rtc
Message-ID: <20150315151017.GA31712@frolo.macqel>
References: <1426327546-8085-1-git-send-email-alexandre.belloni@free-electrons.com> <1426327546-8085-3-git-send-email-alexandre.belloni@free-electrons.com> <20150314124441.GA11905@frolo.macqel> <20150314180911.GC4560@piout.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150314180911.GC4560@piout.net>
List-ID: <rtc-linux.googlegroups.com>

On Sat, Mar 14, 2015 at 07:09:11PM +0100, Alexandre Belloni wrote:
> On 14/03/2015 at 13:44:41 +0100, Philippe De Muyter wrote :
> > > +	tm->tm_sec = bcd2bin(date[ABX8XX_REG_SC] & 0x7F);
> > > +	tm->tm_min = bcd2bin(date[ABX8XX_REG_MN] & 0x7F);
> > > +	tm->tm_hour = bcd2bin(date[ABX8XX_REG_HR] & 0x3F);
> > > +	tm->tm_wday = date[ABX8XX_REG_WD] & 0x7;
> > > +	tm->tm_mday = bcd2bin(date[ABX8XX_REG_DA] & 0x3F);
> > > +	tm->tm_mon = bcd2bin(date[ABX8XX_REG_MO] & 0x1F) - 1;
> > > +	tm->tm_year = bcd2bin(date[ABX8XX_REG_YR]);
> > > +	if (tm->tm_year < 70)
> > 
> > Is that still useful for a driver written in 2015 ?
> > 
> 
> I'd say that this is actually the only correct way to do it. Only dates
> before 01/01/1970 00:00 are considered invalid. So, unless adding a
> check like:
> 
> if (tm->tm_year < 100)
> 	return -EINVAL;
> 
> in abx80x_rtc_set_time, setting and then reading a date before 2000 will
> fail silently. I'm open to add that check.

You are right.  It is actually more a consistency problem between rtc
drivers and thus a question for the rtc-subsytem maintainer.

Philippe

-- 
Philippe De Muyter +32 2 6101532 Macq SA rue de l'Aeronef 2 B-1140 Bruxelles
