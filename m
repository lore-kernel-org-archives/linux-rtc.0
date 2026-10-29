Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.149
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793281805;
	b=kwsIuIcf0glGDsad1J17w/C/Udbt0ikL6Dp51zmxhtT6q9chayFI/GzwY0SthmrPbuwe
	 mXO1nscOyCB3SRxlUBS5ncEUiJDe+HraiqTM5Z9xof4Gpy00E3anILgnjFVwIfEFQQiD2
	 gdrgnn+7YMutPsa42tfqFGT7iHaXFOVY4aa02SlrqSeLKKWypTtp9epyc6mRMuKtsVA9V
	 xk9rjaB0sFb8IqBiNeqyraHl0zqFeynWNG1R1WyVnu3/BRypadTRTXfuxm8bWp+nympzB
	 ZSHObpO70j9mfGuOgD2uqHK8NjN0D7iLU5V2heDiiXEf7ctMXa8gYtZx678vaaay2Jg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793281805;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=eVQoUYkvGYDjfff+tOxxhz0fkEYj1xQD620TYS9hUB4=;
	b=ITOT+QpDCrf9Q5NcRCKEvYxlrXAj0VP7fTtTLiqh56kN/Bqbs8wZ+3q4i0LE1N+YUtYk
	 Wsza5vy7AKcx8Q8MYZ1F74GdsthvZl57UOgx5oUmCGAyqe7kKz7VBR5kpFaK8CAfJw7VI
	 2fMYjUjBewiclseUOcEPuv8AEWM9I7c9H8AlyqZNJcQ57aIslYl9CiVzLMwd9RNNg1q0L
	 v07fl4yoSHTs+pNeuMMkzgTHbRboY78Zdt9YlAsFjzRzDMB7kBAXa83R1RKYAP2vQ1HAd
	 tTqDITFMnOpr6bBG6RMTDjOT+3lytrR7d6YVXo7gZOA0louK/pnFylyiJMHm+Gfux1w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kumba.dev;
	spf=pass smtp.mailfrom=kumba.dev;
	dkim=pass header.d=kumba.dev header.i=@kumba.dev header.a=rsa-sha256 header.s=fm3 header.b=CadEP7sI;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=jJU0Rr06;
	arc=none smtp.remote-ip=103.168.172.149
Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0643E606A336
	for <linux-rtc@vger.kernel.org>; Thu, 29 Oct 2026 13:50:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0643E606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kumba.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kumba.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kumba.dev header.i=@kumba.dev header.a=rsa-sha256 header.s=fm3 header.b=CadEP7sI;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=jJU0Rr06
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 2076FEC0238
	for <linux-rtc@vger.kernel.org>; Thu, 29 Oct 2026 09:50:03 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Thu, 29 Oct 2026 09:50:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kumba.dev; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1793281803;
	 x=1793368203; bh=eVQoUYkvGYDjfff+tOxxhz0fkEYj1xQD620TYS9hUB4=; b=
	CadEP7sItSZKo62jD62pV24Eyju7XUlE8fUJJqjR1y4lIfIvq55x+e0AhF+1o9gw
	eII6YEfAXOc2yHtMMHVQWUEPdQvQ+Z0lkuN2bLo3cyCkaASsTi1bWwcq3PeurSji
	+XAYO8/995NmqJJZOIKKJAVuqJS++oXBH+mgAjHsFw9AzkUGfljEDSr+a22Ap/z0
	X9PvVhmk1+uHHDAJwd3Qn3LAUZfauiPYU0GddkgY4ErMShRx2bjSEwJebmqlAihU
	JRUcQOHPh3ue/p4iF60DaFYKubaQU4b1rRYacYl7O1+O+eUWqmbyO3roK7yiU3Ef
	UvxbVxpLGQdZa0yRJAhmOA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1793281803; x=
	1793368203; bh=eVQoUYkvGYDjfff+tOxxhz0fkEYj1xQD620TYS9hUB4=; b=j
	JU0Rr06gcY54HDgiz5nihCbd2AuQXcL+JmZiqQzEr/IpwY9LUqWVKsbBZSfvGTGP
	ivuChXR9+IwHdl6F1HCsnjtuU3R5EFBN2lPMs9frL55SvW9DyiM++fwCAsOsKUZ5
	dIwitt+XH8iVGYBCi0OUQ7JMZP8tqwdA3QQZIYGuS+BbeFuQLhRG/ANFuc6PeRUh
	+EST13QtRo6JcPqQwmOGYfS29m1HWrZGkVLyR4BhKzgVmIcc0dIGnQCuJ++t4yxK
	A6eDr6xyDBkIDKzz+a6cPtsUk4b9bWaKgpX7ATMR0Zm3PDyKWuHRxWRQyIo+R0DW
	882U1fdhS5rUe9iA5UyMQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=kumba.dev a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793281803; d=kumba.dev;
	mf=PGxpbnV4QGt1bWJhLmRldj4=;
	rt=PGxpbnV4LXJ0Y0B2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:GuV9tC/ODPC8sXYEmwKS8PuvkLVuYn5EuC3XowW4IAoJrDS
	KORqM3I19jAQE2AHJdm6jdXZmz04OfWBVXbF4csH4RpwCPszYhWkl+a/RM73F3hn
	K5w94DpLmtvDltnqRLt1rnXEfR+WLYNpDpNiTr9xrEvodHOWlQK04M10FnfDsG1W
	fOYzqVAeMxvcJACiFTG+/jXQVI/bChTmcTqOEfRzeDWKE8MtfarcUrNK/n7eD+oD
	gTF5FlagRKpcpxHAT4QlXqUsmLO8DLla6LyY9hXQ8Rd/C/vHLo5eeKdLAEvV6yxD
	V6ku2PXegrXlVJzkGBKiZw42gsAj/GnYcTHqH6A==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=14;
	hn=cc,content-language,content-transfer-encoding,content-type,
	date,feedback-id,from,in-reply-to,message-id,mime-version,
	references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:vI6qlQzBl+GTvVPBRgsmO2IJJENyKhLbipEFDZwD5SE=:lL9PBvvwMS9xs8eXtNx38+AREKQmoiWBzQomeHrfdAE=;
