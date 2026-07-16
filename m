Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 737482749ED;
	Thu, 16 Jul 2026 12:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784206586; cv=none; b=Uvk2u5Gpn/+1N+uoAVYy4q/Jl/dzcAoSiL5ktxiWvx0PgAOkAe0jsPv4xMw/yYxp7nYgExqSTruwQEXFx/y5suSBlF2g62Crx4nXbzvJ40njvEGc0QS6kcA00yHezc8682SGyevCY6lioY24vjvYls/26IsYiE3TRrIujpA9Wcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784206586; c=relaxed/simple;
	bh=DtSWxolWzsTjVB/fjDhvXlXwJ3RsPXk5TusbpfQ30cw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hv/QX0NSkzg8Cc6qGHtVY79vjzV1is6y+A/rjbnoGin+QtlvD8Zf6J5swK+YViAh8R2w7NrmUj5iBkv7RWSoZl+z9reGmg6NVkYopjLo/pOOPGxThJ4Oq4Hjsi9t3y3jpplnNMKAvX74PT92qPyOJ9zQ8sLGwhmQwjnNSSkVoJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=eXioyMst; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="eXioyMst"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id B935B1A1020;
	Thu, 16 Jul 2026 12:56:20 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 7E662602B8;
	Thu, 16 Jul 2026 12:56:20 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 428FA11BD3CBE;
	Thu, 16 Jul 2026 14:56:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1784206579; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=Aw28TY7UZCwFlSvNxjaA1mVh5PejDKMaVVBoxdrFQg0=;
	b=eXioyMstS9M7/jD5rwZ3ivRZPDNLannlRWCBWp6OpVdutsqrLdl33gMBxhmk29I3ddqEkq
	igWpE1LQc9NNOY7D6SgM52JH73TaDBcQ1Escs+F1sgKoMws+xQQcDm53rXVTNQn77Z9G3w
	TFreqhyLXHy3NLCSbWPBZn+fYrjjFtVi/+O581HwSeRUm+lvejq00D2z21/jGR8ttSijWz
	4gFmmOvae+4NgoALh79xEeaHVulaU85twtJREOWhiQf601kgznp1ZPWSVXOIFAdbTro7b3
	enBAqya1v76/ZdeAfZ/gyRwTr88beydRElKmdPQxoK+ah358yg3FQMseV998hw==
Date: Thu, 16 Jul 2026 14:56:17 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Cosmo Chou <chou.cosmo@gmail.com>
Cc: linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
	cosmo.chou@quantatw.com
Subject: Re: [PATCH] rtc: pcf85363: Fix phantom device registration on
 missing hardware
Message-ID: <20260716125617ee5cdf09@mail.local>
References: <20260716125142.1801599-1-chou.cosmo@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260716125142.1801599-1-chou.cosmo@gmail.com>
X-Last-TLS-Session-Version: TLSv1.3

On 16/07/2026 20:51:42+0800, Cosmo Chou wrote:
> During probe, pcf85363_load_capacitance() writes the oscillator load
> capacitance configuration to the device. However, if the device is
> not physically present on the bus (returning -ENXIO), the driver
> only emits a warning and continues to execute the probe.
> 
> This results in the successful registration of a phantom RTC device
> via devm_rtc_register_device() and its associated nvmem regions.
> Consequently, userspace may attempt to bind to a non-functional
> /dev/rtc node.
> 
> Propagate the I2C error back to the driver core using dev_err_probe()
> to properly abort the probe and prevent phantom device registration.
> 

No, there is no point in this, simply remove the RTC node from you
device tree.

> Fixes: fd9a6a13949a ("rtc: pcf85363: add support for the quartz-load-femtofarads property")
> Signed-off-by: Cosmo Chou <chou.cosmo@gmail.com>
> ---
>  drivers/rtc/rtc-pcf85363.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/rtc/rtc-pcf85363.c b/drivers/rtc/rtc-pcf85363.c
> index 540042b9eec8..5612330aff40 100644
> --- a/drivers/rtc/rtc-pcf85363.c
> +++ b/drivers/rtc/rtc-pcf85363.c
> @@ -426,8 +426,8 @@ static int pcf85363_probe(struct i2c_client *client)
>  
>  	err = pcf85363_load_capacitance(pcf85363, client->dev.of_node);
>  	if (err < 0)
> -		dev_warn(&client->dev, "failed to set xtal load capacitance: %d",
> -			 err);
> +		return dev_err_probe(&client->dev, err,
> +				     "failed to set xtal load capacitance\n");
>  
>  	pcf85363->rtc->ops = &rtc_ops;
>  	pcf85363->rtc->range_min = RTC_TIMESTAMP_BEGIN_2000;
> -- 
> 2.43.0
> 

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
