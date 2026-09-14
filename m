Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C9F242122C
	for <linux-rtc@vger.kernel.org>; Mon, 14 Sep 2026 21:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789421313; cv=none; b=uDfBVapRRNHoI6KIsqtQJ7VzYYObqgrpkmuKLjl3954dFaTm2DrgovreMCQ9Ipiy+T/KuDouFiWuBzYC8l9oV0S0P9KuFR9n+HDQiU5n7hujAhg0ngclgN8tObIkQ0GNiGcFyjSths/ZMdEWQhaapgwa2C8YlC40IsTe25Ki8WM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789421313; c=relaxed/simple;
	bh=zj4WGTJjsYVxmkgNqdl+23LNcAOz9ns08BPXAa1BjLo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=A3U0XbwAfeDm0m50rGM7KDuF0QaHEiAeuLgsiowvUctBlTfcPqfLcBic2COwN+GstWQcCnzmVVk3BKjQNkCgGVB64mznwE7BOlms0Lc6gRPsRpdwCa/oG0i+D9WAlXzgZZnZhPKBD2VIHgS77/oYnv9+JL+e23v48/AJi2w6JB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MojN9BHj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MojN9BHj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A65031F000FF;
	Mon, 14 Sep 2026 21:28:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789421310;
	bh=tny8S7+hpRLCFBplV45rDwfhwwfs+mTzlpWPTRECK5o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MojN9BHjgC9nOEZUV9MEcprchl989NLQSjS6aJ24IWsXVMJqZe3mky4+4PRT1VCmD
	 tcxRZpRmq9Gc1+NauYt56KWhyjhEMAMP4vFqYQDT5DwTXHZtjbQ520xxCAo5tFTHak
	 hlMMxBUt75PLwn6sVEfSv063CyquZx632HXFyEd+nlYJdzKhAAPsvBLlF8sszj4DVE
	 IUll2NUnVjbB8giWVrEfHnO8sfx2N9095OREnXeL6PL7XCpVkpvsXN/loei/DHykBI
	 irGW1r0EF/VPtt+4Q97OyX2OU9G3XvK2GTt2Eqh0ERefOadYPptO5hehiw54ahR4EU
	 bpYINwX0j85xg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6/6] rtc: rzn1: add R-Car X5H support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Wolfram Sang" <wsa+renesas@sang-engineering.com>
Cc: "Alexandre Belloni" <alexandre.belloni@bootlin.com>, linux-rtc@vger.kernel.org, wsa+renesas@sang-engineering.com
In-Reply-To: <20260914211826.73727-14-wsa+renesas@sang-engineering.com>
References: <20260914211826.73727-8-wsa+renesas@sang-engineering.com>
 <20260914211826.73727-14-wsa+renesas@sang-engineering.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 21:28:30 +0000
Message-Id: <20260914212830.A65031F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] rzn1_rtc_probe() dynamically modifies the static global rzn1_rtc_o=
ps struct, which causes state corruption if the driver is unbound and rebou=
nd or if multiple device instances exist.

Pre-existing issues:
- [High] rzn1_rtc_set_offset() fails to clear the hardware offset when the =
requested offset is 0, leaving the previous offset stuck in hardware.
--

commit c04fb139b5ae435fea49907420111efaa4083c83
Author: Wolfram Sang <wsa+renesas@sang-engineering.com>

rtc: rzn1: add R-Car X5H support

This commit adds the compatible string for the Renesas R-Car X5H RTC to
the rzn1 driver.

> diff --git a/drivers/rtc/rtc-rzn1.c b/drivers/rtc/rtc-rzn1.c
> index 583ce12b052d9..5860ecef428a6 100644
> --- a/drivers/rtc/rtc-rzn1.c
> +++ b/drivers/rtc/rtc-rzn1.c
> @@ -527,6 +527,7 @@ static const struct rzn1_rtc_data rzn1_rtc_rzn1_data =
=3D {
> =20
>  static const struct of_device_id rzn1_rtc_of_match[] =3D {
>  	{ .compatible	=3D "renesas,r9a09g077-rtc", .data =3D &rzn1_rtc_rzt2h_da=
ta },
> +	{ .compatible	=3D "renesas,rcar-gen5-rtc", .data =3D &rzn1_rtc_rzt2h_da=
ta },

[Severity: High]
Does dynamically modifying the static global rzn1_rtc_ops struct in
rzn1_rtc_probe() cause a regression where state is corrupted if multiple
device instances exist or if the driver is unbound and rebound?

If a device with alarms is probed, the global struct is modified:

drivers/rtc/rtc-rzn1.c:rzn1_rtc_probe() {
    ...
    if (irq >=3D 0) {
        ...
        rzn1_rtc_ops.read_alarm =3D rzn1_rtc_read_alarm;
        rzn1_rtc_ops.set_alarm =3D rzn1_rtc_set_alarm;
        rzn1_rtc_ops.alarm_irq_enable =3D rzn1_rtc_alarm_irq_enable;
    }
    ...
}

If the driver is subsequently bound to a device without alarms (like R-Car
X5H, as introduced by this patch), the global struct incorrectly retains
the alarm callbacks. The RTC subsystem will then expose non-existent alarm
capabilities to userspace.

[Severity: High]
This is a pre-existing issue, but does rzn1_rtc_set_offset() fail to clear
the hardware offset when the requested offset is 0?

If a user configures a non-zero offset and subsequently attempts to clear
it by setting it to 0, the function exits before updating the hardware
register:

drivers/rtc/rtc-rzn1.c:rzn1_rtc_set_offset() {
    ...
    if (!steps)
        return 0;
    ...
    writel(subu, rtc->base + RZN1_RTC_SUBU);
    ...
}

This early return leaves the previous offset permanently active in hardware.

>  	{ .compatible	=3D "renesas,rzn1-rtc", .data =3D &rzn1_rtc_rzn1_data },
>  	{ /* sentinel */ }
>  };

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260914211826.7372=
7-8-wsa+renesas@sang-engineering.com?part=3D6
