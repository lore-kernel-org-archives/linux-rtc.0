Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794789296;
	b=eiFtfTsfX1pB/UQZAeSzNkhPs1SyLeif7ewQuWU+MS3mHsDmr2kJ8cNehF5NwhWilkBZ
	 7w3llNmF8FsuxGta/XyXcssjlgOcBHZFiXM09X+a/tVdzoZMz8OeP1mexItxr1tiWyKxW
	 X4WC+ePqmRBCK9dG11UrLdbaRWYwRGy6JCRrIwFeOEdSHTzkEz/MbkZo2imB3b2x/ANIM
	 8bobRHUb5emxZq6xxcY0IcgZrXVXgXneu+nx7/sYZwBgwc0sJPIqTw6Puk6cf/F0verWB
	 Fewzw0eRvs17WOLpQmtMXJRjbb8Kc5Qtx0SEpnBwurJI4qrW8E836euCNWvKSxTBqRQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794789296;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ZQ5s77pt7WuhcJMDWqyrTloAIFM7HridzheIVDA1k58=;
	b=OPH4dSti3l9cBmNdWZYoQhzZCnhw2nAhVJm+cKmyGn396gvpsb/FbHQdYKqVuFqj29LE
	 FTg7TK9ug2hC7okbyM9KHxAPUWIVBAQftg/tYNsuHgUYgcf7uu09OJyIygOp73121uFgX
	 6QC4tcQcJiFB8w2Am415nFArrb3t120imiT0S8DOYW/kGkhQBq77gh2oEzZgPTTR8p+q1
	 GtXvlBOfRyq4RtRyoagyRKxOLtIHaaX+guz3g554KSS7xGHIEdCCUWy6DFJHBX0beEuL/
	 jLKisSd1ragDrU9WmJCwV136qT0VWAA7nMef+jzCoaNe0J04R0KSd1MJjy3+KUQygfg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nJwZzzTy;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D062E606A329;
	Mon, 16 Nov 2026 00:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nJwZzzTy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 508C31F000C4;
	Mon, 16 Nov 2026 00:34:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794789296;
	bh=ZQ5s77pt7WuhcJMDWqyrTloAIFM7HridzheIVDA1k58=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nJwZzzTyNB66BirWxEE1oKdQIhm54SYu6xYMbQlMdJ3NBYiE03VdBGWwxDpGJ5yJM
	 2r6DPGz262tpLViy4FmOg1esO04NCuu7s2kPCmGpRR/woVF5Z8ZuB4ICBOY7T0UnWn
	 ZZKOc+tDEcFFKH9+sHtk//sjIG8oRHop/PRcMknD70B3OiCJvS9tNt0+DED0BGr6Kt
	 HR8qitmtH87475dH4RgWfTwWoKWSHoz2hs4N4b2m2GF3IJJZf9dWM7RY4Bi8MsGqS4
	 9DNBZC35yiYA8lnon7jO+R1kcHHnDBAk83AVg7uNwH/qeGAhmjR47e1fhQgORznl6V
	 HybfHQAyU/hFQ==
Message-ID: <sashiko-outbox-215957@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 6/8] dt-bindings: rtc: Add linux,wakeup-states
Reply-To: sashiko-reviews@lists.linux.dev
To: "Igor Velkov" <iav@iav.lv>
Cc: linux-rtc@vger.kernel.org, devicetree@vger.kernel.org, linux-amlogic@lists.infradead.org, robh@kernel.org, conor+dt@kernel.org, neil.armstrong@linaro.org, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20261116-b4-alarmtimer-rtc-priority-v2-6-b2c69721e489@iav.lv>
References: <20261116-b4-alarmtimer-rtc-priority-v2-0-b2c69721e489@iav.lv>
 <20261116-b4-alarmtimer-rtc-priority-v2-6-b2c69721e489@iav.lv>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 00:34:55 +0000
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] dt-bindings: rtc: OS-specific mem_sleep states in
  linux,wakeup-states
--

commit 37e39721822efb2f3ac3e76aaec271ff0edbe18b
Author: Igor Velkov <iav@iav.lv>

dt-bindings: rtc: Add linux,wakeup-states

This commit adds a linux,wakeup-states property to the generic RTC binding
schema to specify which suspend states an RTC alarm can wake the system
from, and allows the property in the Amlogic Meson VRTC and NXP PCF8563
bindings.

> diff --git a/Documentation/devicetree/bindings/rtc/amlogic,meson-vrtc.yam=
l b/Documentation/devicetree/bindings/rtc/amlogic,meson-vrtc.yaml
> index a89865fa676a6..51cce4b2a7ff3 100644
> --- a/Documentation/devicetree/bindings/rtc/amlogic,meson-vrtc.yaml
> +++ b/Documentation/devicetree/bindings/rtc/amlogic,meson-vrtc.yaml
> @@ -30,6 +30,8 @@ properties:
>    reg:
>      maxItems: 1
> =20
> +  linux,wakeup-states: true
> +
>  required:
>    - compatible
>    - reg
> diff --git a/Documentation/devicetree/bindings/rtc/nxp,pcf8563.yaml b/Doc=
umentation/devicetree/bindings/rtc/nxp,pcf8563.yaml
> index 22909a96123e5..e464432e4690f 100644
> --- a/Documentation/devicetree/bindings/rtc/nxp,pcf8563.yaml
> +++ b/Documentation/devicetree/bindings/rtc/nxp,pcf8563.yaml
> @@ -32,6 +32,8 @@ properties:
>    interrupts:
>      maxItems: 1
> =20
> +  linux,wakeup-states: true
> +
>    start-year: true
>    wakeup-source: true
> =20
> diff --git a/Documentation/devicetree/bindings/rtc/rtc.yaml b/Documentati=
on/devicetree/bindings/rtc/rtc.yaml
> index e46d50b1063e4..54f41858dda47 100644
> --- a/Documentation/devicetree/bindings/rtc/rtc.yaml
> +++ b/Documentation/devicetree/bindings/rtc/rtc.yaml
> @@ -26,6 +26,23 @@ properties:
>        0: not chargeable
>        1: chargeable
> =20
> +  linux,wakeup-states:
> +    $ref: /schemas/types.yaml#/definitions/string-array
> +    description:
> +      Suspend states an alarm of this RTC wakes the system from, given
> +      the board and its firmware, named as in /sys/power/mem_sleep. none,
> +      given alone, means the alarm wakes the system from no suspend
> +      state. An RTC without this property is taken to wake the system
> +      from every suspend state.
> +    oneOf:
> +      - items:
> +          enum:
> +            - s2idle
> +            - shallow
> +            - deep
> +      - items:
> +          - const: none
> +
>    quartz-load-femtofarads:
>      description:
>        The capacitive load of the quartz(x-tal), expressed in femto

[Severity: Medium]
Does linux,wakeup-states encode Linux-specific /sys/power/mem_sleep labels
and information already deducible from the hardware description into the
Devicetree ABI?

In particular, s2idle is a Linux software freeze state where wakeup
capability is determined by whether the RTC has an OS interrupt wired via
interrupts, rather than a list of sysfs state names. For
amlogic,meson-vrtc, waking the system only from platform suspend is
inherent to the compatible string because the device is a scratch register
written during meson_vrtc_suspend() for the SCP firmware and has no OS
interrupt line. Finally, allowing none duplicates the absence of the
standard wakeup-source property and permits contradictory combinations such
as setting both wakeup-source and linux,wakeup-states =3D "none" on the same
node.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116-b4-alarmti=
mer-rtc-priority-v2-0-b2c69721e489@iav.lv?part=3D6
