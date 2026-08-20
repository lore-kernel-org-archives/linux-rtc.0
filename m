Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA95B486629;
	Thu, 20 Aug 2026 21:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787261358; cv=none; b=XSYTghZV8JYb3XRf1WPblNcx1m5fmIzC0zn7Vmp5nU64ojAGoon7TD5wWiCuj6Rj4pG9jaXDBAaRGS3usrGg7j+zv+Yy70bzQyoLw6L4oG3qp+XHaMqA0o6vhkfyQDb8eTL3R6F87zKksjnrmQWqcDcZr4weN9rDfQbbWoirT7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787261358; c=relaxed/simple;
	bh=nToP8MbRyodpnrRnfHIqTKLw5JFil0/Z1otBRiKF/5I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KI0NsanDpbDm3WSXPga94MbvRF68kTpOyDmP8WXKjxewF/u5sXycvWeOQ8aq00AwNvVIDaHc5jFTjiWo4neLAv2qn3QL8Bjc1KmqAby620DxiXthFDgfxBZvXbVao0WhjvGe04adMdcEZDzBjpOGTBaiIW6A0Sr1LBwXIJNtFWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=f0e+3KfG; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="f0e+3KfG"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 16A341A171E;
	Thu, 20 Aug 2026 21:29:14 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id D62BC5FF59;
	Thu, 20 Aug 2026 21:29:13 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 605B011C76888;
	Thu, 20 Aug 2026 23:29:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1787261348; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=hqsLOQTWk90qEMSQoOVqPkHcFL6LQMglZju7qPgRnLM=;
	b=f0e+3KfGkvOGou5KTW4Lzwv4KUTnUf0B1+G8PBGCJskF3dqXKk7a4PT0wOliUNF4jonAef
	siwZFu248X2gQEoreSWBNBIJ+1cq4x56l98+2brDl3FDpY4Rs59NBuUgkHaQUccI0HxaIG
	JVh+UlWLQ4ma5b42ye7p8/6IghibHWiiLa4bWQ0B/0j4SXv305HQXvE2b+KrO/2mLnQ0Pr
	KW5+rMj3YPF68hU4Iy6bgXUA+qCTumQ2rgbrvIPgvW+UOAegjXoEfcNkV0rMLxeBfXdtHw
	GPV177kbDLC0LxQFsjkB/miQCkrvPgGggs+oPVuE8jwF2/DvQoZQ6KTNXJ8mGg==
Date: Thu, 20 Aug 2026 23:29:05 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Aaro Koskinen <aaro.koskinen@iki.fi>,
	Andreas Kemnade <andreas@kemnade.info>,
	Kevin Hilman <khilman@baylibre.com>,
	Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Keerthy <j-keerthy@ti.com>,
	Afzal Mohammed <afzal@ti.com>,
	Bhargav Joshi <j.bhargav.u@gmail.com>
Cc: linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org,
	goledhruva@gmail.com, m-chawdhry@ti.com, daniel.baluta@gmail.com,
	simona.toaca@nxp.com
Subject: Re: (subset) [PATCH v3 4/4] dt-bindings: rtc: ti,omap-rtc: Convert
 to DT schema
Message-ID: <178726066521.423710.8101825585816095804.b4-ty@b4>
References: <20260804-ti-omap-rtc-v3-4-ba3bbd8af570@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260804-ti-omap-rtc-v3-4-ba3bbd8af570@gmail.com>
X-Last-TLS-Session-Version: TLSv1.3

On Tue, 04 Aug 2026 22:35:08 +0530, Bhargav Joshi wrote:
> Convert the Texas Instruments OMAP Real Time Clock (RTC) binding from
> the legacy text format to the DT schema. Mark 'ti,hwmods' as deprecated
> as it is no longer used, it is kept to support legacy boards.

Applied, thanks!

[4/4] dt-bindings: rtc: ti,omap-rtc: Convert to DT schema
      https://git.kernel.org/abelloni/c/315d11a89147

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
