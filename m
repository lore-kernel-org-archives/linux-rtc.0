Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 648D647D44F
	for <linux-rtc@vger.kernel.org>; Thu,  1 Oct 2026 07:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790839796; cv=none; b=hQFUKc1IEfkQECkPEvPNqUm8vqZNKfGoVgdX/DrMnGvx66cmNZvr1S/bhKDaera8jsC527/Kpm8uhjBNSCjZGpCpexJYLdxXUxdeeSDoW6jqI1CNOuQDivn29Vv6GW5gorx8U+R2mql99MFv0ZOMg2njduV2BmTTiUrjRHcELV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790839796; c=relaxed/simple;
	bh=lpXg5QtAI4gtqTYddyv2V+COTh6mSwYtWhaPIdw0ZNU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qEGn9bDPBvjKA1phMQg2h4uuCksIaDvvGb1jNSIvGRBeWbqdr1iAy4aElQ+47eYDhao5BFyo7xHYS2s+fhWySL9RecPAsDit0bAzj5xwyA03kcRsUJpvgbHVuOawS1Qv11TTEDIgyMvTM3kfWqMlCp6xJCGa9pcGIJjS0tfSQGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=qTK6rbvN; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="qTK6rbvN"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id C8E541A109C;
	Thu,  1 Oct 2026 07:29:50 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 9BFE660341;
	Thu,  1 Oct 2026 07:29:50 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 264CD1032946E;
	Thu,  1 Oct 2026 09:29:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1790839790; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=+6SFI7PvjPIbCS2CVlqilXNKDCO3yQ0/tGuHkrFJY6c=;
	b=qTK6rbvNn5u2KxR8FpnWF8LHdcAfDc6q1kJH5iOPnRVDXirjOamnnGL+W96SW9xdF6FsxC
	S3lUFQaRfGyoc+fZ9knyLSyeBavyVAyrckBlz+riIPrFUw+xeFNo253kjKz5RZDS0FktDQ
	wGXZTyzt6K3l50u1BVjyanvi1D0nhprxH41yotf8k88FfckGMKn3jk+LR9VNwAPkSQRKE+
	aGpQvtA0PD7KCv+nhdH3p9DzYjN6k5Pr87mIYBouEgRiXcbmnE3SeYTGVm78RojcgD6vVF
	ccGIAzNppP+AxEKqj6TholmLkFYIJYGEJcHZmMhamEeL/n4k/Ez5QfvxmuQKDg==
Date: Thu, 1 Oct 2026 09:29:48 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: sashiko-reviews@lists.linux.dev
Cc: Eric Liu <liuer@nvidia.com>, linux-rtc@vger.kernel.org,
	linux-hwmon@vger.kernel.org
Subject: Re: [PATCH] rtc: nct3018y: report chassis intrusion through hwmon
Message-ID: <20261001072948351dc257@mail.local>
References: <20261001054108.3346426-1-liuer@nvidia.com>
 <20261001054821.AEF6E1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261001054821.AEF6E1F000FF@smtp.kernel.org>
X-Last-TLS-Session-Version: TLSv1.3

On 01/10/2026 05:48:21+0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] rtc: nct3018y: hwmon device registration violates layering guidelines
> --
> 
> commit 12bf4b0b27866f7565ebcc7b10db8faf4943fb10
> Author: Eric Liu <liuer@nvidia.com>
> 
> rtc: nct3018y: report chassis intrusion through hwmon
> 
> This patch adds an hwmon intrusion alarm for the chip's chassis intrusion
> latch. Reading it says whether the chassis has been opened since the latch was
> last cleared; writing 0 clears it and re-arms.
> 
> > diff --git a/drivers/rtc/rtc-nct3018y.c b/drivers/rtc/rtc-nct3018y.c
> > index 2f7ad57057a4b..194ba077363aa 100644
> > --- a/drivers/rtc/rtc-nct3018y.c
> > +++ b/drivers/rtc/rtc-nct3018y.c
> 
> [ ... ]
> 
> > @@ -491,6 +494,95 @@ static const struct rtc_class_ops nct3018y_rtc_ops = {
> >  	.ioctl		= nct3018y_ioctl,
> >  };
> >  
> > +#if IS_REACHABLE(CONFIG_HWMON)
> 
> [ ... ]
> 
> > +static void nct3018y_hwmon_register(struct nct3018y *nct3018y)
> > +{
> > +	struct device *dev;
> > +
> > +	dev = devm_hwmon_device_register_with_info(&nct3018y->client->dev,
> > +						   "nct3018y", nct3018y,
> > +						   &nct3018y_hwmon_chip_info,
> > +						   NULL);
> [Severity: Medium]
> Does this violate the hardware monitoring subsystem architecture rules?
> 
> Registering a hardware monitoring device directly from within
> nct3018y_hwmon_register() in drivers/rtc/rtc-nct3018y.c bypasses hwmon
> maintainer review and pollutes the RTC driver with secondary hardware
> monitoring code.
> 
> Could this hwmon functionality be decoupled via an auxiliary device driver
> located in the hwmon subsystem directory instead?

While this is not an issue to register the hwmon driver from rtc, this
still needs a review from the hwmon maintainers.

> 
> > +	if (IS_ERR(dev))
> > +		dev_warn(&nct3018y->client->dev,
> > +			 "unable to register hwmon device %ld\n", PTR_ERR(dev));
> > +}
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20261001054108.3346426-1-liuer@nvidia.com?part=1

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
