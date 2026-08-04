Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBEF62AD37
	for <linux-rtc@vger.kernel.org>; Tue,  4 Aug 2026 21:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785877653; cv=none; b=q7ZPDl9T5zmG8F03xNb9fl/+1o7tMun2dSadMHZ988BqOdL/5tiJtu/xNdlsPvBEUmDyciDNRP4XyNVwiYsO2tdgoAgPyd//YdxQhBhSgQRm2P/MH7MJuVkNm/zxPCPo0Dph6JY8SDir5VAL00c3FM5VfkTmqm3l/EkivK1Jba4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785877653; c=relaxed/simple;
	bh=MqyZPi/V5NJx6vV2SdV1+IfypwjkafHwDw7xnDQsGLA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kMEamLAOQczj5JP3UI0OF3n3pi3gasSlvYT9jMjUfAnuPy8Q0MLUpZHKv1KgH9TCe4vtCNAdkTE4k7gQnuvBv+XHFpOSsgYpwWCcR/Xu+hMD6kmeY3LMDOdlNrAYYiVtYTUoJf11rRa9PlSss4UJmYZ5AqLNEhGVdZZMe6OpbL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IBOger9p; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IBOger9p"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-47f703a9d05so162460f8f.0
        for <linux-rtc@vger.kernel.org>; Tue, 04 Aug 2026 14:07:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785877650; x=1786482450; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=yOWzmUvYZeYNGqxg/uKSDiCHW1g30hB6ShJQ+fmTldE=;
        b=IBOger9pmHpgwgNKS9R2ToPEZHUkO49SC4HuCKraER8aFLqpXzecBJcSg1n4/eFWIu
         37Rx80QREvImc73Du8X3x0HCKCQXvDHyeoMmfs2tKsmvhhp7wfYZgveB7cuOS9LDmFAp
         wdbskJPJ2eVnd6r8q4Q7uAR2R2D2e5jW4sa0A9H0mIn5Q56X0JnXbqXPcWCo3GvLNxPk
         ZfySkY4furCK+w57KF+ms3m7wteWtC+kclQfdHzfF/cN1nC0MTX3OzDPEoLfrmsJoHkV
         VW5nbOAlDJqAYwhsHt3oSrFDc65A7UD2FHrOW8R+H+/ynVoCXM0kt50iOlJ/ZdiMRq6U
         vVWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785877650; x=1786482450;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=yOWzmUvYZeYNGqxg/uKSDiCHW1g30hB6ShJQ+fmTldE=;
        b=ND7clAeE7YzKwpjMqh+0duAL8VVd89l5WHMWkVxuKIdAfCyCyOe6JvHH5Nonzax69X
         jv8m7pnNFJsxCTXY45ecZT+rTQ/rvjchz5QljRKELzV9oc+P5UDd80/cQKiS2tHPQIcl
         /PtTEk/QH4A+vxQCqn4hTIgZdYWpkL08dwqBI2n6cMnFzv4KCFsS84Q9WxYJ1VdJ6FLm
         ryqP4TjTc4hsz+Lk8KQA1fc10AlrD8WyzuFbdCKqN98K0wIr8S5+M84HNFt8R0E7fRAK
         C+f8kwlA3lTBNANUUGNeqOmL6t9S+etxIMWkSnhzkVCAflfRaIM2x+xIL2omiK8q2vJU
         90LQ==
X-Forwarded-Encrypted: i=1; AHgh+RrtNWlKdV3KEYdYkMmOj78ljVT/siJrPZzhtP4IwPNyv5Scj/RlgmLAb8vX2P0VuQdXPKh4M0f85qA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6uksBWprYUUJJd+byv4nbhKJPUT3VjeLSSJn0SEkdOliaqAqo
	n6HQmGgCsp4EZU/jZL6URwY1rZvlJJkbNIJQm5PNKb1aCy4ohvr/t07H
X-Gm-Gg: AR+sD12f4x1iSGpQxThAfWQoW53LtuEwY9tHisRB99HiqiQZkdm4yuO1IhefZGtPlFo
	mqLs028CWyeXellF/qwBK+Kh1ucnT712iqU9afunllLoc/HK4Xiv9VvATSFP5CPa0VCGvKkIhTE
	7AduYz4eWPoRgsAIqxF6o4Vgm5cNXL7nc4vOJuDTYgfX7wA65eLw6NfQcZj5ue5iiV2w4CoADtj
	VAUD8eka6ijoDYXANASWWNr+B7ILHN5nylvz464aH88i2kQB/44vJyrwUA8US1nv4eIjMAPdRh/
	J3aZzc3jwtRqffQ9wjQcfS7AcYzP/daruG5GrWO0LzgVAfeMANmAUiBg7r52DE9RguC5CRqaXpS
	pO+NV6rNeawCeA/Hb/I5H1iqFDmhx2ZRHaqxTnJULEuvAaC9xIT/5pgnuORocVxw0rWTua6mnnq
	ab7/ABTuQuu3PRxl/e4eMeyI1bcsfBBj0IphVINC7OBqZYqV+bZTSxBHTa7wF/YsrZ
