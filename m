Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F05303F7E88;
	Thu, 12 Mar 2026 17:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773337909; cv=none; b=aRAxRoo4sVBv1B+6i+J/fJPokP/xhJUcnGYBqjnJgy3r8ftB0oB2aZo2gu7Vpf6F9jekorJ6HhDZQjfOQk1BHUrt5522R1f7xfkunHKQ/hKNNXsMLvKJJIScuEfvyDGsliK9Mxl+sdJvsc0erkpFyKhD0kKnybG0kYMvVmscAUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773337909; c=relaxed/simple;
	bh=Tildp7S7qCH5LxAjbMiLA33KOVWz6OAySSjo4u37Nbo=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=sOx5vq7N3lrrKIM1jPrWpgo/MH+hXwUc3wDzDcFf/Zhyhxq0++7Ycyh9WyjNabTUsbKoD3z8ajN0b+oAq0FbLoh7G2o/nIXPGuYHEfoGwPDWlsIRJ0H2enE67Z8K89UC0qcZdhfp8ZV6z3rDWq1+ed0sNjCnjzrnOe+Ezr/nfpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=fail (0-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=GFFiQ9H3 reason="key not found in DNS"; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="GFFiQ9H3"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=default; h=Content-Transfer-Encoding:Mime-Version:Message-Id:Subject:Cc:
	To:From:Date:subject:date:message-id:reply-to;
	bh=Uw1LvZ1PeS55qXnIKkOseA45oklJs+Y7ZpJs08kVHYU=; b=GFFiQ9H352zBlxSEcG4ASkYxTb
	uaT5XktE8OS6oRiko6k6m4tu3rMG35I0kZOoKMXouWDgiiDfwdPhAS/g0/oSs2fHAxyqz8ZkaS1BX
	KqT4baBHlc2oms3FWE+yCTK0kKTNmK4cOIB0ytkMW9X5y+SZ0usKtkJoDqguaf2l1asY=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168] helo=pettiford.lan)
	by mail.hugovil.com with esmtpa (Exim 4.98.2)
	(envelope-from <hugo@hugovil.com>)
	id 1w0kCH-000000008AR-3cQ5;
	Thu, 12 Mar 2026 13:51:46 -0400
Date: Thu, 12 Mar 2026 13:51:45 -0400
From: Hugo Villeneuve <hugo@hugovil.com>
To: Hugo Villeneuve <hugo@hugovil.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>, Hugo Villeneuve
 <hvilleneuve@dimonoff.com>, linux-rtc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rtc: add BSM flags descriptions
Message-Id: <20260312135145.d37cfddb9317018de436bbd0@hugovil.com>
In-Reply-To: <20260113100427.f2162f0d5ba80a259511f9d2@hugovil.com>
References: <20250721153332.2177134-1-hugo@hugovil.com>
	<20260113100427.f2162f0d5ba80a259511f9d2@hugovil.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam_score: -2.0
X-Spam_bar: --

On Tue, 13 Jan 2026 10:04:27 -0500
Hugo Villeneuve <hugo@hugovil.com> wrote:

> On Mon, 21 Jul 2025 11:33:31 -0400
> Hugo Villeneuve <hugo@hugovil.com> wrote:
> 
> > From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > 
> > It is hard to decipher what the RTC BSM flags mean, so add
> > meaningful descriptions.
> > 
> > Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > ---
> >  include/uapi/linux/rtc.h | 11 ++++++++---
> >  1 file changed, 8 insertions(+), 3 deletions(-)
> > 
> > diff --git a/include/uapi/linux/rtc.h b/include/uapi/linux/rtc.h
> > index 97aca4503a6a..da65130e316d 100644
> > --- a/include/uapi/linux/rtc.h
> > +++ b/include/uapi/linux/rtc.h
> > @@ -141,10 +141,15 @@ struct rtc_param {
> >  #define RTC_PARAM_CORRECTION		1
> >  #define RTC_PARAM_BACKUP_SWITCH_MODE	2
> >  
> > +/* Backup switch mode */
> >  #define RTC_BSM_DISABLED	0
> > -#define RTC_BSM_DIRECT		1
> > -#define RTC_BSM_LEVEL		2
> > -#define RTC_BSM_STANDBY		3
> > +#define RTC_BSM_DIRECT		1 /* Switch if Vbackup > Vdd */
> > +#define RTC_BSM_LEVEL		2 /* Switch based on a threshold, usually with an hysteresis */
> > +#define RTC_BSM_STANDBY		3 /*
> > +				   * Switch if Vdd > Vbackup.
> > +				   * Useful to ensure the RTC doesn't draw any
> > +				   * power until the device is first powered on.
> > +				   */
> >  
> >  #define RTC_MAX_FREQ	8192
> 
> Ping?

Ping, Ping?


-- 
Hugo Villeneuve
