Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.85.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795182053;
	b=VaH25hGO7hugKta2iobxnaV76z3/lfzy9XXoQSTJe0MwWeTkPfYVSjdwf2AozAUPYAmh
	 2AwY3O2l9Kay40MvzWHL56o6RIJbjQS/DdYw7IOTfBzQYcGAK9F9HTvtnyHucN2vDD5/k
	 5mwi4TbG7b1AKPOINMlwrRnVJ4TNdzfQ3ohHu9GE+UjsXVy7BFNdm3R1FrXFSa1Zrw5f+
	 WySbFHuRCN+X4d8uOnvQKgNqr4rtKAiw4glMEraaCDXZo8f0K3q4oC0rm/Ua3Pn7sV7G+
	 A8cM3nEqb9e4ayX2wO9HVd8UxqxmXxnbMEac+N+ITV/TZpTBHjMFGDgzVQIz/HyNLiA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795182053;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Last-TLS-Session-Version;
	bh=Ew6MOgVIrcp4AtXKSh7rWMjrCWumR7WkQWAedumdhYk=;
	b=OyVGSOUkA/pzoYUmKCORxxHpcgnAS/DRix1u+j17FgLHF63Tj+cjQj64Rv7thzNvgzAQ
	 BUeTnDD/q0G00TQDKw5bK4V6L3IbNPBYn6ExTbXp8soX9DWUEsVKeM+DcZeFOzQfbdWxy
	 MEGwpBw7Rtk5/L4yWKFAdMM6tabjdXB4W29HJeTqpsA4z2JVsOVqLcBrUwywd1O4gHXWr
	 tZsfTahFVILM5bkSPMQeFuM0m4pqixWtLM204P7KqFtDSSiulneuQa7ty49BxiZ2lMcxY
	 1hbpvAv5tpLwUP4dgc/lmnNJGGQ+RmKGQzNoyO0rQtTfdUf50Bq37mjoVfCt8Ujb0MA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=WpW9e86M;
	arc=none smtp.remote-ip=185.246.85.4
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77F1760A2600;
	Fri, 20 Nov 2026 13:40:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 77F1760A2600
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=WpW9e86M
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id CCB6D4E41681;
	Fri, 20 Nov 2026 13:40:50 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 90518601B9;
	Fri, 20 Nov 2026 13:40:50 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D5F8F11BC00C2;
	Fri, 20 Nov 2026 14:40:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1795182049; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=Ew6MOgVIrcp4AtXKSh7rWMjrCWumR7WkQWAedumdhYk=;
	b=WpW9e86Miv1BRiDfJlZacUzkwwuy6wNbM3EAqn9Trc/QzGG3nFUKBVNVTWIkz7+DsWqeSB
	drvj1LG+M8/YcCUOytjqXrnUu37sNk/zDzi2SNovySMdPR5VT6dPm9FXbZhFf7uVlBwCot
	qPEKKYtlZ730aKwrXEBL/XG8mIkfpNN0l0a6DjNI3qDyCn+UQ1xToprSfHtxRdBAO6Ep/L
	8eptwf0PMzWszbeBvF4sV444j5D7tUSeN+X2incjguOBoai5eetk5x4YNYAyjGWqDVn8SQ
	JOlAXMQ24AkWdRRL5CvcrVeTQMz1GinAUJmUK0L0KpLeDDdF2XnCS6SsHM5ieA==
Date: Fri, 20 Nov 2026 14:40:46 +0100
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Stefan Kerkmann <s.kerkmann@pengutronix.de>
Cc: Hugo Villeneuve <hugo@hugovil.com>, linux-rtc@vger.kernel.org,
	linux-kernel@vger.kernel.org, bruno.thomsen@gmail.com,
	giampiero@sferalabs.cc, p.rosenberger@kunbus.com,
	antonio@amsobr.com, Hugo Villeneuve <hvilleneuve@dimonoff.com>
Subject: Re: [PATCH 3/4] rtc: add battery low voltage detection feature
Message-ID: <2026112013404685aba5df@mail.local>
References: <20260311200237.3531981-1-hugo@hugovil.com>
 <20260311200237.3531981-4-hugo@hugovil.com>
 <eeff2fb8-889a-4884-81d8-e4cda7ac5e9e@pengutronix.de>
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eeff2fb8-889a-4884-81d8-e4cda7ac5e9e@pengutronix.de>
X-Last-TLS-Session-Version: TLSv1.3

Hello,

On 06/08/2026 14:55:00+0200, Stefan Kerkmann wrote:
> 
> 
> On 3/11/26 21:02, Hugo Villeneuve wrote:
> > From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > 
> > Some RTCs have a battery low voltage detection function. Add new feature
> > so that it can be enabled, disabled or queried at runtime.
> > 
> > Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > ---
> >   include/uapi/linux/rtc.h | 7 ++++++-
> >   1 file changed, 6 insertions(+), 1 deletion(-)
> > 
> > diff --git a/include/uapi/linux/rtc.h b/include/uapi/linux/rtc.h
> > index 97aca4503a6a3..596eec119bb3a 100644
> > --- a/include/uapi/linux/rtc.h
> > +++ b/include/uapi/linux/rtc.h
> > @@ -134,18 +134,23 @@ struct rtc_param {
> >   #define RTC_FEATURE_CORRECTION		5
> >   #define RTC_FEATURE_BACKUP_SWITCH_MODE	6
> >   #define RTC_FEATURE_ALARM_WAKEUP_ONLY	7
> > -#define RTC_FEATURE_CNT			8
> > +#define RTC_FEATURE_BATTERY_LOW_DETECT	8
> > +#define RTC_FEATURE_CNT			9

This is adding a new ABI and it took me a while to find enough time to
review the datasheet for the RTCs  we support and others. What we need
instead of a boolean is a voltage threshold. So maybe this should be
better named something like RTC_FEATURE_BATTERY_LOW_THRES_MV

> >   /* parameter list */
> >   #define RTC_PARAM_FEATURES		0
> >   #define RTC_PARAM_CORRECTION		1
> >   #define RTC_PARAM_BACKUP_SWITCH_MODE	2
> > +#define RTC_PARAM_BATTERY_LOW_DETECT	3
> >   #define RTC_BSM_DISABLED	0
> >   #define RTC_BSM_DIRECT		1
> >   #define RTC_BSM_LEVEL		2
> >   #define RTC_BSM_STANDBY		3
> > +#define RTC_BATTERY_LOW_DETECT_DISABLED	0
> > +#define RTC_BATTERY_LOW_DETECT_ENABLED	1

And so those wouldn't be needed.

> > +
> >   #define RTC_MAX_FREQ	8192
> 
> I have opened a PR against util-linux to add support and tested the patchset
> with the extended hwclock binary.
> 
> See: https://github.com/util-linux/util-linux/pull/4513
> 
> Reviewed-by: Stefan Kerkmann <s.kerkmann@pengutronix.de>
> Tested-by: Stefan Kerkmann <s.kerkmann@pengutronix.de>
> 
> -- 
> Pengutronix e.K.                       | Stefan Kerkmann             |
> Steuerwalder Str. 21                   | https://www.pengutronix.de/ |
> 31137 Hildesheim, Germany              | Phone: +49-5121-206917-128  |
> Amtsgericht Hildesheim, HRA 2686       | Fax:   +49-5121-206917-9    |
> 

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
