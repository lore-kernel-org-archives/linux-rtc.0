Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.171.202.116
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793627409;
	b=3OVXfqQBVOR7a/JCKWwnjE+nlvgQxxFoHEXnYWChihIpzxyW3xfT3cYJtwJ3PKLjEiwo
	 1AFmW1Ui/OzJuFBkbHGqROu/zgWmVi9sVxqYqFFJ3xT0GvuZ6VTfb6nyEflVpMWJKzPww
	 g5Tcu4/3HKJUtn7kRu9AZW3YqetVCRC7iRt+0+dDjSqtEukggdy0GyYaEt/t5u5KGB/cM
	 nG7ve8VQizhylqRpmxtDQ8LTeN65BVMqYaaYNFJkKuT7gzPcExKezHHUA4YxKqQqQIm2e
	 +oE/GER7xTYEn8+325aAOgCQUcTjcGacOkN1GrugIgRAdb8aNsvJB5hatnyHzJW2MLA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793627409;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:Date:From:To:
	 Cc:Subject:Message-ID:In-Reply-To:References:Organization:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Last-TLS-Session-Version;
	bh=wNStSjwISQyGeb1rd2HXoOipT3Bs+NI6BZQo3NWUbxo=;
	b=dQeX+vgwYD7ht5+p1JTiHbN3Vf3PB25LgkxsGbTGQTZpJS5GJ9GzjyfJYfv7iWx+KRdl
	 U4qN2mzVsBzHlEmr/q3IjgnN4Nkie3rvAdTAxHqlo49YS+e2zJHO59Hzpj9fjyPZjfYac
	 zI7or8zocWyAiZhUNx/qAkx+0KLC3HTBoepNSSpD/2eVC/IJ1VzgYmUdymrvxVwMAShpm
	 8h732sd8DpSsJlcZ6PcSAJF332LyyEyVHckkUEgrWGQjtw5JfPMPpK92pdOy6B9rl7rwY
	 g+EyOgpqZavgpD1V8mCjmXBupLXv2+dFGt58RWqUWsJq/ZAjK/+HMToVv9ZQAfH4s/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b="03/TbKoA";
	arc=none smtp.remote-ip=185.171.202.116
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A6B4606A324;
	Mon,  2 Nov 2026 13:50:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1A6B4606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=03/TbKoA
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 6F9F8C4FECD;
	Mon,  2 Nov 2026 13:51:09 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 4319760750;
	Mon,  2 Nov 2026 13:50:05 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3D9A0103290ED;
	Mon,  2 Nov 2026 14:49:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1793627400; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=wNStSjwISQyGeb1rd2HXoOipT3Bs+NI6BZQo3NWUbxo=;
	b=03/TbKoAdRJAMXmDAbJgqxpKq26zsvDoSauRdA/MM0boV8Lnu+vLOlVk+nxkQNzOzpFYgg
	UH7auEhvJ4laorPtdSdRLHMbavT5t3DtO0zwDWFdPJdWQfFu7lRpfOJAB4hXz0cbhmV8+8
	QvZYewdNe7L/tL/4lTxUJDZXtt0u0WE3ioft4SC9XtE2dFyrNJviGgPY57ntkB5c0mqoYG
	QBCiq4Q1D+mwjK+usYsFnqYKaZw7FlZKM4W7j0Jr3FkOQJ7pGtMGhTOVTiDLna/yd+uhIF
	qJBQmzaOFq2bPHTziQamNA6vfghBhAn5KTI9fbSaXIFI+TW0EzQiHa5PE774yA==
Date: Mon, 2 Nov 2026 14:49:56 +0100
From: Herve Codina <herve.codina@bootlin.com>
To: sashiko-bot@kernel.org
Cc: sashiko-reviews@lists.linux.dev, linux-rtc@vger.kernel.org,
 devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org,
 "Alexandre Belloni" <alexandre.belloni@bootlin.com>
Subject: Re: [PATCH 2/3] rtc: pcf2127: Add support for the clkout clock
Message-ID: <20261102144956.57f9bbf3@bootlin.com>
In-Reply-To: <sashiko-outbox-193475@kernel.org>
References: <20261102130712.25104-1-herve.codina@bootlin.com>
	<20261102130712.25104-3-herve.codina@bootlin.com>
	<sashiko-outbox-193475@kernel.org>
Organization: Bootlin
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

