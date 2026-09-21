Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5187502545;
	Mon, 21 Sep 2026 18:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790017203; cv=none; b=iUGKUZBCIT9KrbuYYgWye9rDMHYe35UnslcqC4epm/Lh5UMTnqkWnnQrQrC4MDmJ5A5vbuYYzDqTicJJfkvC3dzbYUWLe7TkJdG7iBqT7j2hZFvf2bHQAcAmmwOGNH4q3poG2isniyU3Kz1Gnc+sxX0aQGt8oIOzqunhYtbVoHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790017203; c=relaxed/simple;
	bh=MgWCn3Tm0JeXYbOhcUsifllaG3HZ1JkU/ix5VaLOqVw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AMB360xq+krZVVMBTPVlRK6rYjQz+UrOqI9tBJ9hfti36ocdXu8S6MrexwK5k+MbQ+PM28plD95eoh2npOngc6nBMKIvIz4QveSCl85lnJT71JxEVI0WU9Px4CJkipUdTJEnJpVCK4b3PfAuzNjsh9m5xgsMEZ+2EVOq2jlZB/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=lVF7ADjW; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="lVF7ADjW"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id DC340C5CD69;
	Mon, 21 Sep 2026 19:00:43 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 9215F5FFB2;
	Mon, 21 Sep 2026 18:59:57 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 61CAB103291F9;
	Mon, 21 Sep 2026 20:59:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1790017192; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=zW66JlASrZdxP04HyoAnrXP/yDSLGw95Tk/l8IOyHL0=;
	b=lVF7ADjW+p22Deio9C6i0a5wp3zzwjI/F0P9jXHDXmM4F3a4N29k6KwQOn3+ZcTTMihC+h
	mvnWXaloW6TlAogciHyPz53YcKy688svOakxZaKly2gxUE2cWq9msZ4tyaGeBKl9h/LRjJ
	k2vyQx7624LnCp911aVduI/ZI9KCtk1ZSdMjZ5kbwbYJUF17yU5NpdgqsPo7scEGfe+zrr
	k2XCYbDXYSb4+trllMyMRiw4TBfTBJlfDS5BuOM131oG5cPOmpt4TuSQB2LYIqfINrxz7b
	cBk2o7UEIVrGRAsB/Umju11B0PVAel5jj4tZrpZJRfyMARY1lhsy/9VK36Vq+w==
Date: Mon, 21 Sep 2026 20:59:49 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Sander Speetjens <sander.speetjens@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Jonathan Bell <jonathan@raspberrypi.com>,
	Stefan Wahren <wahrenst@gmx.net>, linux-rtc@vger.kernel.org,
	devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	Dom Cobley <popcornmix@gmail.com>
Subject: Re: [PATCH v3 2/2] rtc: Add Raspberry Pi 5 RTC driver
Message-ID: <20260921185949d6debd17@mail.local>
References: <20260917135841.841680-1-sander.speetjens@gmail.com>
 <20260917135841.841680-3-sander.speetjens@gmail.com>
 <20260918-outrageous-myrtle-giraffe-80dfdc@quoll>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260918-outrageous-myrtle-giraffe-80dfdc@quoll>
X-Last-TLS-Session-Version: TLSv1.3

On 18/09/2026 13:47:22+0200, Krzysztof Kozlowski wrote:
> On Thu, Sep 17, 2026 at 03:58:41PM +0200, Sander Speetjens wrote:
> > +	return devm_rtc_register_device(vrtc->rtc);
> > +}
> > +
> > +static const struct of_device_id rpi_rtc_dt_match[] = {
> > +	{ .compatible = "raspberrypi,firmware-rtc"},
> 
> Please fixup white space issues, see existing drivers (missing space
> before }
> 
> > +	{},
> 
> and unnecessary ,.
> 
> Just take existing latest code as starting point, otherwise you
> reintroduce discouraged patterns.
> 
> More important: undocumented ABI.
> 

This was my comment on the previous revision, I'm not sure why it was
ignored.


-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
