Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7540F3909AB
	for <linux-rtc@vger.kernel.org>; Thu, 23 Jul 2026 17:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784829139; cv=none; b=Sixi+JSOg4NbiDzKur7O3aJ3jtJE+at34yNXl/qIdW2x2rH7QU5mBRdSKh7y8MvoWjvJbDk9thnJqtKK+ySACboU+yntBKPW7/e/Nte4bmzrTQx1BFxM0p9zNHihDV/dfckrr1//I/l5lNXglRf9mRAGKgOmEgzUmLdNEwe1J9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784829139; c=relaxed/simple;
	bh=1MPMvOczMfE71F3sxE+tZk6T3YzHla2u2hhnMSEmLCI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q0EsbXAWKcoOfj1Yi9B7Qw6jpq9G5JpLBSm86/0K9gpyYnmPC1dTchNUQKFZfsERthyoNRVtvddZSDiUaj79U+7rhdOpo/c/D+CcWKqF9HqlObNHuBUIC9jfOYMSvmoY8NP8ubUmMJcJ+sIYePJVCzBX/M36aK7YrCLbHvHLVG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y9+p3tk6; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y9+p3tk6"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-47f3b39f2a1so874400f8f.2
        for <linux-rtc@vger.kernel.org>; Thu, 23 Jul 2026 10:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784829136; x=1785433936; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=WQjaJTz3kBHgokHNYTl/gM5EyjGoZTl675jw/y4LuvQ=;
        b=Y9+p3tk6MXr/+kEcB2TAS6IxVFuDBQkJm2KxyffdTIpNunvQW6y80kTmQtdzLfpkZO
         xwH82FDZZkcRExzLKLtfEiIGHsTpwQkcgj8SgShJqFggEzDh5rGH2h4XGViASJ1QS5dM
         Ejiv1PYn9x9Zhz1OCFBMu04eRwoF/VR2fJBRiwmV5cFQHkiRjt2HOuectAsehtV9BHao
         d04Wix05frfb6OxDGEhSsefielmx0rWjEvgcl5lh3pAP3YFCmzEFXSBkLMFtKmDO5ZMB
         h07RXVj+tFRAoEVp+q6HZUVIXLu42YnbQzTu8SnLYV18hhiWZ/O4zfY8g/+k96P9eyWN
         hiTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784829136; x=1785433936;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=WQjaJTz3kBHgokHNYTl/gM5EyjGoZTl675jw/y4LuvQ=;
        b=aVH7/GTB5eNqQbkMFdmQhqdPmbziVJUrY39eTrzaEyGUshTab368la10wXnRnOkbn4
         5Vm42HMDNCrkN6iPjYCP4aY8a5JmGYHD6cTqnT5JGqiaQxNfUKgWky44GWR0pz5A07g9
         qf2czn2FNSaZCcSNpa69n9Ho3IqAvPsR9kWd9GgoPFtNav+/fomWn5IB9pEkAr9ZT0Bx
         ZWOX09LJBoeECJt0b1SId3qByR7FcpzThxXQ3xyUWsVPaaIT7UgkcWrXfGgYWa+NC0Le
         8JIBJEFy7rO8al++DRAT7p17hrVMaaC5nVlsPWuW5kHNTpNNWSUbxC1kCaKeZ/1x0Pqu
         n/bw==
X-Forwarded-Encrypted: i=1; AHgh+RpvR/M2spHLh1vEt203hOByAb4DdcIftyA4p6JDXyCVfY2LZg9LbXaJyVuMWZJFpiP6q8QhBGrCNWg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4H6fEspeG3d5039HeWrZ9o38zyshKKj4oMNYiX6jLVZxZ8oVW
	2D5CQS4BGJvD4Z7aAKeNPopM4UJq2ZGEQzN+hDmfUUybzSq6NZFPWGMC
X-Gm-Gg: AR+sD11FLouCcuD1qN9Vj6T7hmhH5/5UOhoswoW8e3352dmorGQLkztDmBitPHuiaud
	wDwJcE//To6qbj22D+ak9mfojdIIbELUzDtvgRhPPVFQNCifU/I0VqkbugbEVgTH+v7MNThw04T
	2lvmgAGU+8ecwkKzcLkHcyDORNF6+tKallUmcvPY2a39fcEPBBdjSkMbKIUdI1Or4Nb+n3MPXNE
	4oAauc3O7pwwjekwSKjZ7jWCXq24WIy3PiJimMWNL7EfjpHCU9OAROLsZBnT+HCodaWNIO1o96H
	TN+oPzQP8oWWtR6mxVldGbXPSw/xfP6S/FF3esL9hyG2r7S5oWBMs3cw085QmBHAp/mpYn32GVG
	WXuesIb5191VpLbXnUDuQwQ2/U9cvj02F5G4mYLRkGa1xzM4uRgpW5msY04L1vl9Abd8q3F/ilT
	ijO8Q0