X-ME-Sender: <xms:Ck_jave8BM8NpGD7iFmOhJME1o5cTG0RZNLl9Srpb-Hoz-nYfKP14g>
    <xme:Ck_jas_iSLV8B39gCbFih0FLd51Xlsc0KE-mON2Q-sExnCZb8opysTS-0-XUX4IpN
    GwgfVWtMH8497Jlvm6QEOKZu1udjQ3xmBN7ApSicgC3tkpqxy9fum4>
X-ME-Received: <xmr:Ck_jarkHBK9IA4qFItVehNrDMPdEkT0nmwlkNJRncF4jCjlTJ-hwlEqRhoWFr6NF2cx2GCYnXEQ7AixrG_uC03MrStGMfTo9gVBZjSSuSGqNN285Rw>
X-ME-Proxy-Cause: dmFkZTGCckvdbmJSrwT/0nMfGBTG3ucAJFscvqUupw1+PIdf9k85QpSvIakmALPkITSkBn
    OqWFT29uRp3qXLwvOSYMU68AYInSwGDonE3aOzU2oH8Lh15MBvG20ALFEBZqwDIG7U9eDQ
    ogsEG9S8TPZByQyjFGgRNsW0qQ0MyNZUoEBf5oVIplSKLon44SBl/35GXBRaPmlP1grLf0
    1KIupexiHba9aukIGulUsFvEXwIsN3QqUIkJHkxbARsiEh+12aaVWbNgdmbYR4flZrt4ck
    7RPMyakRmRw57PNO7VCC68NFPymo8G4ufakBiXXGN2MgOwzXi4TMKkkkOos7WKXxLesFBr
    Oxkvx3ynNbLpQN4EYLCCR7bg9BWOabx2bQLx0k9veOSOGRRoF/MDTCRmT9pG3GyXQ/YBFA
    cPXUC6i7Q6a7w15ZKFjgxxMYwTHkRb8kFKX8RBJ748dRCQW3+2iAXiX8aNgYJwMwe1ySJ+
    ShWkJsdj88IiNGhYyuEZqnc5xymxcEzBIC2pUjpHGXCod5MvGPmkJ/K+hImBNs6lszQdMv
    5oQImApVOUIjJ4dda81oZoza/ZTcEWQr3DtMeJRDxqSPrqqRoc4hLZ5Tas/qD1xhIrqxSe
    o8odDWg8bzE60aI/fnS6wAoNjuXmsaySuCpXg9sNqJ22P56ZH2OtL7PfRVoA
