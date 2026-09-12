Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A0A729B799;
	Sat, 12 Sep 2026 07:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.251.229.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789199309; cv=none; b=IRiPFi5/iMzTHskolpBl8h1smf1lhJVpZSoVz4m1qn74LY0kRADm7v6wxN9/VwtvJq8eiqXmodubyjJTIqUTMZppG2oVoyYvfhnQqQ8ratIITNUQl/BA45s9kUOfDHo7n2/GBNt1Y0PscFoZdn/jypQ2N6RpYJvvXi+L7rbJU2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789199309; c=relaxed/simple;
	bh=A7L0tDKFmrvl30pQk6RU8/YxA2ciMANb9L3sNLliSog=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RxABpFozEByq7dWQwosT6yuyxtT2w8i8bajHxDdBbvgPaIUTJ59Pqv3o+EzKkGoVs94/fCrJi0j5rgzDLlpeYiQT2TlRyfmdaj7T3nBSKrJlUqILCgPt0fNe3P6rqs85TWA3lF50+9CSvZ0UKBK0J4jWuNQlrIZW1YaWMnnvqdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com; spf=pass smtp.mailfrom=nabladev.com; dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b=ElveQm2y; arc=none smtp.client-ip=178.251.229.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b="ElveQm2y"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id AB363103602;
	Sat, 12 Sep 2026 09:42:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1789198927;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=QWa1IkWKPTCdseDREpcvpcw4PGH+ZbLXJHyJCDrt8b8=;
	b=ElveQm2yVIihXNcaF17U19GIAdSa/BiVaRE03FrRG7IXfCOWQfK6vFOSI7feuIlpsuT29k
	jlC+E2IQfjomVP/VslABgEAOBeWtCEjlQs+T+fnPM/mJdiBLWOjh7v4NVeQXdldJzmFqso
	jRpvpN8kcMNRpRBla9B+kjcGk7nROg9lDWgEU9iGkc178f2FppAqjlJdkvroPHa2VwF+W5
	eGyXHcna9jfROEzYvxUQAep97fpJkJ3kNYVjMBoJtqMsis08Oc5gdqZ6Tw1BYlZTZHrcoo
	XzBKQBibCYOqz3xM3jq8YmvfmyNMz9HUGFKBhcS0AAe+p1zhK0qM5a+m8GG1ng==
Message-ID: <ef8a31e2-dd1e-f37d-7747-e4fe0db4c7cb@nabladev.com>
Date: Sat, 12 Sep 2026 09:41:13 +0200
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v2 0/3] rtc: rs5c372: add Ricoh R2223x support
Content-Language: en-US
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-kernel@vger.kernel.org,
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
 Rob Herring <robh@kernel.org>, linux-rtc@vger.kernel.org
References: <20260825071927.4090460-1-hs@nabladev.com>
From: Heiko Schocher <hs@nabladev.com>
In-Reply-To: <20260825071927.4090460-1-hs@nabladev.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Hi All,

On 25.08.26 09:19, Heiko Schocher wrote:
> The Ricoh R2223x is an I2C RTC from the same family as the r2025sd and
> r2221tl which the rtc-rs5c372 already supports. It shares the R2x2x
> control register layout, so only the new type must be added to the driver.
> 
> The ricoh R2223x drives a clock output and offers an eco mode that
> lowers its current consumption while running from the backup supply.
> 
> The trivial-rtc binding does not cover this, so give the device its
> own binding in patch 1. Patch 2 adds the R2223x to the rs5c372 rtc
> driver, and patch 3 implements the eco-mode setting.
> 
> v2 answers the sashiko review of v1 and a local run of the same review
> prompts. This resulted in 2 changes:
> 
> Patch 2 now handles the new type in rs5c372_ioctl(), where RTC_VL_READ
> read CTRL2 bit 4 as XSTP although the R2x2x parts have PON there and
> RTC_VL_CLR did nothing at all, and in the two offset helpers, where the
> R2223x fell back to the coarse trim resolution.
> 
> Patch 3 now applies the device tree setting in both directions. V1 only
> set the eco bit before, so a board that dropped the property kept running
> in eco mode, because CTRL2 is backed by the backup supply.
> 
> Not touched sashiko reviews (some from local run):
> 
> - #clock-cells stays out of the required list. Requiring it would
>    reject every node that does not use the clock output; the other
>    discrete I2C RTC bindings with a clock output keep it optional too.
>    Also the clock output can be disabled per hardware pin CLKC. So
>    #clock-cells is optional.
> 
>    https://sashiko.dev/#/patchset/20260824110452.4038870-1-hs@nabladev.com?part=1
> 
> - additionalProperties: false together with $ref: rtc.yaml# means the
>    properties from rtc.yaml are not allowed here unless they are listed.
>    Only start-year is, the others can be added once a board needs them.
>    microcrystal,rv3032.yaml is built the same way.
> 
> - ricoh,eco-mode is a vendor boolean. Whether the RTC may run in eco
>    mode depends on the backup cell the board is fitted with, so it
>    describes the board and not a runtime policy.
> 
> Changes in v2:
> - Added Reviewed-by from Conor, no code change in patch 1
> - Fixed the sashiko review of v1: handle the new type in
>    rs5c372_ioctl(), rs5c372_read_offset() and rs5c372_set_offset()
>    https://sashiko.dev/#/patchset/20260824110452.4038870-1-hs@nabladev.com?part=2
> - Added sashiko review for patch 3 in this patch, as it fits better here
>    https://sashiko.dev/#/patchset/20260824110452.4038870-1-hs@nabladev.com?part=3
> - Fixed results of a local run of the sashiko review prompts: apply the
>    device tree setting in both directions. v1 only set the eco bit, so
>    the mode stayed on when a board dropped the property.
> - Leave rs5c372_probe() through goto exit like its other error paths,
>    instead of returning directly.
> 
> Heiko Schocher (3):
>    dt-bindings: rtc: add ricoh,r2223x binding
>    rtc: rs5c372: add support for Ricoh R2223x
>    rtc: rs5c372: support eco mode on R2223x
> 
>   .../devicetree/bindings/rtc/ricoh,r2223x.yaml | 58 +++++++++++++++++++
>   drivers/rtc/rtc-rs5c372.c                     | 52 ++++++++++++++++-
>   2 files changed, 107 insertions(+), 3 deletions(-)
>   create mode 100644 Documentation/devicetree/bindings/rtc/ricoh,r2223x.yaml
> 
> ---
> base-commit: 2709dd5ae32f0828f386327c76bba9f39f63a1c6
> 

gentle ping.

Any comments to this series?

Thanks!

bye,
Heiko
-- 
Nabla Software Engineering
HRB 40522 Augsburg
Phone: +49 821 45592596
E-Mail: office@nabladev.com
Geschäftsführer : Stefano Babic
