Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2727024468C
	for <linux-rtc@vger.kernel.org>; Tue, 28 Jul 2026 00:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785200082; cv=none; b=pxmYUSFnMZdt1VvWYMun7PvSELqpAngYu82phFIntQ+a1iL88h68C+7PUGWp48LAfkMiaHHjOQiq+/rcdWnVkxr0KAz3c6ujQo7t29JQ5TFBktHwk3z4br5H5mIe71GIA5hpGCbQM6PvCPJak5fbkvmsh0zj8BHYiakHIloc1Sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785200082; c=relaxed/simple;
	bh=xLVe0Cv5GPVuA0AJiXi2FkChdUYarJGz2fbbb9ffEfE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lHfgZIJ5f2ianaJzVSVQfxkp+gEe0wJX+mzAiBylxGH7ofNZh+v7I0OUVwaGLEtnuuBdivGZV6xE9omYnXG1F1myrLup6h57pMmCxyL4nKz11WqOfKKJhD1fMrAKo/cTu5wSOGwRUENj7v+Kxk1IO1k7b3AA3N03Ggz3bcv6K6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mu1WMimR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mu1WMimR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 513E21F000E9;
	Tue, 28 Jul 2026 00:54:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785200079;
	bh=xLVe0Cv5GPVuA0AJiXi2FkChdUYarJGz2fbbb9ffEfE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Mu1WMimRFEg6xuGz1SLdJHpHfzLhNmaY7WkuqwavPODqqI1wkl9eV5tw0vF3ec2WY
	 nKeyF9hQNR3QKwhU6nuHzVEaV1Ul/byUAPSlLYDpJ3Kfz3lfqlAaKGnOOP4b38BhoS
	 8ZL4e2AZOwMf2vmKua7be2EyIBYlwmWHubms15aoQHjNejoFmIKtYSqAjgiiE0ES34
	 JUl3oPuVSToln1XkyHaW/v6z0O2pqE+E59bp5cO+yQ/B039SR2zCRUIHfNS5mJGuFt
	 kUBl9NDHDOa7/leOWFke+4qN8DsSH0zMMQo7hXMlhqwnqCy0NX6z4TiVhSRnr9YO/V
	 jxks334adru4Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] rtc: mpc5121: convert from irq_of_parse_and_map to
 platform_get_irq
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rosen Penev" <rosenp@gmail.com>
Cc: linux-rtc@vger.kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20260728004519.573980-1-rosenp@gmail.com>
References: <20260728004519.573980-1-rosenp@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Jul 2026 00:54:38 +0000
Message-Id: <20260728005439.513E21F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Devm LIFO ordering causes a potential Use-After-Free of `rtc->rtc`=
 during probe failure or device removal.
--

--- Patch [1]: [PATCH] rtc: mpc5121: convert from irq_of_parse_and_map to p=
latform_get_irq ---
[Note: The standard review format has been altered to a free-form summary d=
ue to recitation restrictions. No code diffs are quoted.]

commit 67266c7661895f337b8df1626c97434560227e94
Author: Rosen Penev <rosenp@gmail.com>

rtc: mpc5121: convert from irq_of_parse_and_map to platform_get_irq

This commit converts the driver to use platform_get_irq instead of
irq_of_parse_and_map, removing the need for explicit irq_dispose_mapping
calls during teardown.

[Severity: High]
This is a pre-existing issue, but does the ordering of devres allocations
create a use-after-free hazard during teardown?

In mpc5121_rtc_probe(), devm_request_irq() is called before
devm_rtc_allocate_device(). Because the devres framework tears down resourc=
es
in LIFO order, during a probe failure or device removal, the RTC device
structure will be freed before the IRQ is unregistered and synchronized.

While mpc5121_rtc_remove() disables hardware interrupts, it does not wait f=
or
currently executing handlers to finish. If an in-flight interrupt on another
CPU executes mpc5121_rtc_handler() during this teardown window, it will
access the already freed rtc->rtc pointer.

Could the IRQ requests be moved after the RTC device allocation to ensure t=
he
IRQ handler is properly unregistered and synchronized before the RTC device
is freed?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260728004519.5739=
80-1-rosenp@gmail.com?part=3D1
