Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795430895;
	b=z3ObFYRcZ/3xQbx9XPsVJPP0YoZx2QZJd/Si4kXYEAeR0i5QhZzAXqOpw0FQK93oC8fj
	 fs+mhM/RxZOS2jee4cRVj1ZVcbfnVKq+Hc5NxkmAfELA12D9GmWwnmj0+DqC+nrp39yau
	 N9oZAkbpsupyAcCYqo/JgoA+VCT5QF65fXwOK08s1zWx6+WvUbBJ4RHHU9hDznKC2jHUt
	 C7Uh+GyAtyQZ/YhkDi/DDVDdXSRwcugYoluIv0cC5wRIDL3M39st2DPbowA+uwKfmSLDf
	 7TQ1b/QSmWch2tjVFwoaMydXVxXUwn3LRJBTBgSWyW8H/bCWU0WcOp9pnniXqPVCNiw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795430895;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=8tMXBNHyUHHfUggSCwq/LV8i3JWEVeKo4tKMHJBx7DQ=;
	b=duQq653melXXyHWoDS/6jpjrs2iNFRviP/naN1iMEIWCGKm2xA02zbnXSdQsPoO5frZG
	 5xrP5FWi47eR2s3hCl4o8WzfdrV9DG3Clrn3hHZwbGeL62bcvZpBak69oUDyiQ6t1684L
	 drnT8FKLXLTkXHUw/z1QeARTDrRkAKBeq97CpoYrTAJAkKFg5ZTkVvcrRX/K9zt86emvG
	 qMwlhATmb0yrXJapqnqEnuRuVoOxylcGEYglH4PWvaE5ZK7PWdoamgMwrakHiWh1AmX2y
	 4FYAK7bEHly+r8DlvJOLLkziUWLrY8fQ3EUP0YsETgHenXHqU/BQptYvYo2J2OPkIoA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F5ijIkK3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BBB8606A339;
	Mon, 23 Nov 2026 10:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F5ijIkK3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E53FE1F0093C;
	Mon, 23 Nov 2026 10:48:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795430894;
	bh=8tMXBNHyUHHfUggSCwq/LV8i3JWEVeKo4tKMHJBx7DQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=F5ijIkK3qmhTNAbyoDXS3+JKuB540448nfPqbiEzlHCJrpXwFadSY+79HtYMLG2hq
	 +4jt3eX5cWzHbPFRwlezbVbAnwpkpoYll421fXLUUIPdQT/D2vrbGJi4BXhZ0sdlMr
	 nqxq4kTzKP7/B9hUGMz7Tg+gAVrG4WMaA38iSFgla7CnZo/eAmBKWavTEqw+0qboL3
	 t2JmEMJD7fpWHWo5r5BByuQn8SDuDRhdvkkC4wsXxdR1raN/dUVnZELLTHV4JPPgVf
	 S/lTehUZ+k+uGhS9CUE9h/rjJp9eo8+8DcwrEcTzTW9rMXiW74PerA5KOMMDjc5KUm
	 E6W9hJYr1XHaA==
Date: Mon, 23 Nov 2026 11:48:11 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Igor Velkov <iav@iav.lv>
Cc: John Stultz <jstultz@google.com>, Thomas Gleixner <tglx@kernel.org>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Kevin Hilman <khilman@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Miroslav Lichvar <mlichvar@redhat.com>, 
	Jerome Brunet <jbrunet@baylibre.com>, Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
	linux-rtc@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 6/8] dt-bindings: rtc: Add linux,wakeup-states
Message-ID: <20261123-literate-significant-wildcat-dcfffa@quoll>
References: <20261116-b4-alarmtimer-rtc-priority-v2-0-b2c69721e489@iav.lv>
 <20261116-b4-alarmtimer-rtc-priority-v2-6-b2c69721e489@iav.lv>
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261116-b4-alarmtimer-rtc-priority-v2-6-b2c69721e489@iav.lv>

On Mon, Nov 16, 2026 at 12:25:05AM +0000, Igor Velkov wrote:
> A board can have more than one RTC with an alarm that wakes the system,
> for example an I2C RTC next to an RTC in the PMIC or the SoC firmware.
> Which of them wakes the system depends on the sleep state and on the
> board's firmware: amlogic,meson-vrtc is a register the firmware reads
> when the application processors suspend, so it wakes the system from
> deep sleep only, and whether an I2C RTC wakes the system from deep
> sleep depends on the firmware handling its interrupt line.
> 
> Add linux,wakeup-states to describe this per RTC: the suspend states an
> alarm of the RTC wakes the system from, named as in /sys/power/mem_sleep,
> or none for an RTC whose alarm wakes the system from no suspend state.
> 
> List it in nxp,pcf8563.yaml and amlogic,meson-vrtc.yaml, which do not
> allow unlisted properties.
> 
> Signed-off-by: Igor Velkov <iav@iav.lv>
> ---
>  .../devicetree/bindings/rtc/amlogic,meson-vrtc.yaml     |  2 ++
>  Documentation/devicetree/bindings/rtc/nxp,pcf8563.yaml  |  2 ++
>  Documentation/devicetree/bindings/rtc/rtc.yaml          | 17 +++++++++++++++++
>  3 files changed, 21 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/rtc/amlogic,meson-vrtc.yaml b/Documentation/devicetree/bindings/rtc/amlogic,meson-vrtc.yaml
> index a89865fa676a..51cce4b2a7ff 100644
> --- a/Documentation/devicetree/bindings/rtc/amlogic,meson-vrtc.yaml
> +++ b/Documentation/devicetree/bindings/rtc/amlogic,meson-vrtc.yaml
> @@ -30,6 +30,8 @@ properties:
>    reg:
>      maxItems: 1
>  
> +  linux,wakeup-states: true
> +
>  required:
>    - compatible
>    - reg
> diff --git a/Documentation/devicetree/bindings/rtc/nxp,pcf8563.yaml b/Documentation/devicetree/bindings/rtc/nxp,pcf8563.yaml
> index 22909a96123e..e464432e4690 100644
> --- a/Documentation/devicetree/bindings/rtc/nxp,pcf8563.yaml
> +++ b/Documentation/devicetree/bindings/rtc/nxp,pcf8563.yaml
> @@ -32,6 +32,8 @@ properties:
>    interrupts:
>      maxItems: 1
>  
> +  linux,wakeup-states: true
> +
>    start-year: true
>    wakeup-source: true
>  
> diff --git a/Documentation/devicetree/bindings/rtc/rtc.yaml b/Documentation/devicetree/bindings/rtc/rtc.yaml
> index e46d50b1063e..54f41858dda4 100644
> --- a/Documentation/devicetree/bindings/rtc/rtc.yaml
> +++ b/Documentation/devicetree/bindings/rtc/rtc.yaml
> @@ -26,6 +26,23 @@ properties:
>        0: not chargeable
>        1: chargeable
>  
> +  linux,wakeup-states:
> +    $ref: /schemas/types.yaml#/definitions/string-array

This looks exactly like re-implementing system-idle-states.yaml and wakeup-source.

Best regards,
Krzysztof

