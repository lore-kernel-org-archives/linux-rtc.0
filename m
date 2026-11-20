Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.243.120.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795218047;
	b=xbN38wNY5Pgg3W4MW79aZj3riAWPKgcmhM6zbP1WLIxOTSAuVPstpyBfKqBR7rarT1hW
	 XZCPoP1FvXOMupLd0K+kRiz2ihXR5pvtqpxIkIcBxRoY4ZraGAVvEuMiPEOdYjIq/qvNq
	 VoxaHCuJqKPsdcvRdNxX2Jmti6MZ54Fju11cdbQpkylHWd0nDMYuoSy477jmGJdj/gkh1
	 5G/axI4WUyizFXPupuGfOijOstiGZ5dUOVccpjYO18wTMqfPBICNto/fTgKJtFw7K0T9n
	 LayldmhpCO9hp9gHM8y1FtUTCT7OXLli6OPeyKyw4BkyHCBOb8yBi0rXxhZClsZqLEg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795218047;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-Id:In-Reply-To:References:X-Mailer:Mime-Version:Content-Type:
	 Content-Transfer-Encoding:X-Spam_score:X-Spam_bar;
	bh=m0YuuylmYoN6x1rQ3vm1hbyv77b2Oz4TgMlXuUmituc=;
	b=rQImCBl8CZaiR80lT+EYz32J3LxdXjY4uMW6UsbM7EBsXXRFjyhgHNRIAGeHGdwXuooG
	 Q6foE1+GU0rBg7FS37sI0vSlzl9cMbKPzWM/uvZ3PeUV6j6eKsQTAGV/or8sNmhPhXBm5
	 uEI6C4A/Tj3ubjtK7haxYEthijftlRPoyn9Cxx5tqtV22nwtt0SPzMIrSfSkeZ50FE4A0
	 DJ0CS4Er/XpLeWkOckQ5Bz8+DWn0WV23RJBlSs0NsXwiqt3NorQLHbbEfvy7wfQWjuvUX
	 XVAPO800ZHSQYvGzgB9wFrViZ5tZuN33cRe1/lAO37octrucNO+h8xZAFcSKpomOZvg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hugovil.com;
	spf=pass smtp.mailfrom=hugovil.com;
	dkim=pass header.d=hugovil.com header.i=@hugovil.com header.a=rsa-sha256 header.s=default header.b=v6u99zob;
	arc=none smtp.remote-ip=162.243.120.170
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 874AB606A695;
	Fri, 20 Nov 2026 23:40:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 874AB606A695
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=hugovil.com header.i=@hugovil.com header.a=rsa-sha256 header.s=default header.b=v6u99zob
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=default; h=Content-Transfer-Encoding:Mime-Version:Message-Id:Subject:Cc:
	To:From:Date:subject:date:message-id:reply-to;
	bh=m0YuuylmYoN6x1rQ3vm1hbyv77b2Oz4TgMlXuUmituc=; b=v6u99zobyKdkoK1LNSjDwoLBTU
	OiI4DYuup9QCiLgdqX+v1+ulU3gWSJ0VPKZMisxDA6YlH7PV3yKsPprcVNjdXgUD1gF4xGMLLopEA
	SBS1LsgTgc157sneP8Mim0kForW94GJzNPnJjGx3qlS6VE2X293qCiVF0PoeuyFtYlV0=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168] helo=pettiford.lan)
	by mail.hugovil.com with esmtpa (Exim 4.98.2)
	(envelope-from <hugo@hugovil.com>)
	id 1xUYDU-000000006LR-0bVV;
	Fri, 20 Nov 2026 18:40:28 -0500
Date: Fri, 20 Nov 2026 18:40:27 -0500
From: Hugo Villeneuve <hugo@hugovil.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Stefan Kerkmann <s.kerkmann@pengutronix.de>, linux-rtc@vger.kernel.org,
 linux-kernel@vger.kernel.org, bruno.thomsen@gmail.com,
 giampiero@sferalabs.cc, p.rosenberger@kunbus.com, antonio@amsobr.com, Hugo
 Villeneuve <hvilleneuve@dimonoff.com>
