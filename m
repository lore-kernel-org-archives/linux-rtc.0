Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93C2427FB1C;
	Wed, 19 Aug 2026 22:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787178058; cv=none; b=Z3grZCQYh+pLSZoXRArciW8tJSo0loByrb5SavwLGvzSAxgxlbwMN/tjfR4IimQxBLO8VkWTfpbmg4BtDAN9lAqRTH+FzaPOZ5GQ7913FuX9EBDhCa3BGKzWe40A5jOvpzB1n8Y7bYskyqfLrOg7XY1UKBoXiFic5POwvGG4+IY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787178058; c=relaxed/simple;
	bh=ynAi7sEIWWGF7TW2QZerhgpmS3rJppEBTwVA4qpDCkk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f0rcDdFjQ49zsVJOGRwxeFT6NXiFE1LduJ+G0pCRKhzXQo/tLVcf9DAKeoNabzQLVKLwOVXGIhZ7IYB/2FaSmiy3LI/KGfiv6PVIrBH4nnuUks8aBh2LDRXeriOOQ4hRQrR94T+bmRpX30gC8+pLDmdEtXTQvE3/L0R/R2D3Uws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=pN/znz8l; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="pN/znz8l"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 93A0E1A174E;
	Wed, 19 Aug 2026 22:20:52 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 501F25FF42;
	Wed, 19 Aug 2026 22:20:52 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 26DC711C75BF8;
	Thu, 20 Aug 2026 00:20:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1787178047; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=/B6tPYN5LCOlrm1Ya2eKp2YLySXslAme9Vq9iWjNY+I=;
	b=pN/znz8lKHXV/fLNj/PjtYdM9DGj/bz3dKhueioERvvYfFpjXdeG/3eczqJaZihqWNsasl
	yp9p4+pdZNUj27FpapGOXrbxg1ebxiettOkMEagwrVjz6VBqr4BWfvdtUt+zayb+EL5f12
	bZWOVH9hPVTCiF/Vj3HmyyGHGDPrN8j+kTAp28SE+YvEQU9wchjwHtGl8pLdCfSPvfYPw7
	CeI8vaXlksUW5wURrrOTHOH8kEMABcoODvJg6ZvG92ZUdzfGyu0wjTm5vUjR5YVWs8NMf9
	zu8PDWxgPJe6Q3ESqU0MPjXk6pkDjbO+W70j2XuV/TnIKe65gLa9cLWX4s02EQ==
Date: Thu, 20 Aug 2026 00:20:43 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Markus Probst <markus.probst@posteo.de>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <uwe@kleine-koenig.org>,
	Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@bootlin.com>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Michael Langer <michael.brainbug.langer@googlemail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Walleij <linusw@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-rtc@vger.kernel.org,
	devicetree@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 4/6] rtc: s35390a: force 24-hour mode
Message-ID: <202608192220436c9c7207@mail.local>
References: <20260820-rtc_s35390a_int1-v5-0-5eb4ef85c6a9@posteo.de>
 <20260820-rtc_s35390a_int1-v5-4-5eb4ef85c6a9@posteo.de>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260820-rtc_s35390a_int1-v5-4-5eb4ef85c6a9@posteo.de>
X-Last-TLS-Session-Version: TLSv1.3

