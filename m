Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80EED43B6EA;
	Fri, 24 Jul 2026 21:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784927313; cv=none; b=XQM5+8JUUSaCNaUZ5GfhezVUqrTZxfoHq25HOlNUuz/rTHYnf4rMLg5mb9OCQVTZEpI9vG4Ts7YV+1/2RgOTXuK+tM9B534jU/s2cWKibfWFl3AbisD1guJIixZPv0mkXXWG4Q26P2YvOxt7HDHRycKOzCcViBeRmpg7VfZbBmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784927313; c=relaxed/simple;
	bh=r38CSkXMhc7JzTstBXGvkIsZq0oVoI+AirSFK5TNxWQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LI5DSUE8kaJM/mesRS220/BUcZyK/H67Yml8LwC07+CrGFAqjVlYoSUeEho0lcIEkehVdvZa5dmQsylRwplbEgNdmgNiSz9LAQN9uNSkk4uKZFyCGtsViXSewh1tukRMsK726Ob0GjTrMxZqEMDGjmv4KMiinF1noB5o3sP49vQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oTVLeyQY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oTVLeyQY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC1171F000E9;
	Fri, 24 Jul 2026 21:08:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784927307;
	bh=cdqdwvdWkIPPXx4+Y4PQ6RW4FvkOPbE3GX7mHC/v/hQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oTVLeyQYgdTdyK/0VsGzYDdNrhZBwbNzoxhE+PdyIZpSInLCeIysrD4nVG6DMYauo
	 OUXmYOGrKjh4WbE4P63Yi4w+vY63RqxZ0mijK3pu8Fs1YdJ3qy1g94GEIWUoNnKQCD
	 gIVaSJteueqkyeYl1/NhX1Oi2MA0+8YjTqhziZS+QcNlhtxmAMN194uZWs8X/XSfx2
	 T17vch4cNboLv1bP5e+k/+QR62Ujvl1nB63Vqa9rrO/KHpvok3S/CXArx8OcoPTFo6
	 hA9MJvkqrosST9pjpNO6kDEyZHpVzF9p5wWFgAVPHM+sRZ9wtNw7/eyBhS4DEOJGex
	 VUjLDRsT5kysg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/3] dt-bindings: rtc: ti,omap-rtc: Convert to DT
 schema
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bhargav Joshi" <j.bhargav.u@gmail.com>
Cc: linux-rtc@vger.kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>, conor+dt@kernel.org, devicetree@vger.kernel.org, robh@kernel.org
In-Reply-To: <20260725-ti-omap-rtc-v2-3-13f765ca96b3@gmail.com>
References: <20260725-ti-omap-rtc-v2-0-13f765ca96b3@gmail.com>
 <20260725-ti-omap-rtc-v2-3-13f765ca96b3@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Jul 2026 21:08:26 +0000
Message-Id: <20260724210826.EC1171F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Missing phandle label in the YAML example causing a dtc compilation=
 error.
--

--- Patch [3]: [PATCH v2 3/3] dt-bindings: rtc: ti,omap-rtc: Convert to DT =
schema ---
commit 0cee4f860a851104188182b49417909d1f275491
Author: Bhargav Joshi <j.bhargav.u@gmail.com>

dt-bindings: rtc: ti,omap-rtc: Convert to DT schema

Convert the Texas Instruments OMAP Real Time Clock (RTC) binding from the
legacy text format to the DT schema. It also marks 'ti,hwmods' as deprecated
since it is no longer used.

> diff --git a/Documentation/devicetree/bindings/rtc/ti,omap-rtc.yaml b/Doc=
umentation/devicetree/bindings/rtc/ti,omap-rtc.yaml
> new file mode 100644
> index 0000000000000..326d5ad972922
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/rtc/ti,omap-rtc.yaml

[ ... ]

> +  - |
> +    rtc@0 {
> +        compatible =3D "ti,am3352-rtc", "ti,da830-rtc";
> +        reg =3D <0x0 0x1000>;
> +        interrupts =3D <75>, <76>;
> +        system-power-controller;
> +        clocks =3D <&clk_32k_rtc>, <&clk_32768_ck>;
> +        clock-names =3D "ext-clk", "int-clk";
> +
> +        pinctrl-0 =3D <&ext_wakeup>;
> +        pinctrl-names =3D "default";
> +
> +        ext-wakeup {

[Severity: Low]
Will this cause a dtc compilation error during make dt_binding_check?=20

The pinctrl-0 property above references <&ext_wakeup>, but it appears the=20
label "ext_wakeup:" was dropped from this child node during the conversion=
=20
from the text binding.

> +            pins =3D "ext_wakeup0";
> +            input-enable;
> +            ti,active-high;
> +        };
> +    };

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260725-ti-omap-rt=
c-v2-0-13f765ca96b3@gmail.com?part=3D3