Subject: Re: [PATCH 3/4] rtc: add battery low voltage detection feature
Message-Id: <20261120184027.650463c9b2a1ee1d5528ef36@hugovil.com>
In-Reply-To: <202611201612495c31b58f@mail.local>
References: <20260311200237.3531981-1-hugo@hugovil.com>
	<20260311200237.3531981-4-hugo@hugovil.com>
	<eeff2fb8-889a-4884-81d8-e4cda7ac5e9e@pengutronix.de>
	<2026112013404685aba5df@mail.local>
	<202611201612495c31b58f@mail.local>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam_score: -2.0
X-Spam_bar: --

Hi Alexandre,

On Fri, 20 Nov 2026 17:12:49 +0100
Alexandre Belloni <alexandre.belloni@bootlin.com> wrote:

> On 20/11/2026 14:40:50+0100, Alexandre Belloni wrote:
> > Hello,
> > 
> > On 06/08/2026 14:55:00+0200, Stefan Kerkmann wrote:
> > > 
> > > 
> > > On 3/11/26 21:02, Hugo Villeneuve wrote:
> > > > From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > > > 
> > > > Some RTCs have a battery low voltage detection function. Add new feature
> > > > so that it can be enabled, disabled or queried at runtime.
> > > > 
> > > > Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > > > ---
> > > >   include/uapi/linux/rtc.h | 7 ++++++-
> > > >   1 file changed, 6 insertions(+), 1 deletion(-)
> > > > 
> > > > diff --git a/include/uapi/linux/rtc.h b/include/uapi/linux/rtc.h
> > > > index 97aca4503a6a3..596eec119bb3a 100644
> > > > --- a/include/uapi/linux/rtc.h
> > > > +++ b/include/uapi/linux/rtc.h
> > > > @@ -134,18 +134,23 @@ struct rtc_param {
> > > >   #define RTC_FEATURE_CORRECTION		5
> > > >   #define RTC_FEATURE_BACKUP_SWITCH_MODE	6
> > > >   #define RTC_FEATURE_ALARM_WAKEUP_ONLY	7
> > > > -#define RTC_FEATURE_CNT			8
> > > > +#define RTC_FEATURE_BATTERY_LOW_DETECT	8
> > > > +#define RTC_FEATURE_CNT			9
> > 
> > This is adding a new ABI and it took me a while to find enough time to
> > review the datasheet for the RTCs  we support and others. What we need
> > instead of a boolean is a voltage threshold. So maybe this should be
> > better named something like RTC_FEATURE_BATTERY_LOW_THRES_MV

I am not sure to understand that proposal, because with the
pcf2127/31, you can enable the low battery detection function, but you
cannot select the threshold voltage...


> > 
> > > >   /* parameter list */
> > > >   #define RTC_PARAM_FEATURES		0
> > > >   #define RTC_PARAM_CORRECTION		1
> > > >   #define RTC_PARAM_BACKUP_SWITCH_MODE	2
> > > > +#define RTC_PARAM_BATTERY_LOW_DETECT	3
> > > >   #define RTC_BSM_DISABLED	0
> > > >   #define RTC_BSM_DIRECT		1
> > > >   #define RTC_BSM_LEVEL		2
> > > >   #define RTC_BSM_STANDBY		3
> > > > +#define RTC_BATTERY_LOW_DETECT_DISABLED	0
> > > > +#define RTC_BATTERY_LOW_DETECT_ENABLED	1
> > 
> > And so those wouldn't be needed.
> > 
> 
> To be clear, this is my only comment, with this change, I'll apply the
> series.

Glad to hear that, thank you.

> 
> -- 
> Alexandre Belloni, co-owner and COO, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
> 


-- 
Hugo Villeneuve