X-Received: by 2002:a05:6000:1889:b0:47f:e377:8d61 with SMTP id ffacd0b85a97d-47fec50fecbmr3306220f8f.11.1785877649864;
        Tue, 04 Aug 2026 14:07:29 -0700 (PDT)
Received: from antoniarch ([78.211.212.238])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fec23e533sm2925271f8f.28.2026.08.04.14.07.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 14:07:29 -0700 (PDT)
Date: Tue, 4 Aug 2026 23:05:59 +0200
From: Antoni Pokusinski <apokusinski01@gmail.com>
To: sashiko-reviews@lists.linux.dev
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>, robh@kernel.org, 
	devicetree@vger.kernel.org, linux-rtc@vger.kernel.org, conor+dt@kernel.org
Subject: Re: [PATCH v3 3/8] rtc: abx80x: properly handle shared IRQs
Message-ID: <anJQBtfXjktYm6Cw@antoniarch>
References: <20260731184831.44037-1-apokusinski01@gmail.com>
 <20260731184831.44037-4-apokusinski01@gmail.com>
 <20260731190522.C11D41F00AC4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260731190522.C11D41F00AC4@smtp.kernel.org>

On Fri, Jul 31, 2026 at 07:05:22PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] Returning IRQ_NONE without masking or clearing unhandled RTC interrupts can cause an interrupt storm on the shared IRQ line.
> --
> 
> --- Patch [3]: [PATCH v3 3/8] rtc: abx80x: properly handle shared IRQs ---
> commit e06155ed4aeb662277df57a2324e881c6d065e84
> Author: Antoni Pokusinski <apokusinski01@gmail.com>
> 
> rtc: abx80x: properly handle shared IRQs
> 
> This commit modifies the abx80x interrupt handler to only claim the IRQ and
> clear the status register if the alarm or watchdog flags are explicitly set.
> It aims to prevent claiming interrupts from other devices sharing the same
> IRQ line.
> 
> > diff --git a/drivers/rtc/rtc-abx80x.c b/drivers/rtc/rtc-abx80x.c
> > --- a/drivers/rtc/rtc-abx80x.c
> > +++ b/drivers/rtc/rtc-abx80x.c
> 
> [ ... ]
> 
> > @@ -266,27 +266,34 @@ static irqreturn_t abx80x_handle_irq(int irq, void *dev_id)
> 
> [ ... ]
> 
> > -	if (status & ABX8XX_STATUS_WDT)
> > +	if (status & ABX8XX_STATUS_WDT) {
> >  		dev_alert(&client->dev, "watchdog timeout interrupt.\n");
> > +		handled = IRQ_HANDLED;
> > +	}
> >  
> > -	i2c_smbus_write_byte_data(client, ABX8XX_REG_STATUS, 0);
> > +	if (handled == IRQ_HANDLED)
> > +		i2c_smbus_write_byte_data(client, ABX8XX_REG_STATUS,
> > +					  status & ~(ABX8XX_STATUS_AF | ABX8XX_STATUS_WDT));
> >  
> > -	return IRQ_HANDLED;
> > +	return handled;
> 
> [Severity: High]
> If the RTC hardware asserts an interrupt for a reason other than AF or WDT
> (for example, a timer or century interrupt left enabled by a bootloader),
> will this cause an interrupt storm?
> 
> Because handled remains IRQ_NONE, the handler skips the i2c_smbus_write_byte_data()
> call and returns IRQ_NONE without clearing the unhandled RTC status bits.
> 
> Since the unhandled RTC interrupt is never cleared, the IRQ line will remain
> asserted. This causes the kernel to immediately re-enter the handler until
> the spurious IRQ detector steps in and completely disables the shared IRQ line.
> 
> Could we check if the status register indicates the interrupt originated
> from this RTC, clear those bits, and return IRQ_HANDLED?
Ok so it turns out that neither the current nor the newly proposed interrupt
handling is correct.

The current approach is that we write 0 to REG_STATUS so we clear
e.g. the BL flag which prevents the userspace from detecting a low
battery. Also, IRQ_HANDLED is returned unconditionally which prevents
handling a potential interrupt from another shared device.

The new approach that I've added in this v3 is not ok neither
since (as sashiko points out) any interrupt other than AF or WDT may be
enabled e.g. by the bootloader and in this case we'd get an interrupt
storm.

In v4 I'll improve the new solution with explicitly disabling the
interrupts that are not used in the probe function. That is:
* disable EX1, EX2, Timer, BL interrupts in REG_IRQ
* disable "oscillator fail" and "autocalibration fail" interrupts in REG_OSC
> 
> >  }
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260731184831.44037-1-apokusinski01@gmail.com?part=3
