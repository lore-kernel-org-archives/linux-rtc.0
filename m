Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D279489861;
	Wed, 19 Aug 2026 16:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787157068; cv=none; b=n64ZGrprENwviHrYvvJRlp2WimfX57TlvPp2RtPoPZwUXKNyr+VfcfAP9GHgs8SrW6wGIPzdczZw+ZYLiVTCz1fjNU5lJrR/I2tuIYD1/bJjLXQrsbRM68PTqjLNUuvmmMgOk+kQqcrMym5tE3e5g0l9r1jBpPY9mNLD77mg+/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787157068; c=relaxed/simple;
	bh=0txmZV8iiHBOOkJij5435dAA6kDgVayGSw3zS0Bok0A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dh7ZZUWm/udVtVoQ6mjA+f9qnZwexBg5Osn32zkfiIScnajyve1XelNAzzk9QVe+PSfQkiD5DAcpYKJOE9x8utg6afapo7XZ6MITS/M45Mw8Ryt5RQJCow9sarqxbAlxnplYfDqlCScTMxEfEIdkVWHBX9rwPR3RmdXTevbuzzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=VjMxh10j; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="VjMxh10j"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 13AB91A173C;
	Wed, 19 Aug 2026 16:31:05 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id D775E5FF42;
	Wed, 19 Aug 2026 16:31:04 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C464011C7590D;
	Wed, 19 Aug 2026 18:30:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1787157060; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=BPnwmthWDwezdK/eAiPhQt/h8k4dkuoeyLoZ7qPq56s=;
	b=VjMxh10j1dJbIKWW8BCxfGOy2W0PopuHcb6o+FEsZyHb+IbzrDcgTgZaVMUvmCh8/Qkh4h
	Gjo7Bs1q126yO36bgFcIjzAugtu78e1bG4ZqsqSFYUFYe0f+anmb0O8Th+JecZTUGuL/U3
	rpo0hqJBCz9fUsJ/CSWzYrghsXOrQIBu94pSOg8NCicub2OSPIpax9FBZ1cWkno4Affzz+
	zVS+TMFU07Gkd2WIfipXj88gltYf/b27HmcL0lXWdOjw50TU3T+mDSR5REUFy11q6A8xkT
	GVlKiVK3O4akBAYYLfxpFkexTHpPxYFQqJtIiCm2OeFaYQP2tEXXXcpjE90qnw==
Date: Wed, 19 Aug 2026 18:30:59 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Michal Simek <michal.simek@amd.com>,
	Pengpeng Hou <pengpeng@iscas.ac.cn>
Cc: linux-rtc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rtc: zynqmp: Return optional clock lookup errors
Message-ID: <178715693834.130787.997883397079617124.b4-ty@b4>
References: <20260624055524.38522-1-pengpeng@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260624055524.38522-1-pengpeng@iscas.ac.cn>
X-Last-TLS-Session-Version: TLSv1.3

On Wed, 24 Jun 2026 13:55:24 +0800, Pengpeng Hou wrote:
> devm_clk_get_optional() returns NULL when the optional clock is absent,
> but returns an ERR_PTR when the clock provider lookup fails.  Probe
> currently keeps the ERR_PTR and then passes it to clk_get_rate().
> 
> Return the lookup error instead.  A truly absent optional clock still
> reaches the existing calibration fallback through clk_get_rate(NULL).
> 
> [...]

Applied, thanks!

[1/1] rtc: zynqmp: Return optional clock lookup errors
      https://git.kernel.org/abelloni/c/5904c4109554

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
