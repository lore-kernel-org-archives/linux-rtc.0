Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5EC225B31D;
	Thu, 12 Mar 2026 14:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773325008; cv=none; b=s1NGqk2YUjJRZlc9c0YkC49sqjWMEeUfHD16tdodT6VZTrj6R3XVv2QsHrxN1SsJAJ1whxc7eEmEkzsWIdIYIKTG7ZBn2hHVl0zDs+SPfzpkT5dScKRMcOoF5VnHdRlWEbpsAE5VHf8+glhfQ/JxrI5499YpNRqhSlh4zkkygvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773325008; c=relaxed/simple;
	bh=X9OpT2Jm5LVVzdcQkyEw9surqLtuizIEgPvMrHF07is=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ck+INonVQndRju5d1Vr4g8gnj2aG5KAD7hTaO2B++WjeErZq23h3AXBV5CQp1fMSMz07Jj/cee1sloq+L8O3cRwvi2dYPgfSXCDl8FyEnzyjDUk0eeyopWl7PqHLr1Rlt9MbGiFgP3hl8HHnpa8XZ8ozD0tGBMau7DVmXVQFS3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=XEId114I; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="XEId114I"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 30E274E42652;
	Thu, 12 Mar 2026 14:16:37 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 074065FDEB;
	Thu, 12 Mar 2026 14:16:37 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id F1BFA10369D6C;
	Thu, 12 Mar 2026 15:16:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1773324996; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=rvqFpuRmMeRSVsyErmI4FWCcb/A5LGkWQeN9ctAGa+M=;
	b=XEId114I91C7MRE1cM77C86oJQlEFH63MTwnkfHzUSd3zKFVaLw2Tz3b/e6n1+Araa8/yN
	3S2herzQbbZlZLU0duB6D/UfTxA/ksAeIkb70adHyLCaGNHzhs8s9PHGMmexd3zanF+Ub5
	Nd6V2mr39SzTkZlUpSFDYXDf4uk8AdnYONg08Nbdc3qYH62PAj9yWCZLhGyawoSwCxJPYa
	VHMbsO954TROA89BBuSi/DLSGM5Jac7t+/XsA6CLdBK+OmRDg5NcLkqUGKpKcLiJGhR90N
	IeFR1jph7xPse6AagCuadUrZxPSsNt8AGq5AozqF+Ar2Gnml3q8gjUXMgR/qCg==
Date: Thu, 12 Mar 2026 15:16:34 +0100
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Andrew Davis <afd@ti.com>
Cc: linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/6] Remove use of i2c_match_id in RTC
Message-ID: <177332498955.2620233.12619720306532028803.b4-ty@bootlin.com>
References: <20260305193545.796294-1-afd@ti.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260305193545.796294-1-afd@ti.com>
X-Last-TLS-Session-Version: TLSv1.3

On Thu, 05 Mar 2026 13:35:39 -0600, Andrew Davis wrote:
> RTC subsystem is one of the last still using i2c_match_id().
> This is a v2 but nothing is changed from last time. If I'm
> not sending this to the right folks let me know.
> 
> Thanks,
> Andrew
> 
> [...]

Applied, thanks!

[1/6] rtc: abx80x: Remove use of i2c_match_id()
      https://git.kernel.org/abelloni/c/652dc1328110
[2/6] rtc: m41t80: Remove use of i2c_match_id()
      https://git.kernel.org/abelloni/c/aade5f4bf9e2
[3/6] rtc: pcf2127: Remove use of i2c_match_id()
      https://git.kernel.org/abelloni/c/c85ac0b4d7c5
[4/6] rtc: rs5c372: Remove use of i2c_match_id()
      https://git.kernel.org/abelloni/c/022bfe69575d
[5/6] rtc: rv8803: Remove use of i2c_match_id()
      https://git.kernel.org/abelloni/c/c79e6131b17e
[6/6] rtc: rx8025: Remove use of i2c_match_id()
      https://git.kernel.org/abelloni/c/fbae853a00b4

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
