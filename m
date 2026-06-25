Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87B933E172E;
	Thu, 25 Jun 2026 12:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782391433; cv=none; b=HZsFAg7c756SlH3AZOMOxF804e19eolJjZkcf1s8EeALJDiFta6XvngMw9cyA289o0Y//6zuvJDP7cADam+Hhwt0oIwAJTtgkQKe9zPH/Bck3iZKhcjessI0VJZooa1FxNdbvxzu0CbTKoax2fwV3R8qllB+GRe4YKEDK7W/jKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782391433; c=relaxed/simple;
	bh=7Ht0CHhlya6/viuKJgJ+qOX9L4qYHbHXPYw+ZSlYgjs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I8iVUXGuuEk07IENR64De3hMNlXHj3CScd0V3lCVbWXB1o+LTHr/MxhDaiwwyYJjjsaqJp3qH8lamyyhT/FJNwIfCZMUVxXbVLX+x/MyZOw6Fu/7VXyz5kPScUR0DWKIVKGWRwxVE8Uzqhe99JTwrX2xtS2Ju8vtA2B79nBkIko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=NAuZKHz5; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="NAuZKHz5"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id E28271A09A8;
	Thu, 25 Jun 2026 12:43:42 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id B53945FF03;
	Thu, 25 Jun 2026 12:43:42 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 48F29104C973C;
	Thu, 25 Jun 2026 14:43:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1782391422; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=tuVo9EOR9f+Ioh0VbmHAcwroaayMdh8xeHIayvllSUU=;
	b=NAuZKHz5XphfLMtNUvm8EFcxIHNTZnJNimDsy2xs/DIYqqV/rONXteJySUvock05Frakp7
	x/rB3/+wmyFKST2/ljz9g94fThO7Apm36Ne1lCWbGDNInnOeHhEXvY7GW0c7ZenTvLtqZH
	M69kcgIPmvb3q9FGjiEo2k6+lx8f35mhVHCnmeTPdqGz/lpDBBLVeVBCc0DtbSZDAsjlh1
	OX/BPCa6DK6b99zkXumZS2Vt2EVhoiH1COFHWj+/7IbC2U+F9Gxj7AiobJTcTjqGYE42U0
	8Gd6Lkdie3tb76t5CFwsDlmPlOWtgpCAiODYC3UKshBJIjtqu+1NC70hMAmTAw==
Date: Thu, 25 Jun 2026 14:43:39 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>
Cc: Hans de Goede <hansg@kernel.org>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-rtc@vger.kernel.org, Thomas Gleixner <tglx@kernel.org>
Subject: Re: (subset) [PATCH v2 0/2] Fix S0i3 wakeup with alarmtimer
Message-ID: <178239140188.1613320.1695497134037536107.b4-ty@b4>
References: <20260521043714.1022930-1-mario.limonciello@amd.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260521043714.1022930-1-mario.limonciello@amd.com>
X-Last-TLS-Session-Version: TLSv1.3

On Wed, 20 May 2026 23:37:12 -0500, Mario Limonciello wrote:
> It was reported that suspend-then-hibernate stopped working with modern
> systemd versions on AMD Cezanne systems. The reason for this breakage
> was because systemd switched to using alarmtimer instead of the wakealarm
> sysfs file.
> 
> But really it uncovered deeper problems with how these timers work.  Adjust
> the code accordingly.
> 
> [...]

Applied, thanks!

[2/2] platform/x86: amd-pmc: Fix S0i3 wakeup with alarmtimer
      https://git.kernel.org/abelloni/c/f7ecfc3fe575

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
