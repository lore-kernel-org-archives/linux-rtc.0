Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5D6C3ACF09;
	Wed, 25 Feb 2026 12:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772020976; cv=pass; b=Ehd79A5dbX++skq+KdGuIL+dqtQhn7dPaezt1z8pyV2DvTnJKuwvITj5ggH2tguQ4pymAdn6c9J5jnwaBjiu7cA9b7hLeixlPm68+GZFi0ITPO+z8pmzwrw41V3qDhsskR9uOJpq3MAQfAyGAybuYLAv00c2dklRHSbPkQ9d7IA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772020976; c=relaxed/simple;
	bh=pFySQZzI6I4KvcpNAB0tfMmhto9X1h0vL/C8Z7OeDG8=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=dE6tXj+qnH+0Bt5KgIQTFMc1d3VauDYC1x/P6eJPWIIBMYSblabRIfUXmUK2vy97Q5uXMMY/tB3ewyXadVPeuMb/ChbkLsm37mNpUD8zwm8b3f8zsfXFpy4FCLHz6yrCadaowN0rxaOxESE2QSdgc+V+UTldvQyLuwSr/RibwSY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pigmoral.tech; spf=pass smtp.mailfrom=pigmoral.tech; dkim=pass (1024-bit key) header.d=pigmoral.tech header.i=junhui.liu@pigmoral.tech header.b=k9FhMGUz; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pigmoral.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pigmoral.tech
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pigmoral.tech header.i=junhui.liu@pigmoral.tech header.b="k9FhMGUz"
ARC-Seal: i=1; a=rsa-sha256; t=1772020938; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=TNJv7kHvKUjGqmcwqmsA3x0Le/gXxWBaVPK9MVwLfT0THMVAbnnQafEgk4xL24tsUzOtwk5HHaO7z/S46vhBpb1zdwWLVPIMrGQpcUeBP29lrbkbUywNE9BJqL5Hd2FNpTvxF0nz23wenBDorGxfuwYEshJOxbVn+mh+ru9ski4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1772020938; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=IizUq26mU0IFus36KtptiQJycd4Ah24lnhNyzSKAepg=; 
	b=OCSRMenj1mEEe8LNXJ4se7RyUl8bq3NAXYRIYzTPesWb0vXEPNFzJAGKLYUT1NMPmZlLloEjQhlTlP2CjrKMUqI4zblo60nLKvGf5u1Qk6hVU/VpsAWQ6mzhb4g+H2xhGtbRlY2qJULoJMmyZHwx3ZJZEqiPT36/nqnKWaDkCCM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=pigmoral.tech;
	spf=pass  smtp.mailfrom=junhui.liu@pigmoral.tech;
	dmarc=pass header.from=<junhui.liu@pigmoral.tech>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1772020938;
	s=zmail; d=pigmoral.tech; i=junhui.liu@pigmoral.tech;
	h=Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Date:Message-Id:Message-Id:Cc:Cc:Subject:Subject:From:From:To:To:References:In-Reply-To:Reply-To;
	bh=IizUq26mU0IFus36KtptiQJycd4Ah24lnhNyzSKAepg=;
	b=k9FhMGUzjDF6Zv9rpTWG7kHQfLXoH3dpXC1A2r40o3ZV9uctEqbdPyvh4ZjlJm61
	XiS2C33j+JVBS8KJcrVPa1IAnBN/LojPSdNyOTuPC8LmkUYWJChQmOEdwQ6/YoHc7Ls
	Ggv2L55nMYeb7L2cx03R245+LsUb0Hx+5OBs7Ux0=
Received: by mx.zohomail.com with SMTPS id 177202093493336.86441168143767;
	Wed, 25 Feb 2026 04:02:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 25 Feb 2026 20:02:03 +0800
Message-Id: <DGO0ZQ827ZV8.4EO0ONZBR8CL@pigmoral.tech>
Cc: <linux-clk@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-sunxi@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
 <linux-rtc@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: Re: [PATCH 0/7] rtc: sun6i: Add support for Allwinner A733 SoC
From: "Junhui Liu" <junhui.liu@pigmoral.tech>
To: =?utf-8?q?Jernej_=C5=A0krabec?= <jernej.skrabec@gmail.com>, "Michael
 Turquette" <mturquette@baylibre.com>, "Stephen Boyd" <sboyd@kernel.org>,
 "Chen-Yu Tsai" <wens@kernel.org>, "Samuel Holland" <samuel@sholland.org>,
 "Alexandre Belloni" <alexandre.belloni@bootlin.com>, "Rob Herring"
 <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor
 Dooley" <conor+dt@kernel.org>, "Maxime Ripard" <mripard@kernel.org>,
 "Junhui Liu" <junhui.liu@pigmoral.tech>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260121-a733-rtc-v1-0-d359437f23a7@pigmoral.tech>
 <5061953.GXAFRqVoOG@jernej-laptop>
In-Reply-To: <5061953.GXAFRqVoOG@jernej-laptop>
X-ZohoMailClient: External

Hi Jernej,
Thanks for your review.

On Sun Feb 22, 2026 at 6:41 PM CST, Jernej =C5=A0krabec wrote:
> Hi!
>
> Dne sreda, 21. januar 2026 ob 11:59:06 Srednjeevropski standardni =C4=8Da=
s je Junhui Liu napisal(a):
>> Add support for the Allwinner A733 RTC and its internal Clock Control
>> Unit (CCU). Reuse the rtc-sun6i rtc driver while introducing a new
>> SoC-specific RTC CCU driver to handle the hardware's evolved clock
>> structure.
>>=20
>> To facilitate this addition and improve driver modularity, transition
>> the binding between the RTC and its internal CCU from direct
>> cross-subsystem function calls to the auxiliary bus. Also extract shared
>> IOSC and 32kHz clock logic into a standalone ccu_rtc module for reuse
>> across newer SoC generations.
>>=20
>> The A733 implementation supports hardware detection of three external
>> crystal frequencies (19.2MHz, 24MHz and 26MHz), which is represented in
>> the driver via read-only mux operations. Implement logic to derive a
>> normalized 32kHz reference from these DCXO sources using fixed
>> pre-dividers. Additionally, provide several new DCXO gate clocks for
>> peripherals, including SerDes, HDMI, and UFS.
>
> This work looks nice, but I have some questions/comments:
> - you're missing RTC SPI clock, which is needed for RTC, at least accordi=
ng
>   to vendor 5.15 DT. Could it be that this bit set by vendor U-Boot so yo=
u
>   missed it during testing? Manual says that it's disabled by default.

You're right! I tried disabling the RTC SPI clock in U-Boot and found
that the output of UART became garbled during booting kernel. I will add
it in the next version.

> - Vendor DT has strange RTC CCU phandles for UFS and HDMI. In first case
>   uses RTC wakeup and in second DCXO, which doesn't make any sense. Did y=
ou
>   do any experimentation with these clocks? It wouldn't be the first time
>   that either code or manual contained some kind of error.

Regarding UFS, I am still working on getting UFS functional on the
mainline kernel. I will investigate the actual relationship between the
RTC wakeup clock and UFS during this process.

As for HDMI, I believe it actually requires the hosc_hdmi_clk
(DCXO_HDMI_GATING in the manual) provided by the RTC module.

>
> Btw, switch last two patches. With current order during bisection you wou=
ld
> get a complaint that A733 RTC CCU driver is not present.

Okay, I will do it.

>
> Best regards,
> Jernej

--=20
Best regards,
Junhui Liu

