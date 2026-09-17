Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86A9C4FD796
	for <linux-rtc@vger.kernel.org>; Thu, 17 Sep 2026 18:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789668154; cv=none; b=p8Fz157JyJt65gwUyf22GscLf1ZljZRUL/kSNHUevp+A6iIdIwDG3VrHZVnXPwzPIsXFsOXpBnnwq4VkNO4nkaqbJTLB4N6Z5l6GbJznMXx1SyTd/Hv056Fnqsnp6Z/85Zl7rq1VVYMpUPmyzobgKQ3bdToVOY4RJw3pI9xif1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789668154; c=relaxed/simple;
	bh=fWeVX8x7HAmbo/Np4MivXSYP5FclmPOlzMclAQTIwug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tBBmin+4Q5nGnYDbVzcKNbkN9eujoyrp7XR79aACXsk48kGcI/pAQgqKWnnzBzcc7P9NEbSTfWwI872y1WurorkaFC6NVuqk+NUpqtYRqFeGo4NMhOeJbymnkm71QNTKcOIba3hZGirgE54FeO6Sc/KvCupNurpomj5tnUqWa/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XhW2+0UW; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XhW2+0UW"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49ccfd61ecaso11009115e9.3
        for <linux-rtc@vger.kernel.org>; Thu, 17 Sep 2026 11:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789668151; x=1790272951; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=EP61s3LnDYIz9su7+Im2NBnWl8yHpK6Gkwrf//woF6Y=;
        b=XhW2+0UWDOHoFnrh+PX1pNhUEYPObAdKToRS8AuwUHoHxBZ2IPWNo2qkfxB865Ma6A
         JD2dybwH6xHFdXB+udP7YzovCa73n4uGTcWGeuI1nXLIM0KRYMBY03aJ90W+iqa4P7NP
         zs/rpEdEf9YzvpEURdV0rvSrFdSVxA6g3f7VUMgwXy8SNlXMmxzF0gjXdDFcDHHhRqen
         MqedxrirWaXXrbWRZP40fG32hYLOlUSr5r4u+wrL5vwz1/hClANFvFSccdoPAdgrlKMo
         9W5l4UdcRl4ICpADabfe8kgtD09ktA1PLsztfH/QXl4bS4ODwlVT808Lji86UIbXPTR1
         YhKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789668151; x=1790272951;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=EP61s3LnDYIz9su7+Im2NBnWl8yHpK6Gkwrf//woF6Y=;
        b=W88foYNQAHNFJH2XzOsqhGNO4gMcSvIe+gHltt3WrdNJQVYVbKRilZLna7VkQ7Mssi
         +FMk6tw/fyIMgCblz0ZClxoA6w9lv1YFdUrL3FXXSLS2BuZmz8/tGDGMZdX8TOUT4fzS
         +Zv+WPgyue/+zF18mxcP3WvJhhktj4mD2TloQFJ0FEd4auHGOkg6zaIJ8o7WGDO00bqo
         FrnlrGcPaa7uVbpXdLn6i762FdwLGNhFEq86Bd1IrdQOBDrtKKbJMyS1wIItLK7s4mrD
         KY62aaOM90rOzZ/wuiIJ1aY/GRs5irXFb2kJcJSrteP1qjDulObpYlI7QQK4lj9zFGSt
         NaAA==
X-Forwarded-Encrypted: i=1; AKwUvBzBVsk2Hm48L7kVXSowj6ogJUtZdOLXIGTWiuWmBattHYe3EQBYTHHRg/yi5LAZP3WTZ5lwaCv52lc=@vger.kernel.org
X-Gm-Message-State: AFuF++lu2KS0KFp14kSZODauxNPns/O9qgl5vImVvQJScrXiAXtLi3pu
	wKpMpvdgGbODqVU2fXJf7VzUPN3es8KaYcmUkBgRWRrS57xMu/D9UyJG
X-Gm-Gg: AYBFou0i5y0baEC5fhX7n8faDHCeMf2kU1wy4EMCAU/BqKRX6aIY2l2i04Z40dLKpC4
	hOVNJqJsGE3MLFVaUhoUA+IzwLYyJE1qy7ph/Pcw/6TXAsNaNpCEdtnJ7jRwJA63UQBbfpMrXeq
	uR8nHaHaI1JOUjoBBdKGVasAJ3rGg7jf4WLJVCBhF4sN7xPgQodxTRQG+3XEiht6a8kttiugZ0m
	Jab3HdSxuzswG+GfKn+QNnj8Kp+GIQJWFhSBOR3zGEd4fTRXfiU6Y3l1RFikqxJ3441tqijZlLL
	rhg9V7kEcfz4fgj5t4Q5MivsRvSOkrNeuMD+cLyDVlPa80J7IQ8qlbJEjdbq1sfazeiZJGJIljb
	V+JeLFEAkP44YjaArXYDvaZclX6YgY5jBbZZundt6Vi3wTZ84114e35pR0KtXZpqF/kTs1sfpr4
	NFkoY9cLZgK9QirkFCeEXILRW8z4B3Fo9L0ymm41YbGqA9wWUpJTgOfg==
