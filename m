Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.84.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795264601;
	b=k1p206+0dVaB7lfRNj/iM0/Aa8oNDSyesJJ0ztmqc6xhpybp70sL4iDsH5mB0HkRv2uA
	 EJG0gxqG0s2Do2fX0iXmTCNA9kNZFd6clJXY49Uj5MyV0Qv0jsU2XtanKZEB1T5mXfHn5
	 tVOPR0TeILcK1kxHsQBh7bjCp6h2qAXW1UEoXD5KFTWQ5Q448XtoAS3SaCDhwClizyx5Y
	 7dcvTs48AnncyHpp/YaO+1rl50ya9YPM0z+Ho85wWeMLkpWBORrQ/p+ZX1r3uK2V26rLi
	 iiOszt3TYaioWinIB/oWfSVOX8liwzGEWQzO21XQmUI89bhafJXJ1LPx2EH2wiFdgsw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795264601;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Last-TLS-Session-Version;
	bh=rcuwWYuIShywrwdReRTzxtDAqrJLFL0BZUk9awwAu6M=;
	b=Fj+RpTZy7DgbXFxkRwAfgbUZwY/MPLcnxsn3ciHY0SBppJFuF2QiFjYvl610v/NRaQ0r
	 o9cdWDjjXtHEjmtq/u/2epKnYQLn2ecSuHn9xSAR1Zp0fttIG3rm0xjwR6p1ZFG+PXOIu
	 07MDBoO7qoxMCvhxn0H1dAUPStUZAQSPi3dsv2rcMwt+bPNeBY+RiYjPlNf8Jz5CxX7+l
	 /oymPTblC8mvv2PHQqYVz9zhGISXYJqyFU0o7nyf3sBVp7Oip+rC3QfvLwgbfNK/FaDpk
	 BMuiwAvtXY6feU+3+N+w6ZOfenFTcqpOrkrPic9DNqkW1peNs3aS5I4mX5xX6WVD26w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=unpTNbXC;
	arc=none smtp.remote-ip=185.246.84.56
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4470F606A32A
	for <linux-rtc@vger.kernel.org>; Sat, 21 Nov 2026 12:36:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4470F606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=unpTNbXC
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 75AF31A176B;
	Sat, 21 Nov 2026 12:36:37 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 33867603CF;
	Sat, 21 Nov 2026 12:36:37 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 423FA11BC05AB;
	Sat, 21 Nov 2026 13:36:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1795264596; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=rcuwWYuIShywrwdReRTzxtDAqrJLFL0BZUk9awwAu6M=;
	b=unpTNbXCOfhekgHiuaF3vBNRjU4KLHjsAo3Osz74DwgWnxjU+ceGqGpMw7nddWL5m9b+Vb
	PgCyvrgoZcFCLjafG0+7lRnYQejB9GFOSeHNNp/v/VjQAN/JaaT3jtSIBqWuoKEp9OGNff
	Npa3FUcJLZjhETqcOgTLRqXRbsnQQn3krTC+ROEBrl2DLGhtQ+3/RFlx3Mnm4EFw4nCduB
	XEe2QO91oemSn/hokoAMdN0iTjdIDQlgGf3Ui+fTNOT+yZaWhpZqMuOlxc081fad/wQF09
	tbZg2DR0F/rh57B8Uzp9QMwjdtvCj40Tcp1Cw9BpCpOFmu7FIQ5idfWtDXAD9A==
Date: Sat, 21 Nov 2026 13:36:32 +0100
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Hugo Villeneuve <hugo@hugovil.com>
Cc: Stefan Kerkmann <s.kerkmann@pengutronix.de>, linux-rtc@vger.kernel.org,
	linux-kernel@vger.kernel.org, bruno.thomsen@gmail.com,
	giampiero@sferalabs.cc, p.rosenberger@kunbus.com,
	antonio@amsobr.com, Hugo Villeneuve <hvilleneuve@dimonoff.com>
Subject: Re: [PATCH 3/4] rtc: add battery low voltage detection feature
Message-ID: <20261121123632576d91fd@mail.local>
References: <20260311200237.3531981-1-hugo@hugovil.com>
 <20260311200237.3531981-4-hugo@hugovil.com>
 <eeff2fb8-889a-4884-81d8-e4cda7ac5e9e@pengutronix.de>
 <2026112013404685aba5df@mail.local>
 <202611201612495c31b58f@mail.local>
 <20261120184027.650463c9b2a1ee1d5528ef36@hugovil.com>
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
In-Reply-To: <20261120184027.650463c9b2a1ee1d5528ef36@hugovil.com>
X-Last-TLS-Session-Version: TLSv1.3

On 20/11/2026 18:40:27-0500, Hugo Villeneuve wrote:
> Hi Alexandre,
> 
> On Fri, 20 Nov 2026 17:12:49 +0100
> Alexandre Belloni <alexandre.belloni@bootlin.com> wrote:
> 
> > On 20/11/2026 14:40:50+0100, Alexandre Belloni wrote:
> > > Hello,
> > > 
> > > On 06/08/2026 14:55:00+0200, Stefan Kerkmann wrote:
> > > > 
> > > > 
> > > > On 3/11/26 21:02, Hugo Villeneuve wrote:
> > > > > From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > > > > 
> > > > > Some RTCs have a battery low voltage detection function. Add new feature
> > > > > so that it can be enabled, disabled or queried at runtime.
> > > > > 
> > > > > Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > > > > ---
> > > > >   include/uapi/linux/rtc.h | 7 ++++++-
> > > > >   1 file changed, 6 insertions(+), 1 deletion(-)
> > > > > 
> > > > > diff --git a/include/uapi/linux/rtc.h b/include/uapi/linux/rtc.h
> > > > > index 97aca4503a6a3..596eec119bb3a 100644
> > > > > --- a/include/uapi/linux/rtc.h
> > > > > +++ b/include/uapi/linux/rtc.h
> > > > > @@ -134,18 +134,23 @@ struct rtc_param {
> > > > >   #define RTC_FEATURE_CORRECTION		5
> > > > >   #define RTC_FEATURE_BACKUP_SWITCH_MODE	6
> > > > >   #define RTC_FEATURE_ALARM_WAKEUP_ONLY	7
> > > > > -#define RTC_FEATURE_CNT			8
> > > > > +#define RTC_FEATURE_BATTERY_LOW_DETECT	8
> > > > > +#define RTC_FEATURE_CNT			9
> > > 
> > > This is adding a new ABI and it took me a while to find enough time to
> > > review the datasheet for the RTCs  we support and others. What we need
> > > instead of a boolean is a voltage threshold. So maybe this should be
> > > better named something like RTC_FEATURE_BATTERY_LOW_THRES_MV
> 
> I am not sure to understand that proposal, because with the
> pcf2127/31, you can enable the low battery detection function, but you
> cannot select the threshold voltage...

This is exactly my point, there are RTCs where you can select the
threshold voltage so we have to design for them. We can have 0mv mean
disabled because we are never going to have a 0 or negative threshold.


-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
