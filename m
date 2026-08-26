Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50F3531E857;
	Wed, 26 Aug 2026 06:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787727465; cv=none; b=NUUMHXkC/gRgr2bp3cAtiFPgR4xOS+XfqXFzVy/BbFI2g20UMwcPzbIBqCRgyk+TtKumgBGB5IxyZsAg74e++L18uCPYwYltIJAIM2ClHpplrB2XLntmtQm2nC/6JqzdneO16bQlEIKa3LgTzvda/Jg41fXLzw/ffNv2ntwsQoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787727465; c=relaxed/simple;
	bh=10YQsE319fWD+kPVnACaWP3iv8GP+tJneaCptJzvKk0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hNdnysczNS899e2XT8zAwrYUXVMg5ceaDCFtkE+uKVWNsUxSqptrwE1BSAgVEyQI5BooX9PvNtD6PQA6v1+TJn3sohR85ViENzH1+hm1b1RY4hup33wZggqMT19n4CpVWv9wALh91KSiwueqLa/2klQozDc5DeLgIYUwWe1xADc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=kCXn9AoC; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="kCXn9AoC"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 94C0D1A1838;
	Wed, 26 Aug 2026 06:57:40 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 6256D604EC;
	Wed, 26 Aug 2026 06:57:40 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A731711C79F5F;
	Wed, 26 Aug 2026 08:57:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1787727456; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=izTG9C0uNDXkzQQV3WtCXDfk3h+dFQ+wL+/QiCG9XKY=;
	b=kCXn9AoC+7PDREYwiY5NLtR6KM2hRKCYASiHPW0LMhgSunUGXQfJUUF2W3vqoNVFdkbRQ3
	LiinmXn4PwdfJINNSfpDlk5ebCzKWGGBpp1pBGffgy/n7L0OlbcaRCSSpqLYAysJpbx2yl
	Zs74oCb644O1S92XG3EWoBfOX4Ujk+bq2HT6LeYM77aEwmPXq0L89ewezG13kbMSY0r0DS
	Vg4WfjWnS7cGiK5L801Zz/VcA/hLuKmHKakINXiVD6NBbYG24sgwygvya4y5hcvfPwhciL
	vt/CyBGT5e5tM3BP0yG4aJUD7ArTeHNtrWTbR+N6/xkIBmo6vZP8fSISU1hJZw==
Date: Wed, 26 Aug 2026 08:57:35 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Dhaval Shiroya <dhaval.shiroya@siliconsignals.io>
Cc: "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] rtc: rv3028: configure backup switch mode from device
 tree
Message-ID: <20260826065735b7e92466@mail.local>
References: <20260822092911.318342-1-dhaval.shiroya@siliconsignals.io>
 <2026082213092838377a26@mail.local>
 <PN2P287MB289211E7C870D80EC2F7603F8DAE2@PN2P287MB2892.INDP287.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PN2P287MB289211E7C870D80EC2F7603F8DAE2@PN2P287MB2892.INDP287.PROD.OUTLOOK.COM>
X-Last-TLS-Session-Version: TLSv1.3

On 26/08/2026 06:37:48+0000, Dhaval Shiroya wrote:
> Hi Alexandre,
> 
> >On 22/08/2026 14:59:11+0530, Dhaval Shiroya wrote:
> >> Enable and set the backup switch mode directly from the device tree at
> >> probe, instead of requiring a userspace RTC_PARAM_BACKUP_SWITCH_MODE
> >> ioctl on every unit.
> >> 
> >
> >No, just use the ioctl.
> 
> Thanks for the reply.
> 
> Instead, can we enable the FEDE bit, as the datasheet recommends enabling it when switching to RTC Backup Switchover Mode?
> 
> Could you please share your thoughts on this?

It is never disabled and so it is always enabled unless someone disabled
it on purpose.


-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
