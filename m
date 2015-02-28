Date: Sun, 1 Mar 2015 00:09:35 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Joe Perches <joe@perches.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>, linux-kernel@vger.kernel.org,
	rtc-linux@googlegroups.com
Subject: Re: [PATCH] rtc: add Abracon ABx80x driver
Message-ID: <20150228230935.GG4094@piout.net>
References: <1425150876-8141-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1425151935.25697.5.camel@perches.com>
 <20150228205243.GF4094@piout.net>
 <1425158574.31561.1.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1425158574.31561.1.camel@perches.com>
List-ID: <rtc-linux.googlegroups.com>

On 28/02/2015 at 13:22:54 -0800, Joe Perches wrote :
> My thought was that it might be better to
> use a local struct rtc_time r like
> 
> 	r.tm_sec = bcd2bin(date[AB08XX_REG_SC] & 0x7F);
> 	r.tm_min = bcd2bin(date[AB08XX_REG_MN] & 0x7F);
> 	r.tm_hour = bcd2bin(date[AB08XX_REG_HR] & 0x3F);
> 	r.tm_wday = date[AB08XX_REG_WD] & 0x7;
> 	r.tm_mday = bcd2bin(date[AB08XX_REG_DA] & 0x3F);
> 	r.tm_mon = bcd2bin(date[AB08XX_REG_MO] & 0x1F) - 1;
> 	r.tm_year = bcd2bin(date[AB08XX_REG_YR]);
> 	if (r.tm_year < 70)
> 		r.tm_year += 100;
> 
> 	err = rtc_valid_tm(&r);
> 	if (!err)
> 		*tm = r;
> 	else
> 		dev_err(&client->dev, "retrieved date/time is not valid\n");
> 
> 	return err;
> 

I'm sure this is not needed as userspace has to bail out if the ioctl
fails. I'll let that up to the rtc maintainers though.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
