Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27BA541D20F
	for <linux-rtc@vger.kernel.org>; Mon,  3 Aug 2026 20:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785789182; cv=none; b=POXAkkCGvZYg+9J35g1EzUagF+y5bclffEWWiw5uUVLr4ZGUn26OqOqJsRX+0TIvGQ2oamWBe+YRMQdSll9JcR0wmkakQ0Rmk+4ENZQDwqazsBxXYkJCwx3vaeLVna8otOiKSWK+eG+Mrp+HiDbmMVLPzwBRHd3eycScDXNpUQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785789182; c=relaxed/simple;
	bh=nqSpLXnbQZzJq6PZBs/MbADaKMSUv/rCgrrAXQ8do2k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZnEIXssdzWTcfUAbJ8BrQfUhQd2BtuYHifH+JiGH7/LE143OWWsGU7RSLrN82XQewdbylo8jrgRe2kt4244fhYAXrZYKWqFDoTInKrS0IY2kgdXTEsd3FVwf4oid17omAcjML2B+nJGUUxTJja9PRjKFvuGwrpO9CwlgLcwK7q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V6qVC/E6; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V6qVC/E6"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4954dff6536so17304595e9.0
        for <linux-rtc@vger.kernel.org>; Mon, 03 Aug 2026 13:33:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785789179; x=1786393979; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=rApWxITnrHnc04C0bper7oYi+AJK0f2NsvvyV/Q/8B0=;
        b=V6qVC/E6iQtPgVGIxkNjV/aalDH//k4KbNrikzN+mDbEw5rUVc/NrU8oKPEH5NJDgd
         dBNdpOeaKaZK/uC75/8e93aRNxW7iJnZ8ZHYFC1Vlkvg49eaTLlOUCO1jn35UmgHO54I
         g14CXUNmoe9QMxyedg8OVqDLQVwYbzpz9yFHTtqb+5zTvGy2POnaM0iird3PUEJ7MPXf
         Ijo+FBZs9G+fhMqEJ23o84yAvwzOxhwPhiNgBcqp1iDrNf7fmpN/OWwpkwFNnOK258Di
         VZD2ja0nRsLFcsr2xi49svBe29p9inLm5uuHd60TPYBbQNMUQMpIFp3mLkepbHh5QLXx
         tSHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785789179; x=1786393979;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=rApWxITnrHnc04C0bper7oYi+AJK0f2NsvvyV/Q/8B0=;
        b=Zjoy8eU7LDdjcoN95pn2CLBq9I5Nc4QbNQjU/rLAfYnlPdE1p8K1s9TyOpQRorf28v
         X7ql5+IG7Dwrgf0TMAQVgU0XnJgTzr4s6Vv2YDiBI0tilsOmMYnaWRuhvIYvxo9DTLPg
         TFhP1lfTYcSnZaauYMVtsq6XuNRpE6cv3LvRRi0KSY08X4sKQuh4Gf8PrAx2u6pl1YOe
         12SxFotqkKs48VeIHAMgoviLC3MS+mxw7M/rW+6/YX+fLpL4Z9GYftB5Jg4dQo28TaSA
         2XcAAK6mszYb77TE8fLDPl6TwISi2Xa1lGOOuuLLxg/K5Av9tbshGRf/mbeVqbblz80i
         FxbQ==
X-Forwarded-Encrypted: i=1; AHgh+RpbjhEQu54+ql3lMfTqwd4aE4REd4Y3wpq+Vp1btlv5AmMD7gzh0D7TxMBgw0TZY+QVakG8k+jxhFc=@vger.kernel.org
X-Gm-Message-State: AOJu0YykEQinpdT7G0/pHWRZhOyA3H2En/bV3REaaw90ge+qOjcVLrrC
	JvTCcYNTVQYRoRzEl8mHM0R+cvIBpmhfG/9Ma4lT1Dg1xos+sm6PpbEV
X-Gm-Gg: AR+sD12kdOC6xHuFAV4ps7VGcuTudINCLSMC97yAsqmiuiMotd7MhnmMQ7Xzue0Gl3C
	TzQW8u/kDG77/UVzHf6XNi3GnsnNXybZ3OkhlfivAifpIYuVgOJ77eKn+O+J0mHJqCYwxAkYhAd
	CwOygzpWE0opnyFfsvgIPoWvqrPC42oUIbb1LycW5mBj3bzWJvUIud/EDybV65CEqxz6xNM3jjw
	SI8K61hK/K40T5RnT7rBk59YTUTqjrwIaqVg+mVBhppiHdI96hffQoPZ78y1wONh5Gtv57NoW0f
	yYJqSH3rf/A9R4c9iDBaCdoSpXo0GWMPieTURTDo1KIkhrnDUesrRwZivhZWQEzyWTf1umBFkAG
	zv2Go5IOQwD/Xp8GSKneTeNm7o6EpwJD0vWJUoeLJwQm1Ar7FJEIkIY+bR+gFEJ+d7n/W9ANXlH
	IJRNnscHX8ULWFVeWXWMJXYo8LaXcRCVX8gUIP/t+wJg38JRuj/+FSPFTImzEfTpHqMbgahJOEm
	mI=