X-Received: by 2002:a05:600c:4ed4:b0:49c:de80:b833 with SMTP id 5b1f17b1804b1-49eac462571mr89969195e9.2.1789668150501;
        Thu, 17 Sep 2026 11:02:30 -0700 (PDT)
Received: from antoniarch ([78.211.139.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fbd2160c2sm96803245e9.6.2026.09.17.11.02.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 11:02:30 -0700 (PDT)
Date: Thu, 17 Sep 2026 20:00:44 +0200
From: Antoni Pokusinski <apokusinski01@gmail.com>
To: sashiko-reviews@lists.linux.dev
Cc: robh@kernel.org, linux-rtc@vger.kernel.org, devicetree@vger.kernel.org, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, conor+dt@kernel.org
Subject: Re: [PATCH v7 4/9] rtc: abx80x: properly handle shared IRQs
Message-ID: <aqwpLXghj-NWgH8w@antoniarch>
References: <20260916205138.16771-1-apokusinski01@gmail.com>
 <20260916205138.16771-5-apokusinski01@gmail.com>
 <20260916210527.CF14B1F0089A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260916210527.CF14B1F0089A@smtp.kernel.org>

On Wed, Sep 16, 2026 at 09:05:27PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] rtc: abx80x: race condition loses interrupts due to flawed W0C status register clearing
> --
> 
> commit 27cfcb7135851594344aa538f01f8ef1328d2392
> Author: Antoni Pokusinski <apokusinski01@gmail.com>
> 
> rtc: abx80x: properly handle shared IRQs
> 
> This commit updates the abx80x RTC interrupt handler to only return
> IRQ_HANDLED and clear the status register when the alarm or watchdog flags
> are set. It aims to properly support IRQF_SHARED by returning IRQ_NONE
> for unrelated interrupts.
> 
> > diff --git a/drivers/rtc/rtc-abx80x.c b/drivers/rtc/rtc-abx80x.c
> > --- a/drivers/rtc/rtc-abx80x.c
> > +++ b/drivers/rtc/rtc-abx80x.c
> 
> [ ... ]
> 
> > @@ -284,9 +291,15 @@ static irqreturn_t abx80x_handle_irq(int irq, void *dev_id)
> >  	if (status & ABX8XX_STATUS_WDT)
> >  		dev_alert(&client->dev, "watchdog timeout interrupt.\n");
> >  
> > -	i2c_smbus_write_byte_data(client, ABX8XX_REG_STATUS, 0);
> > +	status_flags_clear = status & (ABX8XX_STATUS_AF | ABX8XX_STATUS_WDT);
> >  
> > -	return IRQ_HANDLED;
> > +	if (status_flags_clear) {
> > +		i2c_smbus_write_byte_data(client, ABX8XX_REG_STATUS,
> > +					  status & ~status_flags_clear);
> 
> [Severity: High]
> Does this logic introduce a race condition that loses late-arriving interrupts
> in abx80x_handle_irq()?
> 
> Because the ABX8XX_REG_STATUS register is W0C (write-0-to-clear), any bit
> written as 0 will be cleared in hardware. 
> 
> The expression status & ~status_flags_clear forces a 0 for all bits that
> were 0 during the initial read. If a new hardware interrupt asserts between
> the read and this write, its status bit will be newly set to 1 in hardware.
> However, writing back the old status value forces a 0 for that new bit,
> silently clearing it and losing the event.
> 
> To preserve unhandled or newly asserted bits, the correct write value for a
> W0C register is ~status_flags_clear instead.
>
Not really: if the register bits are written with 1, then during the
next call to `handle_irq()` all the interrupts are reported as pending
(in other words the written ones are preserved). 
In particular, when I was testing the alarm interrupt and the written value was
`~status_flags_clear` as sashiko suggests, I was always getting the WDT
bit enabled and hence the alert "watchdog timeout interrupt" was
printed.
> > +		return IRQ_HANDLED;
> > +	}
> > +
> > +	return IRQ_NONE;
> >  }
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260916205138.16771-1-apokusinski01@gmail.com?part=4
