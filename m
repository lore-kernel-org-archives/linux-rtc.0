Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.243.120.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795447661;
	b=l8FhFvbGH5uZqdaw3nHT3yEhod1QGp/DMLwxAqM3/uiQ4VRcgLtE4UAegERTbg/FWYDH
	 L7+aCs+ZznZZVz4Nvf/CgLsDDTGB1onBn9fQfmPxbaq2Kgh3///+5j23hKL9Y6Pa/uaSc
	 ZoChpM1Cx52DC+zIFk6u9KPVG3ARvTMut5Vc+eLtNdvfboopeuokJIWXJV2sPytnV4GMr
	 xcyyv4JhBnDJit7ByrkA+vu0O1NVz4dTv83lX+dnU3OKANZSC1rOIFVg8kHGvct6vcxb7
	 wVDnF4PcAJothP+Etyu38GHIcfWqWMaIq3ax4KoiUIjzdG9DPZAt0Ai0QhzChrx3URQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795447661;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-Id:In-Reply-To:References:X-Mailer:Mime-Version:Content-Type:
	 Content-Transfer-Encoding:X-Spam_score:X-Spam_bar;
	bh=wxsDx62TnzRXUdbgzy7FdIxDq2O5Hyr3+67xg1qIVVQ=;
	b=uO50IHVKNWc1Q1ppO8oSdsxUJ77W5mQqh2IMVf2kskzPbeQuXjpnqya8d/4jv5DKvUoj
	 F/eQ8gCEiG3n6Mxmdj+adYM7n9fiB7nxXvO7LCS9GOE4zHixvnYuIdV32GNA9mvwd5q2x
	 jxJ4uo0qYF7VuM15HrGxSNRk2Sv3M6q22T0pHNLIs+4MocqbIuSl2GILZEj0U2U5DTMSw
	 vPQtatLt+pORR+dgaHc6sYm0h4p6g9oW6kHGN4heDLPHEGJYlG5JNwEUT/iX/S4Ksibli
	 NaO1Bt4m/1yjZGDRZofG0jiQ59CrsvSM4BVB4ELUrxadSw+oGyXfZdg+8MA6SESpFQg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hugovil.com;
	spf=pass smtp.mailfrom=hugovil.com;
	dkim=pass header.d=hugovil.com header.i=@hugovil.com header.a=rsa-sha256 header.s=default header.b=IdDYRSdd;
	arc=none smtp.remote-ip=162.243.120.170
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28F02606A327;
	Mon, 23 Nov 2026 15:27:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 28F02606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=hugovil.com header.i=@hugovil.com header.a=rsa-sha256 header.s=default header.b=IdDYRSdd
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=default; h=Content-Transfer-Encoding:Mime-Version:Message-Id:Subject:Cc:
	To:From:Date:subject:date:message-id:reply-to;
	bh=wxsDx62TnzRXUdbgzy7FdIxDq2O5Hyr3+67xg1qIVVQ=; b=IdDYRSdd65PYiv0GUNkY9gRA+h
	m1AsFJm6s86j5ULuiMaDUlbRAmMmeIbtLv6Qm/2Szhl4dyKYmLttUkpMChoIjKb5mRp557A90IdID
	umG9EorYiSWjSpsO8k9RO5RDslON5sWPGfeHdu51AwWDjUYeJhlO3sDP7LA0o0q5QC6M=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168] helo=pettiford.lan)
	by mail.hugovil.com with esmtpa (Exim 4.98.2)
	(envelope-from <hugo@hugovil.com>)
	id 1xVVx6-000000000h9-1xbV;
	Mon, 23 Nov 2026 10:27:32 -0500
Date: Mon, 23 Nov 2026 10:27:32 -0500
From: Hugo Villeneuve <hugo@hugovil.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Stefan Kerkmann <s.kerkmann@pengutronix.de>, linux-rtc@vger.kernel.org,
 linux-kernel@vger.kernel.org, bruno.thomsen@gmail.com,
 giampiero@sferalabs.cc, p.rosenberger@kunbus.com, antonio@amsobr.com, Hugo
 Villeneuve <hvilleneuve@dimonoff.com>
