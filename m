Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4873123C516;
	Thu,  5 Mar 2026 08:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772700070; cv=none; b=o8cCafgOo1wBLCQc5M3UiA2mQ9cQG9qMpJD8ovlsSaxmTCnbp9e6hdqvDYBw0XMp2riB7cqW2HCelmt4OQ6bXrDsOLf/t9LELOgz4AyW+S/tsfYzi8eb6VyhwGoUGCV+kE7ldfYOTaKOP/ST6fCRW/fCZcvZIN4LrId77LVEgcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772700070; c=relaxed/simple;
	bh=iF3PUHEKjIk76nJLd5hZsDXnu6qURJKhmmHfQ+wGcE0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BufFIjta2rVIMYLxd8LOOrxAZdenMrax+BLKPzzfy0gn6cOkLVF4AzHp3koolYEgrVQKkofh48CJhO9fSd2fp6b1QkMhPIPczyxNxN4Oq1hwyDFD7ADubtKVnDgdxq+qU4bxoJrVHONsUHBMe5V0uy6fJSma0AzpxSzM/iza13I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=UGHpfrqc; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="UGHpfrqc"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id DC4EBC40404;
	Thu,  5 Mar 2026 08:41:24 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 652745FDEB;
	Thu,  5 Mar 2026 08:41:06 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D69A210369535;
	Thu,  5 Mar 2026 09:41:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1772700065; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=BhfVEWF9EotYdDAuGOeZFsZqpxjQ+hginmFnoYV66/A=;
	b=UGHpfrqcv0lxYln2H1MPd18cC0Cdw+hs6OoXLQR7DzwZDlIQVPS1q6PquJFtL2WPJF2K94
	f+/jHe0rMRKoEaEyOkmrXjXFNBuzcSWLlsD9mvnFE6wlQOf3Kmm7CEN3x5+jW726ZNVeHb
	jtiZDh5bemxcztr2JFdKLgI0Teij7+mMHKzyN3qVVKh15s6KhmBurCytEj15NMgrnVAjTv
	zzZRJhAjTdaBL35lrCDMESfU/xbD3LtjxVeipser4QMWUfaL4x8LCiBhzvTG4+JUGcpoy/
	AOTIArULIe14c1YrM0KCICSQUQO8EdVvnmLcEaazZlfE80JqIK6pbj2LA8lJgg==
From: Gregory CLEMENT <gregory.clement@bootlin.com>
To: Rosen Penev <rosenp@gmail.com>, linux-rtc@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth
 <sebastian.hesselbarth@gmail.com>, Alexandre Belloni
 <alexandre.belloni@bootlin.com>, "moderated list:ARM/Marvell Kirkwood and
 Armada 370, 375, 38x,..." <linux-arm-kernel@lists.infradead.org>, open
 list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] rtc: armada38x: zalloc + calloc to single allocation
In-Reply-To: <20260304225329.24510-1-rosenp@gmail.com>
References: <20260304225329.24510-1-rosenp@gmail.com>
Date: Thu, 05 Mar 2026 09:41:03 +0100
Message-ID: <871phyfz34.fsf@BLaptop.bootlin.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

Rosen Penev <rosenp@gmail.com> writes:

> Use a flexible array member to simplify allocation.
>

I must admit that I didn't know struct_size(), it is a nice helper!

Reviewed-by: Gregory CLEMENT <gregory.clement@bootlin.com>

Thanks,

Gregory
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>  drivers/rtc/rtc-armada38x.c | 9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/rtc/rtc-armada38x.c b/drivers/rtc/rtc-armada38x.c
> index 713fa0d077cd..245290ae1a8d 100644
> --- a/drivers/rtc/rtc-armada38x.c
> +++ b/drivers/rtc/rtc-armada38x.c
> @@ -72,8 +72,8 @@ struct armada38x_rtc {
>  	spinlock_t	    lock;
>  	int		    irq;
>  	bool		    initialized;
> -	struct value_to_freq *val_to_freq;
>  	const struct armada38x_rtc_data *data;
> +	struct value_to_freq val_to_freq[];
>  };
>=20=20
>  #define ALARM1	0
> @@ -490,18 +490,13 @@ static __init int armada38x_rtc_probe(struct platfo=
rm_device *pdev)
>  {
>  	struct armada38x_rtc *rtc;
>=20=20
> -	rtc =3D devm_kzalloc(&pdev->dev, sizeof(struct armada38x_rtc),
> +	rtc =3D devm_kzalloc(&pdev->dev, struct_size(rtc, val_to_freq, SAMPLE_N=
R),
>  			    GFP_KERNEL);
>  	if (!rtc)
>  		return -ENOMEM;
>=20=20
>  	rtc->data =3D of_device_get_match_data(&pdev->dev);
>=20=20
> -	rtc->val_to_freq =3D devm_kcalloc(&pdev->dev, SAMPLE_NR,
> -				sizeof(struct value_to_freq), GFP_KERNEL);
> -	if (!rtc->val_to_freq)
> -		return -ENOMEM;
> -
>  	spin_lock_init(&rtc->lock);
>=20=20
>  	rtc->regs =3D devm_platform_ioremap_resource_byname(pdev, "rtc");
> --=20
> 2.53.0
>

--=20
Gr=C3=A9gory CLEMENT, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
