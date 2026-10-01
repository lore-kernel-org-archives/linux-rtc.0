Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A234A29E10B
	for <linux-rtc@vger.kernel.org>; Thu,  1 Oct 2026 12:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790857747; cv=none; b=K8Yt9IdzLVKEzofI57RaUtsTZua49reHlPocQ4jbTKpgW43NMZWAvunDp+qCaRWUZzQK48IIYkfvbYbnb6fbqb1bsCJLD2uH3z3+t+F9JTLI0kTdkgjWQ4hlkjn/9r2GSOvG2uNatmp7E4b5GwGKepBgbt2N/7kKKeMiftC3i9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790857747; c=relaxed/simple;
	bh=JE5IEeiVgkZaqutUWQ+pCCknavzg8Me6Fir4t8mJMJQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ewvVxWvqtuzqcMb6e5w/0pcGYwRw+UJyr0PkFYzyvL591JkP6gyVqvI37xOUzC3iGpDne1eospQwrpgRNzziD/RbOUwkCE9ct8K62/s4yAWdhz5VJxLY/JK/0u+3p0TWHWCcflqXL3B2fkDhi1Gg3ntEwAlGwu7UWM3cJmz3wpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kqf5DZjE; arc=none smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kqf5DZjE"
Received: by mail-pj2-f43.google.com with SMTP id 98e67ed59e1d1-396ccdaea76so1967586a91.0
        for <linux-rtc@vger.kernel.org>; Thu, 01 Oct 2026 05:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790857745; x=1791462545; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=OawrqHgaVkSeMDOujTYqzq1MZTZEufov/VzumsaTU7s=;
        b=kqf5DZjEGhJrlQKj+cO7OnyB5cPNZox3jqbi4gi6ljXovXynFYU4DApKukGq5ZhAdE
         KHe4RDi0kM/X8xmMiiXUZdhNXpXJfRD+1PiWOTIQrFf1+5uORhf9HrEVaP+rpv21WgJy
         HhBsgtRkdq8+Hb5sNRiDV85cfOuhEN/ofgWiQbmxhQuto0G1s5V2DLozXX23x3Vqu6Ob
         teI5wju1Qzr5jK+kcT0NN9l0VCBPzHIn9UE9Ng/qiwRhxSnciK62BspZljPV2A/cICUZ
         JzvLJ3W9Pw+tiSsdOtujbL6p9bjxoagGSwbUz5dWjNoMkx4EuUKs++hFOSSoe3gTocC3
         +gZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790857745; x=1791462545;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OawrqHgaVkSeMDOujTYqzq1MZTZEufov/VzumsaTU7s=;
        b=mbz1noLHJgl3MVqpYX1vJKwh6h8jh2JAIvz2ZgjaUvE//tfsfwdZYAsS6qmuT6Sfho
         wu3WaL5Iaqqixo2Q52uJXk8SlocJkpHWaV3aLBsJy/uEYh0GeNtJPWxFzz/laVtTLTK6
         BKQvc5FsnMPtnT743vV1yp48/ivzoZvUIRy0QSBHz10kpK5nEyB4ySyeF2odRQpi0+8J
         sXddEVlZcY5lsg1aSPcJjKuuZu4wBfxkkXZP8OdnHoXSOEFHBN/UihT7erKIOQ5Z7moP
         TKBjkByFgVfmzoGa0Q85PFfvYjpmr0P2N9Uql66PdDIM9UEB52NKhR1t4SMn+uX90qrY
         F+Lw==
X-Forwarded-Encrypted: i=1; AKwUvBzJotw9uXIJ1cXHkkKjnFz7CALW6rX3WbQOyiHY1MysENvwYWTOIVj9TaG/HxrT0x2wzq/avz1U5UI=@vger.kernel.org
X-Gm-Message-State: AFq9FYJrCKwxw50BDDWN5+4lGiWx9WkxyJPVe6zEZLI8iuTlzffjwh8R
	XvWYB4nNeckx1AvuH0RXKFODsrjImYpT2X6UkTE1h/ZrG16x8CsKKygg
