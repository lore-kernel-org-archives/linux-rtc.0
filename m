Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E7C03E5A2F;
	Wed, 24 Jun 2026 21:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782335712; cv=none; b=pIwZWA2FOQ+G/BA97mRbIlqOoEi0NJCCItTDqd+8kd+thA+os9kBLIezT5hGeQ/gqzVrlij5o6IxmyFkwih44fCIxkrvy2ovALTQZYagrThgkenjL0DOvAPX0fjr4jVKh/3G9prKJFUP37tTLkjUbEdekZLRr4CbZHuJU0r4zGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782335712; c=relaxed/simple;
	bh=u3T9ZVMDbxezlgWTXbF1VDy1oNGJUNGNUO8vTdOGeQQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CP+XBtnGY6QsQ1wj9QZFd29K0/i9I87w2TS31wpo7qFOzXNdWBTbMIL0XnUcHndhpCu3QYMPtT50kn2jq2Lv7wFAgUJNJn2p3cdI3Sy/qRZNXvJLBvyVsiwcJq4nmH3TM2ww2k99pBhOkF81NFQDBD7clB5J2fO+njeAzRiMoGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=hhXXIUKo; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="hhXXIUKo"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id A0F7AC6B3B8;
	Wed, 24 Jun 2026 21:15:16 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 54321601C5;
	Wed, 24 Jun 2026 21:15:08 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 11969106C8468;
	Wed, 24 Jun 2026 23:15:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1782335707; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=cI/Cj2fgUjTciNV6wKltedKPR9n8iyr0lRTcjZrvZMA=;
	b=hhXXIUKoGEHYeOA5UtSSSi09FXGIhUw8PBaZLO1HpqzA9oWfAzJUgN68ngB8eDUYnaPjPy
	eyZWY0xsPFb9iSkL2hQDSv8/PaHwpzD+yICR2jf0xRJITZx1+hHApwCLkllMd95L2ipDqs
	VBxntIw5xZnnWbC+lxZps67DJaqfmMW11GHwTSmpYcgEpzKFUmuVM+NxNuaNX1sjfLYtxJ
	k03P2nUhpXhwd2yc/8hCnH4LZMlUEsgtNH0lySRjweDVqGRZn0fjhCEORdAwgJroS4PP2J
	HuScP2qZke2Tvnr3NAx3suhmKWaUTZjYFeqVoSzHeZZYLo4IYL7RHYJjINJn5A==
Date: Wed, 24 Jun 2026 23:15:04 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: mturquette@baylibre.com, sboyd@kernel.org,
	Akhilesh Patil <akhilesh@ee.iitb.ac.in>
Cc: linux-rtc@vger.kernel.org, linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org, akhileshpatilvnit@gmail.com,
	skhan@linuxfoundation.org
Subject: Re: [PATCH 1/1] rtc: ds1307: add support for clock provider in ds1307
Message-ID: <178233558828.1517260.11685908496996934865.b4-ty@b4>
References: <6b44b47567e418a7bc3f68b626e287b8106641f3.1755599808.git.akhilesh@ee.iitb.ac.in>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6b44b47567e418a7bc3f68b626e287b8106641f3.1755599808.git.akhilesh@ee.iitb.ac.in>
X-Last-TLS-Session-Version: TLSv1.3

On Tue, 19 Aug 2025 16:17:23 +0530, Akhilesh Patil wrote:
> Add support for square-wave output for ds1307 rtc via
> common clock framework clock provider.
> 
> tested on TI am62x SK board using ds1307 RTC hardware module.

Applied, thanks!

[1/1] rtc: ds1307: add support for clock provider in ds1307
      https://git.kernel.org/abelloni/c/18d39c71e317

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
