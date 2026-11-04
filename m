Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793772361;
	b=E3qGEjdlH1E95SwnMMzb46LtGggNgFc3XFeMd0aOgu58dQRYddrmJpqac5011OGofIzS
	 CJjVqKG2NMT2FIdPf3NqS8laY3PiiVVvkDla/2HGLXo+UOoDNHMMY025bYiA1zk92zw6n
	 6/gEFFdIU50XEh1D9kwwH9bilZGjgukxO84s3FMOE/txLIgQonMW/q0F0WDI5KcR593dM
	 TRw+lQRIEXb+Lr6UOhwqlsvNqwBIOjWQJ9CaV7EIhfM1ThhhpRMbg8UI4snQZWfh5/TBn
	 jyr7fxZeKqLUFGgw6Q9yX82g4wubjbUfevsVcXkWoHfmE8UnoFsjM1MWUhUhrei4t6A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793772361;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=L3n36mnOsqyiV4KZF52bEPsThE+j4Itg7nle1oUa4HY=;
	b=focj+V0Ivh+xUvIlWPgODkso2PHVGZJ09vE4vFmr58p18hJdytmOthcZ1V7JYClf53iX
	 a6TwfwAQZ0kwgDzarKw+7ph0qqzDel6kOMt82WHNtR/pU8S68FZso6G35YAwutt6hh0g/
	 L64gxfnrFmzfHyUjFMDTnP1DZ95f48zQ0FGPt86G25HfBy56CxUcAUnHAl57qLQJx9ZMn
	 PjX7bfeKlFnLnvKWYc+9MCDymBqMfZL3JKtd3SMUec/XI65nIf4UM0c+TN3mDNO/qvgOb
	 RRJUut7twJk9xMztFJtSP77vWvD6cSZ3U5B4bZ+09lCh7HxPqOKkstlZZe0HKMgEgNQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nnlfF5vK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A7B0606A328;
	Wed,  4 Nov 2026 06:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nnlfF5vK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9D181F000C1;
	Wed,  4 Nov 2026 06:06:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793772361;
	bh=L3n36mnOsqyiV4KZF52bEPsThE+j4Itg7nle1oUa4HY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nnlfF5vK4yGCIGVLlOoVGdVlZG+yCdwRWcmM7L9uY/E7EcZCuDRZtLKdFKXS4kuae
	 32OCmy48roaEkqyeTamP1JTx9mpxaDXfLUxd8Z88NYlciiZk6qq8DPtQ4i6Y0uucJ6
	 8GLOlOtUK9c79P1fOCWi8CBi9yGalB/xUweUofbT9t9eoY4tOXPXCSKKZUuKOJbM3E
	 5LRdWyfIYBuBFeXw7DhgQSENCEPS8XpaQLGdr0w/O7cgdScQs5KbLF+yvCoWPo1JUF
	 x5G4sf9hrCfshlGvx5bmHVjuappLcaT1WMIjMncQos73Ha0qxz+O3hSd40XSNePosk
	 dp2BfXtllRiJQ==
Message-ID: <sashiko-outbox-196725@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 1/3] dt-bindings: rtc: Add linux,wakeup-states and
 linux,alarmtimer-priority
Reply-To: sashiko-reviews@lists.linux.dev
To: "Igor Velkov" <iav@iav.lv>
Cc: linux-rtc@vger.kernel.org, devicetree@vger.kernel.org, linux-amlogic@lists.infradead.org, robh@kernel.org, conor+dt@kernel.org, neil.armstrong@linaro.org, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20261104-b4-alarmtimer-rtc-priority-v1-1-e996681b8086@iav.lv>
References: <20261104-b4-alarmtimer-rtc-priority-v1-0-e996681b8086@iav.lv>
 <20261104-b4-alarmtimer-rtc-priority-v1-1-e996681b8086@iav.lv>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 06:06:00 +0000
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] dt-bindings: rtc: OS-specific alarmtimer policy and sleep states=
 in DT
--

commit dc818a3fb414914888d04f5807458bc227693b0c
Author: Igor Velkov <iav@iav.lv>

dt-bindings: rtc: Add linux,wakeup-states and linux,alarmtimer-priority

This commit adds the linux,wakeup-states and linux,alarmtimer-priority
properties to the common RTC Devicetree binding schema to describe per-RTC
sleep-state wakeup capabilities and alarmtimer selection weights, and allows
them in the amlogic,meson-vrtc and nxp,pcf8563 bindings.

