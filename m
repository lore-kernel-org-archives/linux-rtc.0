Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30068367B84
	for <linux-rtc@vger.kernel.org>; Sun, 12 Jul 2026 17:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783878901; cv=pass; b=Mz1QeoFYGSPHWKeUTNL0/7mup/qumtycEICURf1SZOerAUl6BI5jRnrNFwhPpuBufCq/BJqY4ec+KgwKZFvnPBVfvnz1CxuiqhreELKknA84Tz6V++w3GUoOJBkP0MqwkklsGyPSgrqZo/v/p9O84jz5QMuBisMGbx1IqrEHlVc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783878901; c=relaxed/simple;
	bh=fc+IpUQ3nxL/5ehuQHd+IPjoUpneuBJkM4s9M0NB2Ag=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hHCutgiIEuVasKW5T/hHf2I7QPPGnu24jf+ujsCok8zOALWLkqtE4ahZd6v0oe42uIPlxEiFklbYtM9aQXb+AMjhq4MKpMD3nKzNd2reVap+SrR/+7kIfAtWdLx/8ztazMP9er4lF9tsHsKZO4sEEd15Jmx/CK9FlFFwNQBGXcg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xk9LW3Oz; arc=pass smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xk9LW3Oz"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2cacf197759so35657115ad.2
        for <linux-rtc@vger.kernel.org>; Sun, 12 Jul 2026 10:54:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783878898; cv=none;
        d=google.com; s=arc-20260327;
        b=GCw/y3QIsT4ciPk0MTAj4r+7Gdr9bQFwWc3MI4Oz/Tjo7sntt7jeFJkvx2o+J3Y/sA
         fv68q1QGqo6iuBf4Sghxw9937YNiQVg9YCBiWNS15GhdhbE+M2gydcz8dQmbfDCcQbC5
         zUtx1lqO2f06+T3Mi1FkqqG+iZ+a/ngxMiuvpTRcwSC+24YJ/QYTrk9/fArNHjMOwP11
         mImrHVeQgDuaYxBkCP4DUgjyK9pYdyr13n2JVGLlfetrSwDuFVbJPXNIFogmbPD0T3ap
         q8i2DvrJn3erDVKYbzH1bFyKNZm7QbtsgtsQPULCKOVnVr5xjhmkdoxi+POhDjgaX+WM
         rhfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=44M0iHbAGhfU0E5ExDjtW7aZAEv+cpa/Gl2E/ST/Kgo=;
        fh=1v0bXpVxsC2t0e8DaX8PlZbdIOpRXBw5liOeRXle7v0=;
        b=jmodxYMwmn6uCUX9rA41p9syyKTM8m+O/beGo7hRBPC9PvHdiIut13mTE1ogCV64Ey
         kbbiv/42OT6TQjqaFtuv1zayOtoti4lodxV78T7Ah3gc/oZ8ljgQW2f48jaZ7P/5xkOp
         mKk1WLKl9pmCXs5uiIYJ0PJaiYdUigrax6aDQ6eUGcG67Evqhqm4wqe2p9uW2BWiAIGz
         GYHkO3TdX8aW3697LUxXUyBB1R1q1posTnONsx/LMdMqhsA0iIaFi/HT5XywdJktw4uI
         zQn5hhNeTHReExxJkDfF3d1S74DI4T6FFGszaetv5QIuYOexA8p3HDkdziDQyab85duZ
         YWpw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783878898; x=1784483698; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=44M0iHbAGhfU0E5ExDjtW7aZAEv+cpa/Gl2E/ST/Kgo=;
        b=Xk9LW3OzvRruJ4VOuwqux1+NPk95JeqTGR466IFMnKnrJkBp17kHT1JkIBGVX0XUJO
         +zBeO+4M/Dab4Jzj2ODDxzOyudxoDFUoqLyMEteALSjk9zd/0g0Xh02DNn5IF3UZqyT6
         lm4X5AXiWqrPv8e84cHsgFq4UILDjmGZ5n/uRWjIZWbyhH1lRVOg347wI0k03Uqhi0S+
         QY7impInoaf0Yorchx32dYnwMbjXA5JkyotfDXJsrbBWb70mAuHXS9rTnSz4jRIhsNq+
         ALg0REAIuFX5519q7mupm+NajEBSI7sA5XvN0VYqVWbdXQ6mCasCz4mnsK61OCD9zYyY
         211A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783878898; x=1784483698;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=44M0iHbAGhfU0E5ExDjtW7aZAEv+cpa/Gl2E/ST/Kgo=;
        b=Khv/4kjC4GJwDZEZ7a2O3V9pBvlBfn3g6TQ5uYEicrCsE/bwT0jUuYv8b4I70Lq96/
         bi1ugQJ69NHDotHoLF/brmahTKcQvuZPXWniwCKLCsibPsoLfAmyi9QqrfZtGEhE8iYV
         JIPGeEoph1nw9sO0mzF6GQX4wXuIdUGj8NI1MKDpgpq7Kh1d3CHDCagWSCI1OwomXm6f
         TaoMS8HP1AAbqu2jhp44tKQdgsPZM4N7l/GVM9F7IpXneJVVt8+Z4jnCv2gQSKKe/kLq
         NU6ExU/Pp7p+3K2k8v4KWebY5w/MgISJNIso5MqQVxyhlMb5Z9L7vrvKhPdbKhJzK0GT
         11eQ==