X-Received: by 2002:a5d:64c3:0:b0:47f:838c:4256 with SMTP id ffacd0b85a97d-47f8d71c7f5mr5792280f8f.16.1784829135607;
        Thu, 23 Jul 2026 10:52:15 -0700 (PDT)
Received: from antoniarch ([78.212.250.35])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85c6ef25sm15799410f8f.36.2026.07.23.10.52.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 10:52:15 -0700 (PDT)
Date: Thu, 23 Jul 2026 19:50:50 +0200
From: Antoni Pokusinski <apokusinski01@gmail.com>
To: sashiko-reviews@lists.linux.dev
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>, conor+dt@kernel.org, 
	linux-rtc@vger.kernel.org, devicetree@vger.kernel.org, robh@kernel.org
Subject: Re: [PATCH 5/6] rtc: abx80x: create abx80x_i2c_probe()
Message-ID: <amJTTziIZ-WhP5Ih@antoniarch>
References: <20260722195814.298552-1-apokusinski01@gmail.com>
 <20260722195814.298552-6-apokusinski01@gmail.com>
 <20260722201057.5CE841F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260722201057.5CE841F000E9@smtp.kernel.org>

On Wed, Jul 22, 2026 at 08:10:57PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] RV1805 hardware workarounds are skipped during auto-detection.
> --
> 
> --- Patch [5]: [PATCH 5/6] rtc: abx80x: create abx80x_i2c_probe() ---
> commit 0661079a8b8384fb14bc67f5100b45ebe0a01c3e
> Author: Antoni Pokusinski <apokusinski01@gmail.com>
> 
> rtc: abx80x: create abx80x_i2c_probe()
> 
> Move the I2C-specific code from abx80x_probe() to the newly created
> function. This is a preparation for introducing the support for
> ABX81X RTCs which use SPI interface.
> 
> > diff --git a/drivers/rtc/rtc-abx80x.c b/drivers/rtc/rtc-abx80x.c
> > index 7761cb353994e..6e0c14695bdf1 100644
> > --- a/drivers/rtc/rtc-abx80x.c
> > +++ b/drivers/rtc/rtc-abx80x.c
> [ ... ]
> > @@ -855,7 +820,7 @@ static int abx80x_probe(struct i2c_client *client)
> >  					ABX8XX_OUT_CTRL_EXDS,
> >  					ABX8XX_OUT_CTRL_EXDS);
> >  		if (err < 0) {
> > -			dev_err(&client->dev,
> > +			dev_err(dev,
> >  				"Unable to write output control register\n");
> >  			return -EIO;
> >  		}
> > @@ -867,26 +832,24 @@ static int abx80x_probe(struct i2c_client *client)
> >  			if (partnumber == abx80x_caps[i].pn)
> >  				break;
> >  		if (abx80x_caps[i].pn == 0) {
> > -			dev_err(&client->dev, "Unknown part: %04x\n",
> > -				partnumber);
> > +			dev_err(dev, "Unknown part: %04x\n", partnumber);
> >  			return -EINVAL;
> >  		}
> >  		part = i;
> >  	}
> 
> [Severity: High]
> This is a pre-existing issue, but are the RV1805 hardware workarounds being
> skipped during auto-detection?
> 
> Looking at abx80x_probe() in drivers/rtc/rtc-abx80x.c, the RV1805 specifics
> are configured before the part auto-detection logic resolves the hardware type:
> 
>     /* Configure RV1805 specifics */
>     if (part == RV1805) {
>         ...
>     }
> 
>     /* part autodetection */
>     if (part == ABX80X) {
>         for (i = 0; abx80x_caps[i].pn; i++)
>             if (partnumber == abx80x_caps[i].pn)
>                 break;
>         ...
>         part = i;
>     }
> 
> When the driver is bound using the generic "abracon,abx80x" compatible string
> or I2C ID, the part argument is initialized to ABX80X. Because the workarounds
> check if (part == RV1805) before part is updated to RV1805, they appear to be
> silently bypassed.
> 
> Could this cause the RV1805 RTC to accidentally enter test mode and suffer
> from extra power leakage?
Yes, this makes sense. The fix would be to simply move the autodetection before
the "Configure RV1805 specifics" section. Will add this as a separate
patch in v2.

> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260722195814.298552-1-apokusinski01@gmail.com?part=5