> diff --git a/Documentation/devicetree/bindings/rtc/amlogic,meson-vrtc.yam=
l b/Documentation/devicetree/bindings/rtc/amlogic,meson-vrtc.yaml
> index a89865fa676a6..bc4a1916f6007 100644
> --- a/Documentation/devicetree/bindings/rtc/amlogic,meson-vrtc.yaml
> +++ b/Documentation/devicetree/bindings/rtc/amlogic,meson-vrtc.yaml
> @@ -30,6 +30,9 @@ properties:
>    reg:
>      maxItems: 1
> =20
> +  linux,alarmtimer-priority: true
> +  linux,wakeup-states: true
> +
>  required:
>    - compatible
>    - reg
> diff --git a/Documentation/devicetree/bindings/rtc/nxp,pcf8563.yaml b/Doc=
umentation/devicetree/bindings/rtc/nxp,pcf8563.yaml
> index 22909a96123e5..5aabeb074c82b 100644
> --- a/Documentation/devicetree/bindings/rtc/nxp,pcf8563.yaml
> +++ b/Documentation/devicetree/bindings/rtc/nxp,pcf8563.yaml
> @@ -32,6 +32,9 @@ properties:
>    interrupts:
>      maxItems: 1
> =20
> +  linux,alarmtimer-priority: true
> +  linux,wakeup-states: true
> +
>    start-year: true
>    wakeup-source: true
> =20
> diff --git a/Documentation/devicetree/bindings/rtc/rtc.yaml b/Documentati=
on/devicetree/bindings/rtc/rtc.yaml
> index efb66df82782f..3b4b8ff90ada0 100644
> --- a/Documentation/devicetree/bindings/rtc/rtc.yaml
> +++ b/Documentation/devicetree/bindings/rtc/rtc.yaml
> @@ -26,6 +26,35 @@ properties:
>        0: not chargeable
>        1: chargeable
> =20
> +  linux,alarmtimer-priority:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      Weight of this RTC for waking the system on alarmtimer alarms.
> +      Among the RTCs that can wake the system from the target sleep
> +      state, the one with the highest value is used; on a tie, the
> +      operating system decides. An RTC without this property has
> +      priority 0.
> +
> +  linux,wakeup-states:
> +    $ref: /schemas/types.yaml#/definitions/string-array
> +    description:
> +      System sleep states an alarm of this RTC wakes the system from,
> +      given the board and its firmware. s2idle, shallow and deep are the
> +      states of /sys/power/mem_sleep, hibernate is suspend-to-disk and
> +      off is the powered-off system, and none, given alone, means the
> +      alarm wakes the system from no state. An RTC without this property
> +      is taken to wake the system from every state.
> +    oneOf:
> +      - items:
> +          enum:
> +            - s2idle
> +            - shallow
> +            - deep
> +            - hibernate
> +            - "off"
> +      - items:
> +          - const: none

[Severity: Medium]
Should OS-specific alarmtimer policy weights and Linux /sys/power/mem_sleep
labels be encoded in the Devicetree binding rather than derived by the OS f=
rom
hardware properties and compatible strings?

Documentation/devicetree/bindings/writing-bindings.rst notes that bindings
should describe hardware rather than Linux or device driver specifics, and
should not add properties that are already implied by or deducible from the
compatible string.

For linux,alarmtimer-priority, this encodes an arbitrary numeric weight for
the Linux kernel alarmtimer subsystem (kernel/time/alarmtimer.c) into the DT
ABI. Could the kernel instead select the preferred wakeup RTC using hardware
characteristics already known to the RTC drivers (for example, alarm
resolution such as RTC_FEATURE_ALARM_RES_MINUTE in drivers/rtc/rtc-pcf8563.c
versus 1-second resolution, or alarm range), userspace policy, or standard =
DT
/aliases (rtc0, rtc1)?

For linux,wakeup-states, several of the state definitions appear to conflict
with hardware description or existing properties in rtc.yaml:

1. In Documentation/devicetree/bindings/rtc/amlogic,meson-vrtc.yaml, waking
the system only when the application processors suspend is inherent to the
hardware and firmware interface (a scratch register read by the SCP upon
platform suspend, as implemented in drivers/rtc/rtc-meson-vrtc.c), which is
already deducible from compatible =3D "amlogic,meson-vrtc" without a new DT
property.

2. The values s2idle, shallow, and deep are Linux sysfs labels from
/sys/power/mem_sleep rather than hardware properties. In particular, s2idle=
 is
a pure Linux software freeze state where any enabled OS interrupt wakes the
system, whereas an RTC without an interrupts property wired to the kernel
cannot wake the system from s2idle. Similarly, on non-ACPI Devicetree
platforms, hibernate uses power-off rather than a distinct hardware sleep
state, and whether an RTC can wake the system from platform suspend or
power-off is determined by interrupt/wakeup routing and power domain or PMIC
wiring.

3. How does linux,wakeup-states interact with the existing wakeup-source
property in Documentation/devicetree/bindings/rtc/rtc.yaml? Specifying
linux,wakeup-states =3D "none" duplicates the absence of wakeup-source and
allows contradictory combinations such as setting both wakeup-source and
linux,wakeup-states =3D "none" in nxp,pcf8563.yaml. Conversely, stating tha=
t an
RTC without linux,wakeup-states wakes the system from every state (including
hibernate and off) overstates the capability of standard RTCs that cannot w=
ake
a powered-off system.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104-b4-alarmti=
mer-rtc-priority-v1-0-e996681b8086@iav.lv?part=3D1