Subject: Re: [PATCH 3/4] rtc: add battery low voltage detection feature
Message-Id: <20261123102732.6ca739becd4992892b2d1e23@hugovil.com>
In-Reply-To: <20261121123632576d91fd@mail.local>
References: <20260311200237.3531981-1-hugo@hugovil.com>
	<20260311200237.3531981-4-hugo@hugovil.com>
	<eeff2fb8-889a-4884-81d8-e4cda7ac5e9e@pengutronix.de>
	<2026112013404685aba5df@mail.local>
	<202611201612495c31b58f@mail.local>
	<20261120184027.650463c9b2a1ee1d5528ef36@hugovil.com>
	<20261121123632576d91fd@mail.local>
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

On Sat, 21 Nov 2026 13:36:32 +0100
Alexandre Belloni <alexandre.belloni@bootlin.com> wrote:

> On 20/11/2026 18:40:27-0500, Hugo Villeneuve wrote:
> > Hi Alexandre,
> > 
> > On Fri, 20 Nov 2026 17:12:49 +0100
> > Alexandre Belloni <alexandre.belloni@bootlin.com> wrote:
> > 
> > > On 20/11/2026 14:40:50+0100, Alexandre Belloni wrote:
> > > > Hello,
> > > > 
> > > > On 06/08/2026 14:55:00+0200, Stefan Kerkmann wrote:
> > > > > 
> > > > > 
> > > > > On 3/11/26 21:02, Hugo Villeneuve wrote:
> > > > > > From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > > > > > 
> > > > > > Some RTCs have a battery low voltage detection function. Add new feature
> > > > > > so that it can be enabled, disabled or queried at runtime.
> > > > > > 
> > > > > > Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > > > > > ---
> > > > > >   include/uapi/linux/rtc.h | 7 ++++++-
> > > > > >   1 file changed, 6 insertions(+), 1 deletion(-)
> > > > > > 
> > > > > > diff --git a/include/uapi/linux/rtc.h b/include/uapi/linux/rtc.h
> > > > > > index 97aca4503a6a3..596eec119bb3a 100644
> > > > > > --- a/include/uapi/linux/rtc.h
> > > > > > +++ b/include/uapi/linux/rtc.h
> > > > > > @@ -134,18 +134,23 @@ struct rtc_param {
> > > > > >   #define RTC_FEATURE_CORRECTION		5
> > > > > >   #define RTC_FEATURE_BACKUP_SWITCH_MODE	6
> > > > > >   #define RTC_FEATURE_ALARM_WAKEUP_ONLY	7
> > > > > > -#define RTC_FEATURE_CNT			8
> > > > > > +#define RTC_FEATURE_BATTERY_LOW_DETECT	8
> > > > > > +#define RTC_FEATURE_CNT			9
> > > > 
> > > > This is adding a new ABI and it took me a while to find enough time to
> > > > review the datasheet for the RTCs  we support and others. What we need
> > > > instead of a boolean is a voltage threshold. So maybe this should be
> > > > better named something like RTC_FEATURE_BATTERY_LOW_THRES_MV
> > 
> > I am not sure to understand that proposal, because with the
> > pcf2127/31, you can enable the low battery detection function, but you
> > cannot select the threshold voltage...
> 
> This is exactly my point, there are RTCs where you can select the
> threshold voltage so we have to design for them. We can have 0mv mean
> disabled because we are never going to have a 0 or negative threshold.

For me, it is confusing and weird to have a threshold voltage
parameter that you can set on ICs that a have a fixed threshold voltage.

Also, once you set a threshold voltage for an IC that have that
capability, setting it to 0 to disable it seems more complicated than
simply setting the parameter to enable or disable. This also means that
if some application/service at startup were to set a threshold voltage,
then disabling it later by setting it to 0mv would lose the threshold
voltage previously set.

So, why not simply add a new parameter like you suggested to set the
threshold voltage on ICs that support it,
RTC_FEATURE_BATTERY_LOW_THRES_MV? Then you can reuse the enable/disable
boolean to enable/disable the function and keep the threshold voltage
unaffected/unmodified.

Hugo.
