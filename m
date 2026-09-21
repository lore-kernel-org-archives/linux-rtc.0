Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65B513A7F58;
	Mon, 21 Sep 2026 19:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790019095; cv=none; b=IZC77O4YLI6PHK/wwystgBrmhSS1n2xiexDGgq1YdereXrysS8LWZpJ0+EIhfge36fRb8eeFXRmzBDUD9sZ0eZxwcET32z3kGiroeo3YlL0fUrC6YBenJ22dHQ0KJr9Jvb2Fxv/a2V6FPlBCpujd8H8HeyvaGuHfqF5ipbq+BS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790019095; c=relaxed/simple;
	bh=L9t9LVARten1iwmjL739azvMH1M9ooRrH0gtIrmYCWk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O83zdJOCVS5iqGcr5mvYKMscNbedvg/O4XXwwff6oo7dphglPryHjRtOoD0xvoAiQ5FFTd6mx0yexZu9mtSIwSZ1hqq86FEC0janPtQ4PCCO5HnPjctMf8nGXtFGIXHKBxRpgMClaGV7wDw+uGuFj6tVrTPG7EX7VtF6Hm30iPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=me/lfJYe; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="me/lfJYe"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id BEEF81A0E97;
	Mon, 21 Sep 2026 19:31:31 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 91EFF5FFB2;
	Mon, 21 Sep 2026 19:31:31 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4848010328D5D;
	Mon, 21 Sep 2026 21:31:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1790019090; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=rUmp8OZq8/U25SwVy/z19uf2fjfI5fsBRo+TQXAZzXs=;
	b=me/lfJYe3P+2EiTVLF+COgR2X/91o5ueMK9M4jxJK1tD/WdpP5wxJX4/bgZTCFHQ6FE+6F
	J8pxBTmISfBVM6LjPamWEoyxQcr9Q92WeKuhHWwupGbgirMThjplCHbtlkryqikQrVQxn1
	ZnS0m/VjSanuhCmrTlQxF9XLmFN1Keh8906jpXKfy/rylMokOZ1mauU8ZwXwiJZsMciEqo
	FxKXMB5FP+xCI44N6xZ8xR3/R/kJ1cOprk/a8M4W+3ieFGXyEe537QP5aW5iFcqP3lruzj
	qDclryikaos5d5GuxmRjgcJ0bXuOGiVsH5Yn/VjyCejOp+YCKQ3txlqMoLvjJw==
Date: Mon, 21 Sep 2026 21:31:29 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Wake Liu <wakel@google.com>
Cc: Shuah Khan <shuah@kernel.org>, linux-rtc@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests: rtc: Support harness test filtering and
 arguments
Message-ID: <2026092119312953871857@mail.local>
References: <20260910034821.2935214-1-wakel@google.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260910034821.2935214-1-wakel@google.com>
X-Last-TLS-Session-Version: TLSv1.3

On 10/09/2026 03:48:21+0000, Wake Liu wrote:
> rtctest implements its own main() function with a rigid switch (argc)
> check that only accepts an optional single argument for the RTC device
> node path. This prevents kselftest_harness standard arguments from
> working properly:
> 
> 1. Passing filter options like -t <name> or -T <name> triggers a usage
>    error because argc is greater than 2.
> 2. Passing -l or -h causes rtctest to treat "-l" or "-h" as the device
>    node path and fail with access() errors before ever reaching the
>    harness argument checker.
> 
> Parse command line arguments with getopt() to pass all kselftest harness
> options (such as -t, -T, -v, -V, -f, -F, -r, -d, -h, and -l) through to
> test_harness_run(), while preserving the ability to specify an optional
> RTC device node path as a non-option argument. Also ensure optind is
> reset before invoking test_harness_run() so the harness can inspect the
> options, and bypass device accessibility checks when help or test
> listing is requested.
> 
> Signed-off-by: Wake Liu <wakel@google.com>

Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