X-Forwarded-Encrypted: i=1; AHgh+Ro0GTHNQfmcoN22pzrfJOiUHwRUbs6T/YUe9kBiQiB+wo4UGIIwITEP7IfLgGbgYur1PH6H7zq6BM0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5I8ASPgTOcJF1ZmiXogGccNdYK5sNxIjvzD/ozmIIByocBEMO
	i8bue1bBqBSdrzCTr/gph1Mubloug/NdTyZ1TXgqavIxs4EwrtQackORuOxTSDDVb7iKbdgcNoX
	qIRJK2xJtbP3pAjwZC9d20fNnq/+2wjUZHXDs
X-Gm-Gg: AfdE7cl0Ua4sFQSLgddhSWDy4btpXI4e5Ih3Pyvas3PleE9xJHII1h3Nkyd4Ju7SkoC
	mR/0ifLstTGhff+9xecPJZ4RMPFOn73Jr2sBDRCENRjtdYkuVCMUq9bZkJc6O8lS6pS4pdZs0bt
	Lqsm3aMkFog63Y027XzqNBEZBnnNai87H50Dm8V6i1lszqLzHaghr5dbFDWbhuXdVNgKUZ7m3w6
	eSFANDhtEi0BjPqOg31bpqx3aah8fcDu9PObeDO3gKYmqhLJ00ZDYSmh4Y/jhk2hdRVG2Dy180R
	C/Qn/2lkxqCELrmbVdYRuIQ5l70NR7EoZtDHxshK8w==
X-Received: by 2002:a17:903:2347:b0:2c9:e961:d256 with SMTP id
 d9443c01a7336-2ce9ec0f113mr59165295ad.27.1783878898518; Sun, 12 Jul 2026
 10:54:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1782909323.git.mazziesaccount@gmail.com>
 <043fc930caca4c436651e8fa77a1ae16a26d0a98.1782909323.git.mazziesaccount@gmail.com>
 <20260709104839.GG2045740@google.com>
In-Reply-To: <20260709104839.GG2045740@google.com>
From: Matti Vaittinen <mazziesaccount@gmail.com>
Date: Sun, 12 Jul 2026 20:54:47 +0300
X-Gm-Features: AVVi8CcL95qrnKnAwDam6L3CmPNXOQrdJCc5kyQJraLZys2_Y9aFOne1g2IfMvw
Message-ID: <CANhJrGPJDjxv9xqXs9ZQ37O12yvUoxGxmL6chtteb__RdLrTPw@mail.gmail.com>
Subject: Re: [PATCH 3/8] mfd: Support for ROHM BD73800 PMIC core
To: Lee Jones <lee@kernel.org>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>, 
	Matti Vaittinen <matti.vaittinen@linux.dev>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Brian Masney <bmasney@redhat.com>, Linus Walleij <linusw@kernel.org>, 
	Bartosz Golaszewski <brgl@kernel.org>, Alexandre Belloni <alexandre.belloni@bootlin.com>, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-rtc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

to 9.7.2026 klo 13.48 Lee Jones (lee@kernel.org) kirjoitti:
>
> /* Sashiko Automation: Reviewed (0 Findings) */
>
> On Wed, 01 Jul 2026, Matti Vaittinen wrote:
>
> > From: Matti Vaittinen <mazziesaccount@gmail.com>
> >
> > The BD73800 integrates regulators, ADC (intended for accumulating current /
> > voltage / power values), a real-time clock (RTC), clock gate and GPIOs.
> >
> > Add core support for ROHM BD73800 Power Management IC.
> >
> > Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> > ---
> >  drivers/mfd/Kconfig              |  15 +-
> >  drivers/mfd/rohm-bd71828.c       | 145 ++++++++++++++-
> >  include/linux/mfd/rohm-bd73800.h | 307 +++++++++++++++++++++++++++++++
> >  include/linux/mfd/rohm-generic.h |   1 +
> >  4 files changed, 461 insertions(+), 7 deletions(-)
> >  create mode 100644 include/linux/mfd/rohm-bd73800.h
> >

Thank you Lee for review. I agree with your suggestions. I'll re-spin
this probably at early August.

Yours.
    -- Matti

-- 

Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

Discuss - Estimate - Plan - Report and finally accomplish this:
void do_work(int time) __attribute__ ((const));
