Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.85.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792440655;
	b=kPMswGsN55iTR9QR+GrJoHwxBtItnekGNpEkNvx7T6QP9avjB2307JZWnBW4O8RcqyCp
	 yVv58zYcEJgqHQNig3rZJSMFCt5TeqOslNxZTJP+svGKY8Tc2Ipg3Vn+73mirx9Q8W9pr
	 7hmhkAcayBG1v8uPx6DjWt6DNbk+V5zb3GTLLu4dSvdu0fYNaweih6KAlmbjpSHhoiq0P
	 JX82olg2J6SWE4jwEiXWcz6ER9bYcxYlEscVxPr/gHaZ6sNGo/6AeBm6uK4WecFbiOzwE
	 dbNlP3wmiUSpAOdTvlBiiN5vVe3Ploo8ODFwRCf3NwPPPyXb2tuT/hFsxHhGJRjASIA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792440655;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Last-TLS-Session-Version;
	bh=fDn/k7hpvMCdeXjRyAYzAoy0wAxqkiDt4fpprxKuVcc=;
	b=J2qV6uxblepLRnOlqAGoX5qlSi20w/gxE+gfbtcVGSim8u9PT9t7YWg14SxXwQRznR5+
	 Nl6kUH4qv7TG3NnZgH2u8ovhyE3uwuM497Il6uniUU47NPzLD4Dqt5HId1w1GBkVlvxat
	 vhU6VaNmHuyoXmAFSNOp4A5Z6GoCRgrkPY5iyKN4MJRKq4kHjm1gayOYkbReTvbPVk6kY
	 OrUYDy0u0hANknyYkZSAKFriDzdIKjqqLYTXTKy+kUlJCzZLyr8sASdzFxKOZGqnBUchb
	 /s3KYaFzqJTItvsMOefvbnBfWAg1z0GDO1A9IgUUFYrWzHvHa223iHFyQs3uoTZwDnQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b="k/n2b7BW";
	arc=none smtp.remote-ip=185.246.85.4
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D873606A31B
	for <linux-rtc@vger.kernel.org>; Mon, 19 Oct 2026 20:10:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4D873606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=k/n2b7BW
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 5E9184E4127B
	for <linux-rtc@vger.kernel.org>; Mon, 19 Oct 2026 20:10:52 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 23A3860582;
	Mon, 19 Oct 2026 20:10:52 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 51DDD10328C22;
	Mon, 19 Oct 2026 22:10:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1792440651; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=fDn/k7hpvMCdeXjRyAYzAoy0wAxqkiDt4fpprxKuVcc=;
	b=k/n2b7BWnoC2ybI0vGNW/AqPLKHjVCtNSnGkB4M8Wi4tkLjrY22NH37BxtA5Va4gfEGHbm
	FmlEXnAapypfZiOMEktiHjiKwteEihj07lJ5LAtPu83PRpqIVE32gTL/QT0K9ZFKrcxzfX
	Kw+9sA27+vvwMhGi3Tzjxw2dVaOg7Jhkeq6GneCg0nlpWiJSWessTCTy+StgiWbJRvQ3wk
	9Tv66nhBpktneNwQcOPLcVP0c2Xgefdb/3jGq+5lOkWububAJpcthy+6hCHtuBhzm5EOx3
	iqBgZPQ/cuLQaZ9txp9LcnyrPPrxEKasZMfhFreh4M46ige8Ljfs3jt5Bu6SdA==
Date: Mon, 19 Oct 2026 22:10:49 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Igor Velkov <iav@iav.lv>
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, linux-rtc@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] rtc: pcf8563: pass the driver data to the alarm
 interrupt handler
Message-ID: <179244056631.104236.1622190236820625826.b4-ty@b4>
References: <20261004-pcf8563-irq-data-v1-1-f176763ddf2f@iav.lv>
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
In-Reply-To: <20261004-pcf8563-irq-data-v1-1-f176763ddf2f@iav.lv>
X-Last-TLS-Session-Version: TLSv1.3

On Sun, 04 Oct 2026 23:56:53 +0000, Igor Velkov wrote:
> pcf8563_irq() takes its dev_id as struct pcf8563, but probe still
> registers the interrupt with the i2c client. The handler then takes the
> regmap pointer from the wrong structure: the first alarm oopses, the
> level-low INT is never acknowledged, and the interrupt gets disabled as
> spurious.
> 
> Only an RTC that has an interrupt (client->irq > 0) reaches this path.
> 
> [...]

Applied, thanks!

[1/1] rtc: pcf8563: pass the driver data to the alarm interrupt handler
      https://git.kernel.org/abelloni/c/5831f5fef100

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