On 19/08/2026 22:05:56+0000, Markus Probst wrote:
> Instead of trying to remember the current 12/24-hour mode, which could
> result in time corruption if out of sync, we force the use of the 24-hour
> mode. Set to 24-hour mode if in 12-hour mode on startup and assume
> 24-hour mode. The 24-hour mode is already forced on reset.
> 
> Signed-off-by: Markus Probst <markus.probst@posteo.de>
> ---
>  drivers/rtc/rtc-s35390a.c | 67 +++++++++++++++++++++--------------------------
>  1 file changed, 30 insertions(+), 37 deletions(-)
> 
> diff --git a/drivers/rtc/rtc-s35390a.c b/drivers/rtc/rtc-s35390a.c
> index 575bb256eb25..b34a3f7e8476 100644
> --- a/drivers/rtc/rtc-s35390a.c
> +++ b/drivers/rtc/rtc-s35390a.c
> @@ -64,7 +64,6 @@ MODULE_DEVICE_TABLE(of, s35390a_of_match);
>  
>  struct s35390a {
>  	struct i2c_client *client[8];
> -	int twentyfourhour;
>  };
>  
>  static int s35390a_set_reg(struct s35390a *s35390a, int reg, u8  *buf, int len)
> @@ -181,31 +180,6 @@ static int s35390a_disable_test_mode(struct s35390a *s35390a)
>  	return s35390a_set_reg(s35390a, S35390A_CMD_STATUS2, buf, sizeof(buf));
>  }
>  
> -static char s35390a_hr2reg(struct s35390a *s35390a, int hour)
> -{
> -	if (s35390a->twentyfourhour)
> -		return bin2bcd(hour);
> -
> -	if (hour < 12)
> -		return bin2bcd(hour);
> -
> -	return 0x40 | bin2bcd(hour - 12);
> -}
> -
> -static int s35390a_reg2hr(struct s35390a *s35390a, char reg)
> -{
> -	unsigned hour;
> -
> -	if (s35390a->twentyfourhour)
> -		return bcd2bin(reg & 0x3f);
> -
> -	hour = bcd2bin(reg & 0x3f);
> -	if (reg & 0x40)
> -		hour += 12;
> -
> -	return hour;
> -}
> -
>  static int s35390a_rtc_set_time(struct device *dev, struct rtc_time *tm)
>  {
>  	struct i2c_client *client = to_i2c_client(dev);
> @@ -225,7 +199,7 @@ static int s35390a_rtc_set_time(struct device *dev, struct rtc_time *tm)
>  	buf[S35390A_BYTE_MONTH] = bin2bcd(tm->tm_mon + 1);
>  	buf[S35390A_BYTE_DAY] = bin2bcd(tm->tm_mday);
>  	buf[S35390A_BYTE_WDAY] = bin2bcd(tm->tm_wday);
> -	buf[S35390A_BYTE_HOURS] = s35390a_hr2reg(s35390a, tm->tm_hour);
> +	buf[S35390A_BYTE_HOURS] = bin2bcd(tm->tm_hour);
>  	buf[S35390A_BYTE_MINS] = bin2bcd(tm->tm_min);
>  	buf[S35390A_BYTE_SECS] = bin2bcd(tm->tm_sec);
>  
> @@ -256,7 +230,7 @@ static int s35390a_rtc_read_time(struct device *dev, struct rtc_time *tm)
>  
>  	tm->tm_sec = bcd2bin(buf[S35390A_BYTE_SECS]);
>  	tm->tm_min = bcd2bin(buf[S35390A_BYTE_MINS]);
> -	tm->tm_hour = s35390a_reg2hr(s35390a, buf[S35390A_BYTE_HOURS]);
> +	tm->tm_hour = bcd2bin(buf[S35390A_BYTE_HOURS] & 0x3f);
>  	tm->tm_wday = bcd2bin(buf[S35390A_BYTE_WDAY]);
>  	tm->tm_mday = bcd2bin(buf[S35390A_BYTE_DAY]);
>  	tm->tm_mon = bcd2bin(buf[S35390A_BYTE_MONTH]) - 1;
> @@ -325,8 +299,7 @@ static int s35390a_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alm)
>  	else
>  		buf[S35390A_ALRM_BYTE_WDAY] = 0;
>  
> -	buf[S35390A_ALRM_BYTE_HOURS] = s35390a_hr2reg(s35390a,
> -			alm->time.tm_hour) | 0x80;
> +	buf[S35390A_ALRM_BYTE_HOURS] = bin2bcd(alm->time.tm_hour) | 0x80;
>  	buf[S35390A_ALRM_BYTE_MINS] = bin2bcd(alm->time.tm_min) | 0x80;
>  
>  	if (alm->time.tm_hour >= 12)
> @@ -381,8 +354,7 @@ static int s35390a_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alm)
>  
>  	if (buf[S35390A_ALRM_BYTE_HOURS] & 0x80)
>  		alm->time.tm_hour =
> -			s35390a_reg2hr(s35390a,
> -				       buf[S35390A_ALRM_BYTE_HOURS] & ~0x80);
> +			bcd2bin(buf[S35390A_ALRM_BYTE_HOURS] & 0x3f);
>  
>  	if (buf[S35390A_ALRM_BYTE_MINS] & 0x80)
>  		alm->time.tm_min = bcd2bin(buf[S35390A_ALRM_BYTE_MINS] & ~0x80);
> @@ -459,7 +431,7 @@ static int s35390a_probe(struct i2c_client *client)
>  	unsigned int i;
>  	struct s35390a *s35390a;
>  	struct rtc_device *rtc;
> -	u8 buf, status1;
> +	u8 buf, status1, time[7];
>  	struct device *dev = &client->dev;
>  	struct nvmem_config nvmem_cfg = {
>  		.name = "s35390a_nvram",
> @@ -503,10 +475,31 @@ static int s35390a_probe(struct i2c_client *client)
>  		return err_read;
>  	}
>  
> -	if (status1 & S35390A_FLAG_24H)
> -		s35390a->twentyfourhour = 1;
> -	else
> -		s35390a->twentyfourhour = 0;
> +	if (!(status1 & S35390A_FLAG_24H) && err_read != 1) {
> +		unsigned int hour;
> +
> +		status1 |= S35390A_FLAG_24H;
> +
> +		err = s35390a_get_reg(s35390a, S35390A_CMD_TIME1, time, sizeof(time));
> +		if (err < 0)
> +			return dev_err_probe(dev, err, "reading 12-hour time failed\n");
> +
> +		/* converting to 24-hour time */
> +		time[S35390A_BYTE_HOURS] = bitrev8(time[S35390A_BYTE_HOURS]);
> +		hour = bcd2bin(time[S35390A_BYTE_HOURS] & 0x3f);
> +		if (time[S35390A_BYTE_HOURS] & 0x40)
> +			hour += 12;
> +
> +		time[S35390A_BYTE_HOURS] = bitrev8(bin2bcd(hour));
> +
> +		err = s35390a_set_reg(s35390a, S35390A_CMD_STATUS1, &status1, sizeof(status1));
> +		if (err < 0)
> +			return dev_err_probe(dev, err, "setting 24-hour mode failed\n");
> +
> +		err = s35390a_set_reg(s35390a, S35390A_CMD_TIME1, time, sizeof(time));
> +		if (err < 0)
> +			return dev_err_probe(dev, err, "setting 24-hour time failed\n");

No, don't do this, this will break existing users as your conversion may
happen after a minute rollover. The only function in which you are
allowed to change the time registers is set_time. You definitively need
to be able to read 12H mode time but you are allowed to only support
writing 24h time.

Also, this is super verbose, adding strings to the kernel makes it
bloated.

To avoid any desync, simply test for the S35390A_FLAG_24H bit in status
in s35390a_rtc_read_time as the register is already read anyway.


-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