X-Gm-Gg: AYBFou3ugLMZZ7grNwh7A7sJ43sunIVtUPIgN9HKASXtbI+rHB8+C8H5UC6l4/bZq1H
	dhfShEIHBFY+QbZp77ULLZO/Qgssn6JLdmy8ZAmJzsy8IXCEjD3se49RotRTszUPjlfhs/6m3SW
	gKzk/QWNx68sMShlq0AUbmjDBa0YQkKx2Aa5eYr4oTpEgBlaE/rTDg9ENCaIKAldGh9MpW7fsK+
	9TiA8MR2K/mWS8zSkQtDWkeQe8OFsvmddRYsM6CAnHggEqMsEUyQ4w4bu34wnaGjKocSIfYxbbJ
	j0JpjXoNFI1xxAlRf364q4kvjb65mUlzmYH1cSUNCD1iyMDpJyZY3t0Gv5Od+98RpkQ8XFBL1TB
	YgBA6JRZSfUAI4cUREK2chUxxWTOnGMgn2azhIeoIddSKRRiAUBbEKTb2Ho98N8y3qd8/oTPfTD
	j40GLHHBLCq3dW+907H5rY9NeJVKItKubNrboY9uByHwrLTye78toRGlhsxEha7gHBXKRzjqFTn
	KKbYP3jtGpGiQ==
X-Received: by 2002:a17:90b:268a:b0:3a4:93c3:9365 with SMTP id 98e67ed59e1d1-3a4f317895fmr1712145a91.34.1790857744659;
        Thu, 01 Oct 2026 05:29:04 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a4f774beedsm1599162a91.3.2026.10.01.05.29.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 05:29:04 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Thu, 1 Oct 2026 05:29:02 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: sashiko-reviews@lists.linux.dev, Eric Liu <liuer@nvidia.com>,
	linux-rtc@vger.kernel.org, linux-hwmon@vger.kernel.org
Subject: Re: [PATCH] rtc: nct3018y: report chassis intrusion through hwmon
Message-ID: <45520c29-aadd-48ab-a67c-a3b9ee4f3277@roeck-us.net>
References: <20261001054108.3346426-1-liuer@nvidia.com>
 <20261001054821.AEF6E1F000FF@smtp.kernel.org>
 <20261001072948351dc257@mail.local>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261001072948351dc257@mail.local>

On Thu, Oct 01, 2026 at 09:29:48AM +0200, Alexandre Belloni wrote:
> On 01/10/2026 05:48:21+0000, sashiko-bot@kernel.org wrote:
> > Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> > - [Medium] rtc: nct3018y: hwmon device registration violates layering guidelines
> > --
> > 
> > commit 12bf4b0b27866f7565ebcc7b10db8faf4943fb10
> > Author: Eric Liu <liuer@nvidia.com>
> > 
> > rtc: nct3018y: report chassis intrusion through hwmon
> > 
> > This patch adds an hwmon intrusion alarm for the chip's chassis intrusion
> > latch. Reading it says whether the chassis has been opened since the latch was
> > last cleared; writing 0 clears it and re-arms.
> > 
> > > diff --git a/drivers/rtc/rtc-nct3018y.c b/drivers/rtc/rtc-nct3018y.c
> > > index 2f7ad57057a4b..194ba077363aa 100644
> > > --- a/drivers/rtc/rtc-nct3018y.c
> > > +++ b/drivers/rtc/rtc-nct3018y.c
> > 
> > [ ... ]
> > 
> > > @@ -491,6 +494,95 @@ static const struct rtc_class_ops nct3018y_rtc_ops = {
> > >  	.ioctl		= nct3018y_ioctl,
> > >  };
> > >  
> > > +#if IS_REACHABLE(CONFIG_HWMON)
> > 
> > [ ... ]
> > 
> > > +static void nct3018y_hwmon_register(struct nct3018y *nct3018y)
> > > +{
> > > +	struct device *dev;
> > > +
> > > +	dev = devm_hwmon_device_register_with_info(&nct3018y->client->dev,
> > > +						   "nct3018y", nct3018y,
> > > +						   &nct3018y_hwmon_chip_info,
> > > +						   NULL);
> > [Severity: Medium]
> > Does this violate the hardware monitoring subsystem architecture rules?
> > 
> > Registering a hardware monitoring device directly from within
> > nct3018y_hwmon_register() in drivers/rtc/rtc-nct3018y.c bypasses hwmon
> > maintainer review and pollutes the RTC driver with secondary hardware
> > monitoring code.
> > 
> > Could this hwmon functionality be decoupled via an auxiliary device driver
> > located in the hwmon subsystem directory instead?
> 
> While this is not an issue to register the hwmon driver from rtc, this
> still needs a review from the hwmon maintainers.

I don't usually do that, because I have been told several times from people
submitting hwmon drivers outside drivers/hwmon that I am clueless about
hardware monitoring. From my perspective, every hwmon driver outside
drivers/hwmon gets a free ride and is the responsibility of the subsystem
maintainer.

Guenter
