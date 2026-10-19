Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.171.202.116
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792441111;
	b=Cank5aIoRLQh4DQbCAhmNS18+o/i/8zsF6u0TeBxGRumAdIK3V/ce61735CsjhgcaalL
	 EX/5tmL71F1U36sXK9nO1meOdCWp4rFvWbePRCWsY7u8VaRbsYVqv1/d1gjV2qt6+v7zk
	 mvaHGgcINDWjFKZjadgJ02hdVQWc9E6DVewqZ8COthKIQ6FlpemtEXA3KkdrCvnV+CU1J
	 bjmY2QCewLUhC8GhzbNI/n2b2oRrJqOniVTWA32XHyibPtyGSsqUEo7B+hFQ9ysD78ido
	 +lcrc6V52cVr8zKvuxgTeUBlG069k7AAqsvAIt2dPBW4dE/hUtTMDTTDNkokbkFoKog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792441111;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Last-TLS-Session-Version;
	bh=MkqhDlCJTohBxctyl1gHARlF4BNJMbmsSdvBSP2tGiA=;
	b=dowGQc2uOn+hB9x4FF/fcr1SgtxEF1xEXglBr75kQuwTF5D2pJsMuUs+uIvkgLjKSt7w
	 jCfuw6R1ZiZpiDyG3JXGbZfQ7crkvqBMqGfYLobMP0b56ZQzPdBfpZPvv4t2WLBChMWoV
	 1PrqU8Id5S/gNAKkyjmXBmCZG7NX4J3PTOHYtT9weq6v3RPzkW9UNkRN3eqMfKBPUSF0M
	 3TbuTO4GTl0TWp5OKifOkFZIoF6XcDa6H/LKobvP2NIgOmtSzql2lWr+PUJ3MIngkWToa
	 Qej8P0/d/bhsQuc/NnNuYqj+hgwLZQgVtKzqSbNcTEIAKJIcuK9ILWH+m7J/kVc9bYg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=Q9uQgvZn;
	arc=none smtp.remote-ip=185.171.202.116
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47F86606A31A
	for <linux-rtc@vger.kernel.org>; Mon, 19 Oct 2026 20:18:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 47F86606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=Q9uQgvZn
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id BAD67C5CD5C;
	Mon, 19 Oct 2026 20:19:25 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 63C5760582;
	Mon, 19 Oct 2026 20:18:27 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 170C510328D6E;
	Mon, 19 Oct 2026 22:18:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1792441102; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=MkqhDlCJTohBxctyl1gHARlF4BNJMbmsSdvBSP2tGiA=;
	b=Q9uQgvZn/cxWkImLYfGBZjJd1bVc8WGEP/o5eoVhw0fj53CBIKpDpXEoox6TbxCWAhSiN0
	gBjRNK+r7WFw9pF2xCE3JVepca/vAXtqWBkvyDZtKQkqqkQjpxIkub7rknPkBUR+rAK89z
	FQWYX2Z0Ah7lXl3IwC2W4w9F0AGZ7nbWO8IodobEBKiYQTonj+gOcBp2luy+raI0OYfmci
	Z8DCehzF4xKAbmvfmvaVJ5shUVgktRZT9PVMlGq4z358d1VRE1/VvUhN/pWvojzjLQ5I2R
	1SN+uuKSMuAy5POls0ZBsepVEwbj3HSqrHDmNR7RPO9eHjxKWdurkoMRCAlMmw==
Date: Mon, 19 Oct 2026 22:18:21 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: linux-rtc@vger.kernel.org,
	Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH 0/3] selftest: rtc: rtctest: improve handling of skipped
 tests
Message-ID: <179244109231.106899.15231964260310763850.b4-ty@b4>
References: <20260916213108.9234-5-wsa+renesas@sang-engineering.com>
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260916213108.9234-5-wsa+renesas@sang-engineering.com>
X-Last-TLS-Session-Version: TLSv1.3

On Wed, 16 Sep 2026 23:31:08 +0200, Wolfram Sang wrote:
> Here are some fixes for issues I found in 'rtctest' while checking RTC
> drivers. Details are in the patch descriptions. Patches 1+2 have been
> tested on HW. Patch 3 has not been tested, just follows the pattern of
> patch 2, but may need more discussion in general. Please read there.
> Looking forward to comments!
> 
> 
> [...]

Applied, thanks!

[1/3] selftest: rtc: rtctest: don't mention skipping twice
      https://git.kernel.org/abelloni/c/ec55c6e9c5cf
[2/3] selftest: rtc: rtctest: make missing UIEs really skip
      https://git.kernel.org/abelloni/c/7980352c78f5
[3/3] selftest: rtc: rtctest: skip properly if setting alarm fails
      https://git.kernel.org/abelloni/c/bd55831c0bfc

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
