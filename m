Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 064A6347FC4;
	Fri,  3 Apr 2026 16:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775232554; cv=none; b=fMOqQPpluhAw7JuS6+H/jNf78sroApEUdY+54N1n+40JBzHWL/lXeJ+GnYZPWEXy/vguatbRWMVrkFG4O0+HncXtXDrkiHXY4KlCi0pQfrbSLph5zqaFxLekaseGgCZ27BLOejmTDW25KmSgFjnNfFdigKCCt8IS2D7iOz3dF1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775232554; c=relaxed/simple;
	bh=CghEAyURPKNDWNh1KF3hIuxOiGfdcuCeOXvU4p4PtB8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QfLw0Xzy73dhSpLC/IPRv5d8YoMp/7gptGpXyZuJ/5qtn4AjZyyG4CGvNxpD2cEHSCMWOtQzanLiH9MsExANURtLdBH5Un+RA3Qrv64R56wKa9zf+re+nwu4T20SKBcB2hDKA5LvXeOxdxdFRtKfHS4cqKmzUHfvwCYyUNJAOSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=L97T2VHG; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="L97T2VHG"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 932684E428D4;
	Fri,  3 Apr 2026 16:09:11 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 60FDA603C1;
	Fri,  3 Apr 2026 16:09:11 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id BEC96104500F6;
	Fri,  3 Apr 2026 18:09:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1775232549; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=AzjEQefN6xPDjXEYIiHo2SUJdWU1/vP2x5cFXraZjkk=;
	b=L97T2VHGtwNjfPaEhWyiSnZG6k7C48S4htZ3xdXMja4I35x1Vha2dpAMX0WNGYblzxbrUv
	w/aoNXMJkcAGsxHBGwMvC3v4AK9Us0ZAofbj1Jge/XAkKyW2WBLtAg7c7meeTov3m/kL37
	0CrL3m46nLSt5nrUBSgCoKk3+eRsC35eLXnauDPjPd+NzRjQe8faib+rb+JcFj482nTsHb
	3XncxjjRBpnDjNtz4yAKJu6tsmqEtJkodT5r8GkMTLIdOt2ARjdq1uvll/xIID23MOSaNo
	KuHxucXkddWY+UP1yY+7J186BSJZy4E1fhoGtY3cQDGv+ydRID09gV/+YIKJFA==
Date: Fri, 3 Apr 2026 18:09:00 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
	Saenz Julienne <nsaenz@kernel.org>, Lee Jones <lee@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Shree Ramamoorthy <s-ramamoorthy@ti.com>,
	Jerome Neanne <jerome.neanne@baylibre.com>,
	Paul Cercueil <paul@crapouillou.net>,
	Dmitry Osipenko <digetx@gmail.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Joseph Chen <chenjh@rock-chips.com>,
	Chris Zhong <zyw@rock-chips.com>,
	Zhang Qing <zhangqing@rock-chips.com>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Andreas Kemnade <andreas@kemnade.info>,
	Jonathan =?iso-8859-1?Q?Neusch=E4fer?= <j.neuschaefer@gmx.net>,
	Lubomir Rintel <lkundrak@v3.sk>, Julien Panis <jpanis@baylibre.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Alexander Kurz <akurz@blala.de>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	=?iso-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>,
	"Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-rtc@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: Re: (subset) [PATCH 05/15] dt-bindings: rtc: ingenic,rtc: Use
 generic power-controller schema
Message-ID: <177523251875.1559844.9690289848283345069.b4-ty@b4>
References: <20260316-power-controller-v1-5-92c80e5e1744@nxp.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260316-power-controller-v1-5-92c80e5e1744@nxp.com>
X-Last-TLS-Session-Version: TLSv1.3

On Mon, 16 Mar 2026 22:47:40 +0800, Peng Fan (OSS) wrote:
> Convert the binding to use the generic power-controller schema instead by
> referencing power-controller.yaml and removing the local
> `system-power-controller` property definition.

Applied, thanks!

[05/15] dt-bindings: rtc: ingenic,rtc: Use generic power-controller schema
        https://git.kernel.org/abelloni/c/0452290110cc

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