X-Received: by 2002:a05:600c:154b:b0:499:49a6:4388 with SMTP id 5b1f17b1804b1-49949a643f9mr33545705e9.17.1785789179046;
        Mon, 03 Aug 2026 13:32:59 -0700 (PDT)
Received: from antoniarch ([78.209.183.178])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4994a0f7b73sm26259495e9.9.2026.08.03.13.32.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 13:32:58 -0700 (PDT)
Date: Mon, 3 Aug 2026 22:31:28 +0200
From: Antoni Pokusinski <apokusinski01@gmail.com>
To: sashiko-reviews@lists.linux.dev
Cc: robh@kernel.org, Alexandre Belloni <alexandre.belloni@bootlin.com>, 
	conor+dt@kernel.org, linux-rtc@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 4/8] rtc: abx80x: add irq to struct abx80x_priv
Message-ID: <anD5lUnSpYMtkuyg@antoniarch>
References: <20260731184831.44037-1-apokusinski01@gmail.com>
 <20260731184831.44037-5-apokusinski01@gmail.com>
 <20260731190450.548A81F00AC4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260731190450.548A81F00AC4@smtp.kernel.org>

On Fri, Jul 31, 2026 at 07:04:49PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] Read-modify-write of the status register introduces a race condition that loses interrupts.
> - [High] Unconditional failure in `abx80x_read_alarm` due to incorrect handling of `i2c_smbus_read_i2c_block_data` return value.
> --
> 
> --- Patch [4]: [PATCH v3 4/8] rtc: abx80x: add irq to struct abx80x_priv ---
> commit be354d8ef94de08e1314876fad55888243ca019f
> Author: Antoni Pokusinski <apokusinski01@gmail.com>
> 
> rtc: abx80x: add irq to struct abx80x_priv
>     
> This adds the irq field to struct abx80x_priv so the interrupt number is not
> strictly tied to the i2c_client structure. This allows it to be more easily
> accessed for ABX81X SPI clocks.
> 
> > diff --git a/drivers/rtc/rtc-abx80x.c b/drivers/rtc/rtc-abx80x.c
> > --- a/drivers/rtc/rtc-abx80x.c
> > +++ b/drivers/rtc/rtc-abx80x.c
> > @@ -299,11 +300,12 @@ static irqreturn_t abx80x_handle_irq(int irq, void *dev_id)
> 
> [Severity: High]
> This is a pre-existing issue, but I noticed a potential race condition with
> the status register.
> 
> In abx80x_handle_irq(), there is a read-modify-write sequence:
> 
> 	status = i2c_smbus_read_byte_data(client, ABX8XX_REG_STATUS);
> 	...
> 	i2c_smbus_write_byte_data(client, ABX8XX_REG_STATUS,
> 				  status & ~(ABX8XX_STATUS_AF | ABX8XX_STATUS_WDT));
> 
> If a hardware interrupt (such as an RTC alarm or watchdog) sets a new flag
> in ABX8XX_REG_STATUS exactly between the read and write calls, wouldn't the
> write operation write back a 0 for the newly set bit and inadvertently clear
> it without handling it?
> 
> This same pattern appears to be present in abx80x_ioctl() as well:
> 
> 	tmp = i2c_smbus_write_byte_data(client, ABX8XX_REG_STATUS,
> 					status);
> 
> Could this cause hardware interrupts or status flags to be silently dropped?
> 
> >  static int abx80x_read_alarm(struct device *dev, struct rtc_wkalrm *t)
> >  {
> >  	struct i2c_client *client = to_i2c_client(dev);
> > +	struct abx80x_priv *priv = i2c_get_clientdata(client);
> >  	unsigned char buf[7];
> >  
> >  	int irq_mask, err;
> >  
> > -	if (client->irq <= 0)
> > +	if (priv->irq <= 0)
> >  		return -EINVAL;
> >  
> >  	err = i2c_smbus_read_i2c_block_data(client, ABX8XX_REG_ASC,
> 
> [Severity: High]
> This isn't a bug introduced by this patch, but does this error check work
> as intended?
> 
> i2c_smbus_read_i2c_block_data() returns the number of bytes read (which
> would be 7) on success.
> 
> Looking at the code just below this in abx80x_read_alarm():
> 
> 	err = i2c_smbus_read_i2c_block_data(client, ABX8XX_REG_ASC,
> 					    sizeof(buf), buf);
> 	if (err)
> 		return err;
> 
> Wouldn't this evaluate to true on a successful read, causing the function
> to prematurely abort and pass the byte count back as an error code?
Will add a separate patch to fix that in v4 as it may be useful to
backport it to stable releases 
> 
> [ ... ]
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260731184831.44037-1-apokusinski01@gmail.com?part=4
