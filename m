Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.171.202.116
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795191175;
	b=CW0oFvrjQcgILoa1oxe5gyvRP/6wtoVH6gMfktC57HDe9D2UCA86xSGKlH9bpld4OeL3
	 I/AbqX+HeYUXhYpaJ5NwJUN6vo2XY8OMvmGIYQCmErbT1M0OGEXosKCiFc5KBiCGagvED
	 UKMeecvokVOmWPG/Z/6nNERFockkFY+XydhaNHEX1Leuvd9P/DqrRuK+q214DUTF69SvX
	 LmLnZDvAw/C9gzd+/oUFN1PjY/KYJSCM3gGc9hXR0ZR0dNcm9C+5asHQNYlmgGLutFDyj
	 tyKvUDzxYhn7//v+EwLMhH7vVrDGjt5FDtaK3vpp1BgWtbHXeIrOAkR0Fz+/vPBLRQQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795191175;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Last-TLS-Session-Version;
	bh=eDcAGDYjFQhLHdZ0WLS4OAsmbJKl+tDWH1qGOeZYbTc=;
	b=YwJa519e6sX3k499TIpMs5U/JixB9MyiHnhO+BSzieSoCMyeglzLS39s6AE4hdptrpin
	 ScmiyTYviiv35z2fIHthEeb0zwKr3IPZu1qkUDdyopBe/Tzz+VYtvrSKWtA9Vx5CRBDBu
	 626TRhHw6HgEOge6pDA4kdRIU49Yfrgw4hWLQ0zDV9JU2rlKK29aj8oCeogGVVqyRN/tg
	 e6QiYGO7gPLK17QwF9W6sV1KjAuSqvtBEgArJHV4YCorvZakNIEHTfnnIpjjkoWkH+HH/
	 vgd1b5rewxeYV5LowQN+EZQlVO6Iz/wYSdk5QSNlc29NddzUSRBK2fSSoZOS3F/ddzw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=nfleTugH;
	arc=none smtp.remote-ip=185.171.202.116
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5874E60A2602;
	Fri, 20 Nov 2026 16:12:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5874E60A2602
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=nfleTugH
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 5B49EC62220;
	Fri, 20 Nov 2026 16:12:59 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 915E7601B9;
	Fri, 20 Nov 2026 16:12:53 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5E82911BC0422;
	Fri, 20 Nov 2026 17:12:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1795191172; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=eDcAGDYjFQhLHdZ0WLS4OAsmbJKl+tDWH1qGOeZYbTc=;
	b=nfleTugHS4O9zlCRIKvYtKiV6KEFxd6o/SeSj+1lAwior9x95l2shU5Oz51OI2aUHe8UnZ
	nN+0Sj9pyVDBLoNLD2Cr+Q4tZRFZHHtGIk8nCVFUZt0QJytPJUpF4/IP4LVjVz9Tn/MKY7
	qca9Qkhk6jMGMAFrvRbLmTxJXlndKffzt+4co5+pTvSypRDtL321jZP2Hzs7pF0OEVjFQc
	nxerZPNWuhhK3BgPSTZKhn2/4g68QQdCN2cIgdoeyYOHwvVK2z2qaQ/tfradEEWTgVe9Jd
	YYAddNRAUMP+A16+orFLt5P4vPGF8nBT+fTtkgStJ2LsHeDHF9Qbm5qQr7f65w==
Date: Fri, 20 Nov 2026 17:12:49 +0100
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Stefan Kerkmann <s.kerkmann@pengutronix.de>
Cc: Hugo Villeneuve <hugo@hugovil.com>, linux-rtc@vger.kernel.org,
	linux-kernel@vger.kernel.org, bruno.thomsen@gmail.com,
	giampiero@sferalabs.cc, p.rosenberger@kunbus.com,
	antonio@amsobr.com, Hugo Villeneuve <hvilleneuve@dimonoff.com>
Subject: Re: [PATCH 3/4] rtc: add battery low voltage detection feature
Message-ID: <202611201612495c31b58f@mail.local>
References: <20260311200237.3531981-1-hugo@hugovil.com>
 <20260311200237.3531981-4-hugo@hugovil.com>
 <eeff2fb8-889a-4884-81d8-e4cda7ac5e9e@pengutronix.de>
 <2026112013404685aba5df@mail.local>
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
In-Reply-To: <2026112013404685aba5df@mail.local>
X-Last-TLS-Session-Version: TLSv1.3

On 20/11/2026 14:40:50+0100, Alexandre Belloni wrote:
> Hello,
> 
> On 06/08/2026 14:55:00+0200, Stefan Kerkmann wrote:
> > 
> > 
> > On 3/11/26 21:02, Hugo Villeneuve wrote:
> > > From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > > 
> > > Some RTCs have a battery low voltage detection function. Add new feature
> > > so that it can be enabled, disabled or queried at runtime.
> > > 
> > > Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > > ---
> > >   include/uapi/linux/rtc.h | 7 ++++++-
> > >   1 file changed, 6 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/include/uapi/linux/rtc.h b/include/uapi/linux/rtc.h
> > > index 97aca4503a6a3..596eec119bb3a 100644
> > > --- a/include/uapi/linux/rtc.h
> > > +++ b/include/uapi/linux/rtc.h
> > > @@ -134,18 +134,23 @@ struct rtc_param {
> > >   #define RTC_FEATURE_CORRECTION		5
> > >   #define RTC_FEATURE_BACKUP_SWITCH_MODE	6
> > >   #define RTC_FEATURE_ALARM_WAKEUP_ONLY	7
> > > -#define RTC_FEATURE_CNT			8
> > > +#define RTC_FEATURE_BATTERY_LOW_DETECT	8
> > > +#define RTC_FEATURE_CNT			9
> 
> This is adding a new ABI and it took me a while to find enough time to
> review the datasheet for the RTCs  we support and others. What we need
> instead of a boolean is a voltage threshold. So maybe this should be
> better named something like RTC_FEATURE_BATTERY_LOW_THRES_MV
> 
> > >   /* parameter list */
> > >   #define RTC_PARAM_FEATURES		0
> > >   #define RTC_PARAM_CORRECTION		1
> > >   #define RTC_PARAM_BACKUP_SWITCH_MODE	2
> > > +#define RTC_PARAM_BATTERY_LOW_DETECT	3
> > >   #define RTC_BSM_DISABLED	0
> > >   #define RTC_BSM_DIRECT		1
> > >   #define RTC_BSM_LEVEL		2
> > >   #define RTC_BSM_STANDBY		3
> > > +#define RTC_BATTERY_LOW_DETECT_DISABLED	0
> > > +#define RTC_BATTERY_LOW_DETECT_ENABLED	1
> 
> And so those wouldn't be needed.
> 

To be clear, this is my only comment, with this change, I'll apply the
series.

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