On Mon, 02 Nov 2026 13:13:46 +0000
sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] rtc: pcf2127: rate 0 in pcf2127_clkout_rate2cof() sets COF to HiZ
> --
> 
> commit fd3d38a37715a1ab67448b3adb80c6b0ee46a7e2
> Author: Herve Codina <herve.codina@bootlin.com>
> 
> rtc: pcf2127: Add support for the clkout clock
> 
> This commit adds common clock framework support for the CLKOUT output clock
> on PCF2127, PCF2129, PCA2129, and PCF2131 RTC devices, allowing configuration
> of frequencies from 1 Hz to 32768 Hz and disabling the output into HiZ.
> 
> > diff --git a/drivers/rtc/rtc-pcf2127.c b/drivers/rtc/rtc-pcf2127.c
> > index ff2023908f5a3..2c442770ebc52 100644
> > --- a/drivers/rtc/rtc-pcf2127.c
> > +++ b/drivers/rtc/rtc-pcf2127.c  
> 
> [ ... ]
> 
> > @@ -626,6 +634,180 @@ static int pcf2127_watchdog_init(struct device *dev, struct pcf2127 *pcf2127)
> >  	return devm_watchdog_register_device(dev, &pcf2127->wdd);
> >  }
> >  
> > +#ifdef CONFIG_COMMON_CLK
> > +#define clkout_hw_to_pcf2127(_hw) container_of(_hw, struct pcf2127, clkout_hw)
> > +
> > +/* Rates indexed by COF values */
> > +static int pcf2127_clkout_rates[] = {
> > +	32768,
> > +	16384,
> > +	8192,
> > +	4096,
> > +	2048,
> > +	1024,
> > +	1,
> > +	0, /* 0Hz (COF 0b111) will put the clockout signal to HiZ */
> > +};
> > +
> > +static u32 pcf2127_clkout_rate2cof(unsigned long rate)
> > +{
> > +	unsigned int i;
> > +
> > +	for (i = 0; i < ARRAY_SIZE(pcf2127_clkout_rates); i++) {
> > +		if (pcf2127_clkout_rates[i] <= rate)
> > +			return i;
> > +	}
> > +
> > +	return 0; /* Maximum output clock rate */
> > +}
> > +
> > +static int pcf2127_clkout_cof2rate(u32 cof)
> > +{
> > +	return pcf2127_clkout_rates[cof];
> > +}
> > +
> > +static unsigned long pcf2127_clkout_recalc_rate(struct clk_hw *hw,
> > +						unsigned long parent_rate)
> > +{
> > +	struct pcf2127 *pcf2127 = clkout_hw_to_pcf2127(hw);
> > +
> > +	return pcf2127_clkout_cof2rate(pcf2127->clkout_cof);
> > +}
> > +
> > +static int pcf2127_clkout_determine_rate(struct clk_hw *hw,
> > +					 struct clk_rate_request *req)
> > +{
> > +	u32 cof;
> > +
> > +	cof = pcf2127_clkout_rate2cof(req->rate);
> > +	req->rate = pcf2127_clkout_cof2rate(cof);
> > +
> > +	return 0;
> > +}
> > +
> > +static int pcf2127_clkout_set_rate(struct clk_hw *hw, unsigned long rate,
> > +				   unsigned long parent_rate)
> > +{
> > +	struct pcf2127 *pcf2127 = clkout_hw_to_pcf2127(hw);
> > +	u32 cof;
> > +	int ret;
> > +
> > +	cof = pcf2127_clkout_rate2cof(rate);
> > +
> > +	/*
> > +	 * Setting COF will enable the clock (i.e. output not in HiZ anymore)
> > +	 * Perform the operation only if already enabled.
> > +	 * Otherwise, do nothing. The expected COF will be set on prepare()
> > +	 */
> > +	if (pcf2127->clkout_enabled) {
> > +		ret = regmap_update_bits(pcf2127->regmap, pcf2127->cfg->reg_clkout,
> > +					 PCF2127_CLKOUT_COF,
> > +					 FIELD_PREP(PCF2127_CLKOUT_COF, cof));
> > +		if (ret)
> > +			return ret;
> > +	}
> > +
> > +	pcf2127->clkout_cof = cof;
> > +	return 0;
> > +}  
> 
> [Severity: Medium]
> Since rate is an unsigned long and pcf2127_clkout_rates[7] is 0, the condition
> pcf2127_clkout_rates[i] <= rate in pcf2127_clkout_rate2cof() will always match
> at index 7 (PCF2127_CLKOUT_COF_HIZ) when rate is 0, making the fallback
> return 0 unreachable.
> 
> If a consumer passes rate == 0 to pcf2127_clkout_determine_rate() or
> pcf2127_clkout_set_rate(), pcf2127_clkout_rate2cof(0) returns 7
> (PCF2127_CLKOUT_COF_HIZ). In pcf2127_clkout_set_rate(), this writes
> PCF2127_CLKOUT_COF_HIZ to reg_clkout if pcf2127->clkout_enabled is true
> (putting the CLKOUT pin into HiZ while pcf2127->clkout_enabled remains true),
> and caches PCF2127_CLKOUT_COF_HIZ in pcf2127->clkout_cof so subsequent calls
> to pcf2127_clkout_prepare() -> pcf2127_clkout_control(hw, true) will also
> leave the pin in HiZ.

This is exactly what it is expected.

return 0 is unreachable but pcf2127_clkout_rate2cof() returns a u32.

Without the last return 0 (even if unreachable) or any other u32 returned value,
GCC obviously complied
   error: control reaches end of non-void function

> 
> Should the 0 entry be removed from pcf2127_clkout_rates[] (or skipped in
> pcf2127_clkout_rate2cof()) so that pcf2127->clkout_cof only ever holds active
> clock divider values (0..6)?
> 

No.

All rates should be present in pcf2127_clkout_rates[]. The 0Hz rate value is
a valid rate even if the pin will be set in HiZ in that case.

pcf2127->clkout_cof should hold the value related to OHz rate.

A user can ask a 0Hz rate and call clk_prepare(). This is a valid use case.

Best regards,
Hervé
