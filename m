Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E02A7331EC7
	for <linux-rtc@vger.kernel.org>; Wed, 24 Jun 2026 21:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782335727; cv=none; b=Do7PaNpHaaHao6W9pa+NwaWqr5vwrzWBQ4NrVokxFVZnttUDJWoNqdnImVSRnjG7nlxqs0f1smN4/Fw72hMVAWKsknkb4VT9AhZIkaVI3xnq83LPxfkRXQjpNq1/VhE1SjVJJBW5twMTeusNqt/P6WbgbVJKKbOhA3SZhUBKUZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782335727; c=relaxed/simple;
	bh=9krXHaPwhou9Aqxkt4vYo8Le5jfsitsY0Sprh4O/VfU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aryZ92PTzCukrcvZvQVdpV7GM2GOOeEQic5Yu0Sim9Pe0Cidof/kvKBxKlDhhDPxHp794zquRQJKsDgNeIfmIaa3ucujeox1htnrnOXym+L/Siq6yMb9xsvY8uYz6atOBtmJNYMFfyVmNRwZq4kr5AtGfur98GdT406SADsvHtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=F2j0+oeu; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="F2j0+oeu"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 771124E40832
	for <linux-rtc@vger.kernel.org>; Wed, 24 Jun 2026 21:15:23 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 4BBA1601C5;
	Wed, 24 Jun 2026 21:15:23 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6AB00106C846B;
	Wed, 24 Jun 2026 23:15:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1782335722; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=k3ejKhmB2kOhTN1vD1eL04lk+wt4ptGBDv27OaS/Bd8=;
	b=F2j0+oeuX7iesInZv8w5Bb71quPhlnIDzfi9qhtO0a7wa2swo1GRX9rFJevmWi7qB/5kId
	U7CtCOJ7j83LpHpExWixjQromjDHjNyGeyflysr0g4vegDa06aC4FD+yCRy0+4js3ZfmrK
	mxQroJ6yw9CBGhofsD7IBpf42C1/4Gs694Thu6ZlRMgfpNJCxZ/ySTi6U0P5ywbdvn7E0b
	UAqy0s3PKtyTeTr+/Lup6z7garIHiC147Q7t78Z1rhsqcBolR/DRiqijQJreff26EwbMlo
	rc1kSOOgsf+VVhwFY6Jn75DAkPH08t8GNlflVZWOLkxBU7taftYeZ81fUzJHXw==
Date: Wed, 24 Jun 2026 23:15:22 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Antoni Pokusinski <apokusinski01@gmail.com>
Cc: marex@denx.de, linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rtc: abx80x: fix the RTC_VL_CLR clearing all status flags
Message-ID: <178233558790.1517260.15663775605496320868.b4-ty@b4>
References: <20260415160610.127155-2-apokusinski01@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260415160610.127155-2-apokusinski01@gmail.com>
X-Last-TLS-Session-Version: TLSv1.3

On Wed, 15 Apr 2026 18:06:11 +0200, Antoni Pokusinski wrote:
> The RTC_VL_CLR ioctl intends to clear only the battery low flag (BLF),
> however the current implementation writes 0 to the status register,
> clearing all status bits.
> 
> Fix this by writing back the masked status value so that only BLF is
> cleared, preserving other status flags.
> 
> [...]

Applied, thanks!

[1/1] rtc: abx80x: fix the RTC_VL_CLR clearing all status flags
      https://git.kernel.org/abelloni/c/419719c51425

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
