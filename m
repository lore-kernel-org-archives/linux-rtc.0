Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDFCE4AA56F;
	Fri, 18 Sep 2026 11:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789732048; cv=none; b=jDQU9U64+ZsS6HGSyLJGBrndQTFBP5ZRm0fsDzQZCwijjtBvDAVgkoKbWMN5UHgZWX4/SvdKCa44xGwto7ZyZcE7mU44Zh07lf2xSDZlZqffKbIjLTmyId1ezOYNjVQ8UzVWXGRwrW9d7PZxfQPToKPD9jik3kkTRqky7EuV0eM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789732048; c=relaxed/simple;
	bh=6bVLEv856d4jJWZ89HTZhQywutofaah8jI5sHks9NKo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hBjFZeWy0QK/CwkjTqMrSk/bUTxq0sC8YUh3SK5ea3poo0uDIdgrOtcBN6dV9AqP2BxdtRh5/Bs9k/UWyucN7ZhGARQl0CMEBytsL7Ws1ToQvUWGJMYhuyBOOq2gjRVZnvahkOIOfEbPTPg4mZIGMCZyzX6Kq2cKwOYiPjv9v0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V2PxFxEL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V2PxFxEL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F8531F000FF;
	Fri, 18 Sep 2026 11:47:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789732046;
	bh=zE9Hol5W0Rh1lJT2GJiCCSTpTuhmnmJkeFueZrsNTT4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=V2PxFxELXPOhcxZV6isnkG5MVQXX9m7gBGa4ddUD3p+XeCcVP1mCxvI9XUY9i0Pjm
	 9laeeO8y/jLpHl0UuIMfKYWc9WH732l1NXD+ylJIIfKfv1uSE3BlSyzovERlziKDcc
	 7hplXNVEbLZio6PG18aMu1wvgo1PlL/Ra103RuUC0oRh126j7f3sN/P41kbZh43NXG
	 yAjS3wS7LlZ86QxJ/N+KxeiYzfjqOqgx3tWEKeU+iimT5OWCJkX7S9BOuUyseUFyCZ
	 /pFYad1z3xEs6QOFbHVhYcHcfiD4nFKH9HeSm9aTolR0LHqXi8u/Zq+r0+8rMqMc8p
	 ou7QtEuWwP6iA==
Date: Fri, 18 Sep 2026 13:47:22 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Sander Speetjens <sander.speetjens@gmail.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Florian Fainelli <florian.fainelli@broadcom.com>, 
	Jonathan Bell <jonathan@raspberrypi.com>, Stefan Wahren <wahrenst@gmx.net>, linux-rtc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, Dom Cobley <popcornmix@gmail.com>
Subject: Re: [PATCH v3 2/2] rtc: Add Raspberry Pi 5 RTC driver
Message-ID: <20260918-outrageous-myrtle-giraffe-80dfdc@quoll>
References: <20260917135841.841680-1-sander.speetjens@gmail.com>
 <20260917135841.841680-3-sander.speetjens@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260917135841.841680-3-sander.speetjens@gmail.com>

On Thu, Sep 17, 2026 at 03:58:41PM +0200, Sander Speetjens wrote:
> +	return devm_rtc_register_device(vrtc->rtc);
> +}
> +
> +static const struct of_device_id rpi_rtc_dt_match[] = {
> +	{ .compatible = "raspberrypi,firmware-rtc"},

Please fixup white space issues, see existing drivers (missing space
before }

> +	{},

and unnecessary ,.

Just take existing latest code as starting point, otherwise you
reintroduce discouraged patterns.

More important: undocumented ABI.

Please run scripts/checkpatch.pl on the patches and fix reported
warnings. After that, run also 'scripts/checkpatch.pl --strict' on the
patches and (probably) fix more warnings. Some warnings can be ignored,
especially from --strict run, but the code here looks like it needs a
fix. Feel free to get in touch if the warning is not clear.

Best regards,
Krzysztof