X-ME-Proxy: <xmx:Ck_jau8AxboZPS-aVfBFC1ZXDTaQ8NTFxzqYbYhWSuH0Atj-g1ExkQ>
    <xmx:Ck_japkp3xBbCGQVpNrbC2CGw-_D9j-YPJcIUOrwG4gxgHwC0v4qpg>
    <xmx:Ck_jar3snhh5RNc6zjhvIdfdkAZ-8gEzQajf6nSI4MVc_rzVm4-ZNQ>
    <xmx:Ck_jakqogtatBdjqADszrRDdEe8zm2-MI1X5k1p-22h3FhgXylcDzw>
    <xmx:C0_japhw9vU7zVDe_0AQinRYNGntEA10Em-jhjDaSddr1OjJpH-_EkJR>
Feedback-ID: if8114916:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 29 Oct 2026 09:50:02 -0400 (EDT)
Message-ID: <cd2a54f7-89f2-4683-b6da-cf14e62fffe0@kumba.dev>
Date: Thu, 29 Oct 2026 09:49:18 -0400
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/12] rtc: ds1685: use sysfs_emit() instead of sprintf()
To: alexandre.belloni@bootlin.com
Cc: linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261029132339.925021-1-alexandre.belloni@bootlin.com>
 <20261029132339.925021-9-alexandre.belloni@bootlin.com>
Content-Language: en-US
From: Joshua Kinard <linux@kumba.dev>
In-Reply-To: <20261029132339.925021-9-alexandre.belloni@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/29/2026 09:23, alexandre.belloni@bootlin.com wrote:
> From: Alexandre Belloni <alexandre.belloni@bootlin.com>
> 
> Use sysfs_emit() instead of sprintf() in sysfs show callbacks
> (ds1685_rtc_sysfs_battery_show, ds1685_rtc_sysfs_auxbatt_show and
> ds1685_rtc_sysfs_serial_show) to conform to the recommended sysfs
> attribute formatting guidelines in
> Documentation/filesystems/sysfs.rst.
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> ---
>   drivers/rtc/rtc-ds1685.c | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/rtc/rtc-ds1685.c b/drivers/rtc/rtc-ds1685.c
> index 284815e5f478..323fc9c17106 100644
> --- a/drivers/rtc/rtc-ds1685.c
> +++ b/drivers/rtc/rtc-ds1685.c
> @@ -988,8 +988,8 @@ ds1685_rtc_sysfs_battery_show(struct device *dev,
>   
>   	ctrld = rtc->read(rtc, RTC_CTRL_D);
>   
> -	return sprintf(buf, "%s\n",
> -			(ctrld & RTC_CTRL_D_VRT) ? "ok" : "not ok or N/A");
> +	return sysfs_emit(buf, "%s\n",
> +			  (ctrld & RTC_CTRL_D_VRT) ? "ok" : "not ok or N/A");
>   }
>   static DEVICE_ATTR(battery, S_IRUGO, ds1685_rtc_sysfs_battery_show, NULL);
>   
> @@ -1010,8 +1010,8 @@ ds1685_rtc_sysfs_auxbatt_show(struct device *dev,
>   	ctrl4a = rtc->read(rtc, RTC_EXT_CTRL_4A);
>   	ds1685_rtc_switch_to_bank0(rtc);
>   
> -	return sprintf(buf, "%s\n",
> -			(ctrl4a & RTC_CTRL_4A_VRT2) ? "ok" : "not ok or N/A");
> +	return sysfs_emit(buf, "%s\n",
> +			  (ctrl4a & RTC_CTRL_4A_VRT2) ? "ok" : "not ok or N/A");
>   }
>   static DEVICE_ATTR(auxbatt, S_IRUGO, ds1685_rtc_sysfs_auxbatt_show, NULL);
>   
> @@ -1032,7 +1032,7 @@ ds1685_rtc_sysfs_serial_show(struct device *dev,
>   	ds1685_rtc_get_ssn(rtc, ssn);
>   	ds1685_rtc_switch_to_bank0(rtc);
>   
> -	return sprintf(buf, "%8phC\n", ssn);
> +	return sysfs_emit(buf, "%8phC\n", ssn);
>   }
>   static DEVICE_ATTR(serial, S_IRUGO, ds1685_rtc_sysfs_serial_show, NULL);
>   

Acked-by: Joshua Kinard <linux@kumba.dev>
